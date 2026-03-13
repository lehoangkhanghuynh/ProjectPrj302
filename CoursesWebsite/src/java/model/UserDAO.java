/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
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

            if (rs.next()) {

                user = new UserDTO(
                        rs.getString("userId"),
                        rs.getString("fullname"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getByte("role"),
                        rs.getBoolean("status"),
                        rs.getDouble("balance"),
                        rs.getInt("age"),
                        rs.getString("location"),
                        rs.getString("sex"),
                        rs.getString("marital_status")
                );
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

        String sql = "INSERT INTO Users VALUES (?,?,?,?,?,?,?,?,?,?,?)";

        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, u.getUserId());
            ps.setString(2, u.getFullname());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getPassword());
            ps.setByte(5, u.getRole());
            ps.setBoolean(6, u.isStatus());
            ps.setDouble(7, u.getBalance());
            ps.setInt(8, u.getAge());
            ps.setString(9, u.getLocation());
            ps.setString(10, u.getSex());
            ps.setString(11, u.getMarital_status());

            return ps.executeUpdate() > 0;
        }
    }

    public UserDTO login(String userName, String password) {

        UserDTO user = null;

        String sql = "SELECT * FROM Users WHERE userId=? AND password=?";

        try ( Connection conn = DbiUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userName);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                user = new UserDTO(
                        rs.getString("userId"),
                        rs.getString("fullname"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getByte("role"),
                        rs.getBoolean("status"),
                        rs.getDouble("balance"),
                        rs.getInt("age"),
                        rs.getString("location"),
                        rs.getString("sex"),
                        rs.getString("marital_status")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
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

    public List<UserDTO> getAllUsers() {

        List<UserDTO> list = new ArrayList<>();

        String sql = "SELECT * FROM Users";

        try ( Connection conn = DbiUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                UserDTO user = new UserDTO(
                        rs.getString("userId"),
                        rs.getString("fullname"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getByte("role"),
                        rs.getBoolean("status"),
                        rs.getDouble("balance"),
                        rs.getInt("age"),
                        rs.getString("location"),
                        rs.getString("sex"),
                        rs.getString("marital_status")
                );

                list.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean blockUser(String userId) {

        String sql = "UPDATE Users SET status = 0 WHERE userId = ?";

        try ( Connection conn = DbiUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean unblockUser(String userId) {

        String sql = "UPDATE Users SET status = 1 WHERE userId = ?";

        try ( Connection conn = DbiUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updateUser(String userId, String fullname, String email, int age, String location, String sex, String marital_status) throws Exception {
        String sql = "UPDATE Users SET fullname=?, email=?, age=?, location= ?, sex = ?, marital_status = ? WHERE userId=?";
        int result = 0;
        try ( Connection conn = DbiUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullname);
            ps.setString(2, email);
            ps.setInt(3, age);
            ps.setString(4, location);
            ps.setString(5, sex);
            ps.setString(6, marital_status);

            ps.setString(7, userId);
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

    public boolean updatePasswordByEmail(String email, String password) {

        String sql = "UPDATE Users SET password = ? WHERE email = ?";

        try {
            Connection conn = DbiUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, password);
            ps.setString(2, email);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public String getFullnameByEmail(String email) {
        String name = null;
        String sql = "SELECT fullname FROM Users WHERE email = ?";

        try ( Connection conn = DbiUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                name = rs.getString("fullname");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return name;
    }

    public String getUserIdByEmail(String email) {
        String sql = "SELECT userid FROM Users WHERE email = ?";
        try {
            Connection conn = DbiUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("userid");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
