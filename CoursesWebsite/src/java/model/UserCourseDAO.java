/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import utils.DbiUtils;

public class UserCourseDAO {

    // ================= REGISTER COURSE =================
    public boolean registerCourse(String userId, String courseId) {
        int result = 0;
        try {
            Connection conn = DbiUtils.getConnection();
            String sql = "INSERT INTO UserCourse(userId, courseId, status) VALUES(?,?,1)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userId);
            ps.setString(2, courseId);
            result = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result > 0;
    }

    // ================= GET COURSES BY USER =================
    public ArrayList<String> getCourseIdsByUser(String userId) {
        ArrayList<String> list = new ArrayList<>();
        try {
            Connection conn = DbiUtils.getConnection();
            String sql = "SELECT courseId FROM UserCourse WHERE userId=? AND status=1";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(rs.getString("courseId"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
