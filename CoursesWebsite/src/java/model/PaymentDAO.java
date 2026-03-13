/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.*;
import java.util.*;
import utils.DbiUtils;

/**
 *
 * @author HOANG KHANG PC
 */
public class PaymentDAO {

    // ===== CREATE =====
    public static int create(PaymentDTO p) throws Exception {
        String sql = "INSERT INTO Payment(userId, amount, paymentMethod, paymentStatus, isTopup) "
                + "OUTPUT INSERTED.paymentId "
                + "VALUES (?, ?, ?, ?, ?)";
        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getUserId());
            ps.setInt(2, p.getAmount());
            ps.setString(3, p.getPaymentMethod());
            ps.setString(4, p.getPaymentStatus());
            ps.setBoolean(5, p.isTopup());
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

    // ===== USER CLICKS "ĐÃ THANH TOÁN" =====
    public static void setPendingConfirm(int id) throws Exception {
        String sql = "UPDATE Payment SET paymentStatus='PENDING_CONFIRM' "
                + "WHERE paymentId=? AND paymentStatus='PENDING'";
        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    // ===== ADMIN CONFIRMS → SUCCESS =====
    public static void confirm(int id) throws Exception {
        String sql = "UPDATE Payment SET paymentStatus='SUCCESS', paymentDate=GETDATE() "
                + "WHERE paymentId=?";
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

    // ===== ADMIN HUY GIAO DICH =====
    public static void cancel(int id) throws Exception {
        String sql = "UPDATE Payment SET paymentStatus='CANCELLED' WHERE paymentId=? AND paymentStatus IN ('PENDING','PENDING_CONFIRM')";
        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
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

    public static void addBalanceToUser(String userId, int amount) throws Exception {
        String sql = "UPDATE Users SET balance = balance + ? WHERE userId = ?";
        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, amount);
            ps.setString(2, userId);
            ps.executeUpdate();
        }
    }

    public static List<PaymentDTO> getAllPayments() throws Exception {

        List<PaymentDTO> list = new ArrayList<>();

        String sql = "SELECT * FROM Payment ORDER BY paymentDate DESC";

        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                PaymentDTO p = new PaymentDTO(
                        rs.getInt("paymentId"),
                        rs.getString("userId"),
                        rs.getInt("amount"),
                        rs.getString("paymentMethod"),
                        rs.getTimestamp("paymentDate"),
                        rs.getString("paymentStatus"),
                        rs.getBoolean("isTopup")
                );

                list.add(p);
            }
        }

        return list;
    }
    
}
