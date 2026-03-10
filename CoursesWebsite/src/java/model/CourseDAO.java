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
                int id = rs.getInt("courseId");
                String topic = rs.getString("topic");
                String name = rs.getString("courseName");
                double fee = rs.getDouble("fee");
                String status = rs.getString("status");

                CourseDTO c = new CourseDTO(id, topic, name, fee, status, 0);
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
            String sql = "SELECT * FROM Course WHERE status = 'active' AND " + column + " LIKE ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + value + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("courseId");
                String topic = rs.getString("topic");
                String name = rs.getString("courseName");
                double fee = rs.getDouble("fee");
                String status = rs.getString("status");

                CourseDTO c = new CourseDTO(id, topic, name, fee, status, 0);
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
            String sql = "INSERT INTO Course(topic, courseName, fee, status) VALUES(?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, c.getCourseId());
            ps.setString(2, c.getTopic());
            ps.setString(3, c.getCourseName());
            ps.setDouble(4, c.getFee());
            ps.setString(5, "active"); // status mặc định active

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
            ps.setString(4, c.getStatus());
            ps.setInt(5, c.getCourseId());

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
            ps.setString(4, c.getStatus());
            ps.setInt(5, c.getCourseId());

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
            String sql = "SELECT * FROM Course WHERE status = 'active'";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CourseDTO c = new CourseDTO(
                        rs.getInt("courseId"),
                        rs.getString("topic"),
                        rs.getString("courseName"),
                        rs.getDouble("fee"),
                        rs.getString("status"),
                        0
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
                    + "WHERE uc.userId = ? AND uc.status = active";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CourseDTO c = new CourseDTO(
                        rs.getInt("courseId"),
                        rs.getString("topic"),
                        rs.getString("courseName"),
                        rs.getDouble("fee"),
                        rs.getString("status"),
                        0
                );
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public double getCourseFee(int courseId) throws Exception {
        String sql = "SELECT fee FROM Course WHERE courseId = ?";
        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("fee");
            }
        }
        return 0;
    }

    public List<CourseDTO> getCoursesWithStudents() {

        List<CourseDTO> list = new ArrayList<>();

        try {

            Connection conn = DbiUtils.getConnection();

            String sql
                    = "SELECT c.courseId,c.topic,c.courseName,c.fee,c.status, "
                    + "COUNT(e.userId) AS totalStudents "
                    + "FROM Course c "
                    + "LEFT JOIN Enroll e ON c.courseId = e.courseId "
                    + "GROUP BY c.courseId,c.topic,c.courseName,c.fee,c.status";

            PreparedStatement ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                CourseDTO c = new CourseDTO(
                        rs.getInt("courseId"),
                        rs.getString("topic"),
                        rs.getString("courseName"),
                        rs.getDouble("fee"),
                        rs.getString("status"),
                        rs.getInt("totalStudents")
                );

                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<CourseDTO> getCoursesByInstructor(String userId) {
        List<CourseDTO> list = new ArrayList<>();
        String sql = "SELECT c.courseId, c.topic, c.courseName, c.fee, c.status "
                + "FROM Course c "
                + "JOIN Course_Instructor ci ON c.courseId = ci.courseId "
                + "JOIN Instructor i ON ci.instructorId = i.instructorId "
                + "WHERE i.userId = ?";
        try {
            Connection conn = DbiUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CourseDTO c = new CourseDTO();
                c.setCourseId(rs.getInt("courseId"));
                c.setTopic(rs.getString("topic"));
                c.setCourseName(rs.getString("courseName"));
                c.setFee(rs.getDouble("fee"));
                c.setStatus(rs.getString("status"));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean createCourse(String topic, String courseName, double fee, String userId) {
        try {
            Connection conn = DbiUtils.getConnection();

            // Lấy instructorId từ userId
            String sqlGetId = "SELECT instructorId FROM Instructor WHERE userId = ?";
            PreparedStatement ps0 = conn.prepareStatement(sqlGetId);
            ps0.setString(1, userId);
            ResultSet rs0 = ps0.executeQuery();
            if (!rs0.next()) {
                return false;
            }
            int instructorId = rs0.getInt("instructorId");

            // Tạo Course
            String sql1 = "INSERT INTO Course(topic, courseName, fee, status) VALUES(?,?,?,?)";
            PreparedStatement ps1 = conn.prepareStatement(sql1, PreparedStatement.RETURN_GENERATED_KEYS);
            ps1.setString(1, topic);
            ps1.setString(2, courseName);
            ps1.setDouble(3, fee);
            ps1.setString(4, "active");
            ps1.executeUpdate();

            ResultSet rs1 = ps1.getGeneratedKeys();
            if (rs1.next()) {
                int courseId = rs1.getInt(1);

                // Insert Course_Instructor
                String sql2 = "INSERT INTO Course_Instructor(courseId, instructorId) VALUES(?,?)";
                PreparedStatement ps2 = conn.prepareStatement(sql2);
                ps2.setInt(1, courseId);
                ps2.setInt(2, instructorId);
                ps2.executeUpdate();
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    //update danh cho instructor
    public boolean updateCourse(int courseId, String topic, String courseName, double fee) {

        String sql = "UPDATE Course SET topic=?, courseName=?, fee=? WHERE courseId=?";

        try {
            Connection conn = DbiUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, topic);
            ps.setString(2, courseName);
            ps.setDouble(3, fee);
            ps.setInt(4, courseId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<String> getReviewsByCourse(int courseId) {

        List<String> list = new ArrayList<>();

        String sql = "SELECT comment FROM Review WHERE courseId=?";

        try {
            Connection conn = DbiUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, courseId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(rs.getString("comment"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
