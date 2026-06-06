package model;

import java.sql.*;
import java.util.*;
import utils.DbiUtils;

public class PaymentDAO {

    // ===== CREATE =====
    public static int create(PaymentDTO p) throws Exception {
        String sql = "INSERT INTO Payment(userId, amount, paymentMethod, paymentDate, paymentStatus, isTopup) "
                + "OUTPUT INSERTED.paymentId "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getUserId());
            ps.setInt(2, p.getAmount());
            ps.setString(3, p.getPaymentMethod());
            ps.setTimestamp(4, p.getPaymentDate());
            ps.setString(5, p.getPaymentStatus());
            ps.setBoolean(6, p.isTopup());
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return -1;
    }

    // ===== GET BY ID =====
    public static PaymentDTO getById(int id) throws Exception {
        String sql = "SELECT * FROM Payment WHERE paymentId = ?";
        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }
        }
        return null;
    }

    // ===== USER CLICKS "ĐÃ THANH TOÁN" (chờ admin) =====
    public static void setPendingConfirm(int id) throws Exception {
        String sql = "UPDATE Payment SET paymentStatus='PENDING_CONFIRM' "
                + "WHERE paymentId=? AND paymentStatus='PENDING'";
        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    // ===== SEPAY WEBHOOK: cộng balance + SUCCESS trong 1 transaction =====
    public static void confirmAndAddBalance(int paymentId, String userId, int amount) throws Exception {
        String sqlPayment = "UPDATE Payment SET paymentStatus='SUCCESS', paymentDate=GETDATE() "
                + "WHERE paymentId=? AND paymentStatus IN ('PENDING','PENDING_CONFIRM')";
        String sqlBalance = "UPDATE Users SET balance = balance + ? WHERE userId = ?";

        Connection con = null;
        try {
            con = DbiUtils.getConnection();
            con.setAutoCommit(false); // ── BẮT ĐẦU TRANSACTION ──

            // 1. Update payment status
            try ( PreparedStatement ps = con.prepareStatement(sqlPayment)) {
                ps.setInt(1, paymentId);
                int rows = ps.executeUpdate();
                if (rows == 0) {
                    // Đã được xử lý rồi (duplicate webhook) — rollback an toàn
                    con.rollback();
                    return;
                }
            }

            // 2. Cộng balance vào user
            try ( PreparedStatement ps = con.prepareStatement(sqlBalance)) {
                ps.setInt(1, amount);
                ps.setString(2, userId);
                ps.executeUpdate();
            }

            con.commit(); // ── COMMIT ──

        } catch (Exception e) {
            if (con != null) {
                con.rollback();
            }
            throw e;
        } finally {
            if (con != null) {
                con.setAutoCommit(true);
                con.close();
            }
        }
    }

    // ===== ADMIN CONFIRMS THỦ CÔNG → SUCCESS =====
    public static void confirm(int id) throws Exception {
        // Lấy payment trước để biết userId + amount
        PaymentDTO p = getById(id);
        if (p == null) {
            throw new Exception("Payment not found: " + id);
        }
        confirmAndAddBalance(id, p.getUserId(), p.getAmount());
    }

    // ===== ADMIN HỦY GIAO DỊCH =====
    public static void cancel(int id) throws Exception {
        String sql = "UPDATE Payment SET paymentStatus='CANCELLED' "
                + "WHERE paymentId=? AND paymentStatus IN ('PENDING','PENDING_CONFIRM')";
        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    // ===== LIST PENDING_CONFIRM (admin panel) =====
    public static List<PaymentDTO> getPendingConfirm() throws Exception {
        List<PaymentDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Payment WHERE paymentStatus='PENDING_CONFIRM' ORDER BY paymentId DESC";
        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }

    // ===== LIST PENDING VIETQR =====
    public static List<PaymentDTO> getPendingVietQR() throws Exception {
        List<PaymentDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Payment WHERE paymentStatus='PENDING' AND paymentMethod='VIETQR'";
        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }
    public static void addBalanceToUser(String userId, int amount) throws Exception {
        String sql = "UPDATE Users SET balance = balance + ? WHERE userId = ?";
        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, amount);
            ps.setString(2, userId);
            ps.executeUpdate();
        }
    }

    // ===== ALL PAYMENTS (admin) =====
    public static List<PaymentDTO> getAllPayments() throws Exception {
        List<PaymentDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Payment ORDER BY paymentDate DESC";
        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }

    // ===== MAP ResultSet → DTO =====
    private static PaymentDTO map(ResultSet rs) throws Exception {
        return new PaymentDTO(
                rs.getInt("paymentId"),
                rs.getString("userId"),
                rs.getInt("amount"),
                rs.getString("paymentMethod"),
                rs.getTimestamp("paymentDate"),
                rs.getString("paymentStatus"),
                rs.getBoolean("isTopup")
        );
    }
    
    public static double getTotalRevenue() throws Exception {
    String sql = "SELECT ISNULL(SUM(amount), 0) FROM Payment WHERE paymentStatus = 'SUCCESS'";
    try (Connection con = DbiUtils.getConnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        if (rs.next()) return rs.getDouble(1);
    }
    return 0;
}
}
