package model;

import java.sql.*;
import java.util.*;
import utils.DbiUtils;

public class PaymentDAO {

    // ===== CREATE =====
    public static int create(PaymentDTO p) throws Exception {

        String sql = "INSERT INTO Payment(userId, courseId, amount, paymentMethod, paymentStatus) "
                   + "OUTPUT INSERTED.paymentId "
                   + "VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = prepareAndExecute(ps, p)) {

            if (rs.next()) return rs.getInt(1);
        }
        return -1;
    }

    private static ResultSet prepareAndExecute(PreparedStatement ps, PaymentDTO p) throws Exception {
        ps.setString(1, p.getUserId());
        ps.setInt(2, p.getCourseId());
        ps.setInt(3, p.getAmount());
        ps.setString(4, p.getPaymentMethod());
        ps.setString(5, p.getPaymentStatus());
        return ps.executeQuery();
    }

    // ===== GET BY ID =====
    public static PaymentDTO getById(int id) throws Exception {
        String sql = "SELECT * FROM Payment WHERE paymentId = ?";

        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }
        }
        return null;
    }

    // ===== CONFIRM =====
    public static void confirm(int id) throws Exception {
        String sql = "UPDATE Payment SET paymentStatus='SUCCESS', paymentDate=GETDATE() WHERE paymentId=?";

        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    // ===== LIST PENDING =====
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

    private static PaymentDTO map(ResultSet rs) throws Exception {
        return new PaymentDTO(
                rs.getInt("paymentId"),
                rs.getString("userId"),
                rs.getInt("courseId"),
                rs.getInt("amount"),
                rs.getString("paymentMethod"),
                rs.getTimestamp("paymentDate"),
                rs.getString("paymentStatus"),
                rs.getTimestamp("createdAt")
        );
    }
}