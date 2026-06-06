package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import utils.DbiUtils;

public class PasswordResetDAO {

    public boolean insertToken(String token, String userId, String email) {
        String sql = "INSERT INTO PasswordReset (token, userId, email, expireTime) "
                   + "VALUES (?, ?, ?, DATEADD(MINUTE, 10, GETDATE()))";
        try {
            Connection conn = DbiUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, token);
            ps.setString(2, userId);
            ps.setString(3, email);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public String getEmailByToken(String token) {
        String sql = "SELECT email FROM PasswordReset WHERE token = ? AND expireTime > GETDATE()";
        try {
            Connection conn = DbiUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getString("email");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean deleteToken(String token) {
        String sql = "DELETE FROM PasswordReset WHERE token = ?";
        try {
            Connection conn = DbiUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, token);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}