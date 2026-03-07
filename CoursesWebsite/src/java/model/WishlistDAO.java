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

}
