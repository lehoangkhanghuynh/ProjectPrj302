/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import utils.DbiUtils;

/**
 *
 * @author HOANG KHANG PC
 */
public class ReviewDAO {
    
    public boolean addReview(String userId, int courseId, Byte rating, String comment, Timestamp createdAt){
        int result = 0;
    String sql = "INSERT INTO Reviews(userId, courseId, rating, comment, createdAt) VALUES (?, ?, GETDATE())";
        try(Connection conn = DbiUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setInt(2, courseId);
            ps.setByte(3, rating);
            ps.setString(4, comment);
            ps.setTimestamp(5, createdAt);
            result = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result > 0;
    }
}
