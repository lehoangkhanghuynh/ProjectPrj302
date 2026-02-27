/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import utils.DbUtils;

/**
 *
 * @author ASUS
 */
public class UsersDAO {

    public UsersDTO checkLogin(String email, String password) {
        String sql = "SELECT *FROM Users WHERE Email = ? AND Password = ? AND Status = 1";
        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            UsersDTO u = null;
            if (rs.next()) {
                int UserId = rs.getInt("UserId");
                String UserName = rs.getString("UserName");
                String Email = rs.getString("Email");
                String Password = rs.getString("Password");
                int Role = rs.getInt("Role");
                int status = rs.getInt("status");
                u = new UsersDTO(UserId, UserName, Email, Password, Role, status);
            }
            System.out.println(u);
            return u;
        } catch (Exception e) {
            return null;
        }

    }

    public boolean insertUser(UsersDTO user) {
        String sql = "INSERT INTO Users(UserName, Email, Password, Role, Status) "
                + "VALUES (?, ?, ?, ?, ?)";
        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setString(1, user.getUserName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setInt(4, 3);      // mặc định USER role=3
            ps.setInt(5, 1);      // status =1 => active
           
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

}
