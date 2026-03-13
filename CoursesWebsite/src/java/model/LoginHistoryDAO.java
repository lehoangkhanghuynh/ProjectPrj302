/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import utils.DbiUtils;

/**
 *
 * @author HOANG KHANG PC
 */
public class LoginHistoryDAO {
     public boolean insertLogin(String userID, String ip, String userAgent) {
        String sql = "INSERT INTO LoginHistory (userID, ipAddress, userAgent) VALUES (?, ?, ?)";
        try {
            Connection conn = DbiUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userID);
            ps.setString(2, ip);
            ps.setString(3, userAgent);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Kiểm tra IP + UserAgent đã từng login chưa
    public boolean isNewDevice(String userID, String ip, String userAgent) {
        String sql = "SELECT COUNT(*) FROM LoginHistory WHERE userID = ? AND ipAddress = ? AND userAgent = ?";
        try {
            Connection conn = DbiUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userID);
            ps.setString(2, ip);
            ps.setString(3, userAgent);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1) == 0; // 0 = chưa thấy thiết bị này
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
