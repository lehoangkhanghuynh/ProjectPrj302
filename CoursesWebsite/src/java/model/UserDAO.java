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
public class UserDAO {

    public UserDTO searchById(String Id) {
        UserDTO user = null;
        String sql = "SELECT * FROM dbo.Users WHERE userId = ?";
        try {
            Connection conn = DbiUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, Id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                String userId = rs.getString("userId");
                String fullname = rs.getString("fullname");
                String email = rs.getString("email");
                String password = rs.getString("password");
                byte role = rs.getByte("role");
                boolean status = rs.getBoolean("status");
                double balance = rs.getDouble("balance");

                user = new UserDTO(userId, fullname, email, password, role, status, balance);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public UserDTO login(String userName, String password) {

        UserDTO user = searchById(userName);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;

    }

    public double getBalance(String userId) throws Exception {
        String sql = "SELECT balance FROM Users WHERE userId=?";
        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("balance");
            }
        }
        return 0;
    }

    public boolean deductBalance(String userId, double amount) throws Exception {
        String sql = "UPDATE Users SET balance = balance - ? WHERE userId=? AND balance >= ?";
        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setDouble(1, amount);
            ps.setString(2, userId);
            ps.setDouble(3, amount);

            return ps.executeUpdate() > 0;
        }
    }
}
