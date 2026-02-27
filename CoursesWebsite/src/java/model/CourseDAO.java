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

public class CourseDAO {

    public CourseDAO() {
    }

    // ================= SEARCH EXACT =================
    public ArrayList<CourseDTO> searchByColumn(String column, String value) {
        ArrayList<CourseDTO> result = new ArrayList<>();
        try {
            Connection conn = DbiUtils.getConnection();
            String sql = "SELECT * FROM Course WHERE " + column + " = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, value);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String id = rs.getString("courseId");
                String topic = rs.getString("topic");
                String name = rs.getString("courseName");
                double fee = rs.getDouble("fee");
                int status = rs.getInt("status");

                CourseDTO c = new CourseDTO(id, topic, name, fee, status);
                result.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // ================= FILTER LIKE =================
    public ArrayList<CourseDTO> filterByColumn(String column, String value) {
        ArrayList<CourseDTO> result = new ArrayList<>();
        try {
            Connection conn = DbiUtils.getConnection();
            String sql = "SELECT * FROM Course WHERE status = 1 AND " + column + " LIKE ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + value + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String id = rs.getString("courseId");
                String topic = rs.getString("topic");
                String name = rs.getString("courseName");
                double fee = rs.getDouble("fee");
                int status = rs.getInt("status");

                CourseDTO c = new CourseDTO(id, topic, name, fee, status);
                result.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // ================= SEARCH BY ID =================
    public CourseDTO searchByID(String id) {
        ArrayList<CourseDTO> list = searchByColumn("courseId", id);
        if (list.size() > 0) {
            return list.get(0);
        }
        return null;
    }

    // ================= SEARCH BY NAME =================
    public ArrayList<CourseDTO> searchByName(String name) {
        return searchByColumn("courseName", name);
    }

    public ArrayList<CourseDTO> filterByName(String name) {
        return filterByColumn("courseName", name);
    }

    // ================= ADD =================
    public boolean add(CourseDTO c) {
        int result = 0;
        try {
            Connection conn = DbiUtils.getConnection();
            String sql = "INSERT INTO Course VALUES(?,?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, c.getCourseId());
            ps.setString(2, c.getTopic());
            ps.setString(3, c.getCourseName());
            ps.setDouble(4, c.getFee());
            ps.setInt(5, 1); // status mặc định active

            result = ps.executeUpdate();

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return result > 0;
    }

    // ================= UPDATE =================
    public boolean update(CourseDTO c) {
        int result = 0;
        try {
            Connection conn = DbiUtils.getConnection();

            String sql = "UPDATE Course "
                    + "SET topic = ?, "
                    + "courseName = ?, "
                    + "fee = ?, "
                    + "status = ? "
                    + "WHERE courseId = ? "
                    + "AND userId = ?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, c.getTopic());
            ps.setString(2, c.getCourseName());
            ps.setDouble(3, c.getFee());
            ps.setInt(4, c.getStatus());
            ps.setString(5, c.getCourseId());

            result = ps.executeUpdate();

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return result > 0;
    }

    //update danh cho admin
    public boolean adminUpdate(CourseDTO c) {
        int result = 0;
        try {
            Connection conn = DbiUtils.getConnection();

            String sql = "UPDATE Course "
                    + "SET topic = ?, "
                    + "courseName = ?, "
                    + "fee = ?, "
                    + "status = ? "
                    + "WHERE courseId = ?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, c.getTopic());
            ps.setString(2, c.getCourseName());
            ps.setDouble(3, c.getFee());
            ps.setInt(4, c.getStatus());
            ps.setString(5, c.getCourseId());

            result = ps.executeUpdate();

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return result > 0;
    }

    // ================= SOFT DELETE =================
//delete danh cho user
    public boolean softDelete(String id, String userId) {
        int result = 0;
        try {
            Connection conn = DbiUtils.getConnection();

            String sql = "UPDATE Course SET status = 0 "
                    + "WHERE courseId = ? "
                    + "AND userId = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ps.setString(2, userId);

            result = ps.executeUpdate();

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return result > 0;
    }

    //delete danh cho admin
    public boolean adminSoftDelete(String id) {
        int result = 0;
        try {
            Connection conn = DbiUtils.getConnection();

            String sql = "UPDATE Course SET status = 0 WHERE courseId = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);

            result = ps.executeUpdate();

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return result > 0;
    }

    public ArrayList<CourseDTO> getAll() {
        ArrayList<CourseDTO> list = new ArrayList<>();
        try {
            Connection conn = DbiUtils.getConnection();
            String sql = "SELECT * FROM Course WHERE status = 1";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CourseDTO c = new CourseDTO(
                        rs.getString("courseId"),
                        rs.getString("topic"),
                        rs.getString("courseName"),
                        rs.getDouble("fee"),
                        rs.getInt("status")
                );
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList<CourseDTO> getCoursesByUser(String userId) {

        ArrayList<CourseDTO> list = new ArrayList<>();

        try {
            Connection conn = DbiUtils.getConnection();

            String sql = "SELECT c.courseId, c.topic, c.courseName, c.fee, c.status "
                    + "FROM Course c "
                    + "JOIN UserCourse uc ON c.courseId = uc.courseId "
                    + "WHERE uc.userId = ? AND uc.status = 1";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CourseDTO c = new CourseDTO(
                        rs.getString("courseId"),
                        rs.getString("topic"),
                        rs.getString("courseName"),
                        rs.getDouble("fee"),
                        rs.getInt("status")
                );
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
