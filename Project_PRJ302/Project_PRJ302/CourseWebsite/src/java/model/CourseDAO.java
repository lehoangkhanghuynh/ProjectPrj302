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
import utils.DbUtils;

/**
 *
 * @author dell
 */
public class CourseDAO {

    public ArrayList<CourseDTO> getAllCourses() {
        ArrayList<CourseDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Course WHERE Status = 'ACTIVE'";

        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CourseDTO c = new CourseDTO(
                        rs.getInt("CourseId"),
                        rs.getString("Topic"),
                        rs.getString("CourseName"),
                        rs.getInt("Fee"),
                        rs.getString("Status")
                );
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<CourseDTO> getCoursesByUser(int userId) {
        List<CourseDTO> list = new ArrayList<>();
        String sql = "SELECT c.CourseID, c.Title, c.Description, c.Price, c.Status "
                + "FROM Enroll e "
                + "JOIN Course c ON e.CourseID = c.CourseID "
                + "WHERE e.UserID = ?";

        try ( Connection con = DbUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new CourseDTO(
                        rs.getInt("CourseId"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getDouble("Price"),
                        rs.getString("Status")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
