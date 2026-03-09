package model;
import java.sql.*;
import java.util.*;
import utils.DbiUtils;

public class PaymentDAO {

    // ===== CREATE =====
    public static int create(PaymentDTO p) throws Exception {
        String sql = "INSERT INTO Payment(userId, courseId, amount, paymentMethod, paymentStatus, isTopup) "
                   + "OUTPUT INSERTED.paymentId "
                   + "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getUserId());
            if (p.getCourseId() != null) {
                ps.setInt(2, p.getCourseId());
            } else {
                ps.setNull(2, Types.INTEGER);
            }
            ps.setInt(3, p.getAmount());
            ps.setString(4, p.getPaymentMethod());
            ps.setString(5, p.getPaymentStatus());
            ps.setBoolean(6, p.isTopup());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return -1;
    }

    // ===== GET BY ID =====
    public static PaymentDTO getById(int id) throws Exception {
        String sql = "SELECT * FROM Payment WHERE paymentId = ?";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        }
        return null;
    }

    // ===== USER CLICKS "ĐÃ THANH TOÁN" → chờ admin xác nhận =====
    public static void setPendingConfirm(int id) throws Exception {
        String sql = "UPDATE Payment SET paymentStatus='PENDING_CONFIRM' WHERE paymentId=? AND paymentStatus='PENDING'";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    // ===== ADMIN CONFIRMS → SUCCESS =====
    public static void confirm(int id) throws Exception {
        String sql = "UPDATE Payment SET paymentStatus='SUCCESS', paymentDate=GETDATE() WHERE paymentId=?";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    // ===== LIST PENDING_CONFIRM (admin panel) =====
    public static List<PaymentDTO> getPendingConfirm() throws Exception {
        List<PaymentDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Payment WHERE paymentStatus='PENDING_CONFIRM' ORDER BY createdAt DESC";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    // ===== LIST PENDING VIETQR =====
    public static List<PaymentDTO> getPendingVietQR() throws Exception {
        List<PaymentDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Payment WHERE paymentStatus='PENDING' AND paymentMethod='VIETQR'";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    // ===== MAP ResultSet → DTO =====
    private static PaymentDTO map(ResultSet rs) throws Exception {
        int courseIdRaw = rs.getInt("courseId");
        Integer courseId = rs.wasNull() ? null : courseIdRaw;
        return new PaymentDTO(
                rs.getInt("paymentId"),
                rs.getString("userId"),
                courseId,
                rs.getInt("amount"),
                rs.getString("paymentMethod"),
                rs.getTimestamp("paymentDate"),
                rs.getString("paymentStatus"),
                rs.getTimestamp("createdAt"),
                rs.getBoolean("isTopup")
        );
    }
}
