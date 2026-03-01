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

    public boolean checkEmailExist(String email) throws Exception {

        String sql = "SELECT email "
                + "FROM Users "
                + "WHERE email = ?";

        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            return rs.next();
        }
    }

    public boolean checkUsernameExist(String userName) throws Exception {

        String sql = "SELECT userId "
                + "FROM Users "
                + "WHERE userId = ?";

        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, userName);
            ResultSet rs = ps.executeQuery();

            return rs.next();
        }
    }

    public boolean insertUser(UserDTO u) throws Exception {

        String sql = "INSERT INTO Users(userId, fullname, email, password, role, status, balance) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, u.getUserId());
            ps.setString(2, u.getFullname());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getPassword());
            ps.setByte(5, u.getRole());
            ps.setBoolean(6, u.isStatus());
            ps.setDouble(7, u.getBalance());

            return ps.executeUpdate() > 0;
        }
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

    public boolean updateUser(String userId, String fullname, String email) throws Exception {
        String sql = "UPDATE Users SET fullname=?, email=? WHERE userId=?";
        int result = 0;
        try ( Connection conn = DbiUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullname);
            ps.setString(2, email);
            ps.setString(3, userId);
            result = ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result > 0;
    }

    public boolean updatePassWord(String userId, String newPassword, String oldPassword) throws Exception {
        String sql = "UPDATE Users SET password=? WHERE userId=? AND password=?";
        int result = 0;
        try ( Connection conn = DbiUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, userId);
            ps.setString(3, oldPassword); // thêm tham số mật khẩu cũ
            result = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result > 0;
    }
}
