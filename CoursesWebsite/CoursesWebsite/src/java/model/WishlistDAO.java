/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DbiUtils;

/**
 *
 * @author ASUS
 */
public class WishlistDAO {

    public WishlistDAO() {
    }

    public boolean addWishlist(String userId, int courseId) {
        String sql = "INSERT INTO Wishlist(userId, courseId) VALUES (?,?)";
        try ( Connection conn = DbiUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setInt(2, courseId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<WishlistDTO> getWishlistByUser(String userId) {
        List<WishlistDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Wishlist WHERE userId=?";
        try ( Connection conn = DbiUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                WishlistDTO w = new WishlistDTO(
                        rs.getInt("wishlistId"),
                        rs.getString("userId"),
                        rs.getInt("courseId"),
                        rs.getTimestamp("createdAt")
                );
                list.add(w);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy danh sách IDs khóa học trong wishlist của user.
     */
    public List<Integer> getWishlistIds(String userId) {
        List<Integer> ids = new ArrayList<>();
        for (WishlistDTO w : getWishlistByUser(userId)) {
            ids.add(w.getCourseId());
        }
        return ids;
    }

    /**
     * Lấy danh sách CourseDTO trong wishlist, join với bảng Course. Dùng để set
     * vào session cho navbar wishlist pill.
     */
    public List<CourseDTO> getWishlistCourses(String userId) {
        List<CourseDTO> list = new ArrayList<>();
        String sql = "SELECT c.* FROM Course c "
                + "INNER JOIN Wishlist w ON c.courseId = w.courseId "
                + "WHERE w.userId = ?";
        try ( Connection conn = DbiUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CourseDTO c = new CourseDTO();
                c.setCourseId(rs.getInt("courseId"));
                c.setCourseName(rs.getString("courseName"));
                c.setFee(rs.getDouble("fee"));
                c.setImg(rs.getString("img"));  // ← THÊM MỚI
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean deleteWishlist(int wishlistId) {
        String sql = "DELETE FROM Wishlist WHERE wishlistId=?";
        try ( Connection conn = DbiUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, wishlistId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteByUserAndCourse(String userId, int courseId) {
        String sql = "DELETE FROM Wishlist WHERE userId=? AND courseId=?";
        try ( Connection conn = DbiUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setInt(2, courseId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isInWishlist(String userId, int courseId) {
        String sql = "SELECT 1 FROM Wishlist WHERE userId=? AND courseId=?";
        try ( Connection conn = DbiUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setInt(2, courseId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
