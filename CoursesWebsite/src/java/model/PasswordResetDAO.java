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
public class PasswordResetDAO {
    // thêm token vào DB
    public boolean insertToken(String token, String email) {
        String sql = "INSERT INTO PasswordReset VALUES (?, ?, DATEADD(MINUTE,5,GETDATE()))";
        try {
            Connection conn = DbiUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, token);
            ps.setString(2, email);

            int result = ps.executeUpdate();
            return result > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // lấy email từ token
    public String getEmailByToken(String token) {
        String sql = "SELECT email FROM PasswordReset WHERE token = ? AND expireTime > GETDATE()";

        try {
            Connection conn = DbiUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, token);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getString("email");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // xoá token sau khi reset
    public boolean deleteToken(String token) {
        String sql = "DELETE FROM PasswordReset WHERE token = ?";

        try {
            Connection conn = DbiUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, token);

            int result = ps.executeUpdate();
            return result > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
