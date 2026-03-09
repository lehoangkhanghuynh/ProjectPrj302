package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.CourseDTO;
import utils.DbiUtils;

public class EnrollDAO {

    public EnrollDAO() {
    }

    public boolean isEnrolled(String userId, int courseId) throws Exception {
        String sql = "SELECT 1 FROM Enroll WHERE userId=? AND courseId=?";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setInt(2, courseId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }

    public boolean enrollCourse(String userId, int courseId) throws Exception {
        String sql = "INSERT INTO Enroll(userId, courseId, status) VALUES (?, ?, 0)";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setInt(2, courseId);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateStatus(String userId, int courseId, int status) throws Exception {
        String sql = "UPDATE Enroll SET status=? WHERE userId=? AND courseId=?";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, status);
            ps.setString(2, userId);
            ps.setInt(3, courseId);
            return ps.executeUpdate() > 0;
        }
    }

    // FIX: SELECT rõ e.status từ Enroll, bỏ filter status=1
    // để hiện cả đang học (1) và đã hoàn thành (2)
    public List<CourseDTO> getMyCourses(String userId) throws Exception {
        List<CourseDTO> list = new ArrayList<>();
        String sql = "SELECT c.courseId, c.topic, c.courseName, c.fee, e.status " +
                     "FROM Course c " +
                     "JOIN Enroll e ON c.courseId = e.courseId " +
                     "WHERE e.userId = ? AND e.status IN (1, 2)";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CourseDTO c = new CourseDTO();
                c.setCourseId(rs.getInt("courseId"));
                c.setTopic(rs.getString("topic"));
                c.setCourseName(rs.getString("courseName"));
                c.setFee(rs.getInt("fee"));
                // Enroll.status là int, CourseDTO.status là String → convert
                c.setStatus(String.valueOf(rs.getInt("status")));
                list.add(c);
            }
        }
        return list;
    }

    public int getEnrollStatus(String userId, int courseId) throws Exception {
        String sql = "SELECT status FROM Enroll WHERE userId=? AND courseId=?";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setInt(2, courseId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("status");
            }
        }
        return -1;
    }

    public double getCourseFee(int courseId) throws Exception {
        String sql = "SELECT fee FROM Course WHERE courseId=?";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("fee");
            }
        }
        return 0;
    }

    // FIX: thêm ngoặc để tránh lỗi logic SQL
    public List<Integer> getEnrolledCourseIds(String userId) throws Exception {
        List<Integer> list = new ArrayList<>();
        String sql = "SELECT courseId FROM Enroll WHERE userId=? AND (status=1 OR status=2)";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getInt("courseId"));
            }
        }
        return list;
    }

    public boolean updateStatusDone(String userId, int courseId) {
        String sql = "UPDATE Enroll SET status = 2 WHERE userId = ? AND courseId = ?";
        try (Connection conn = DbiUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setInt(2, courseId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<EnrollDTO> getAllEnrollments() {
        List<EnrollDTO> list = new ArrayList<>();
        String sql = "SELECT e.userId, u.fullname, c.courseId, c.courseName, c.fee, e.enrollDate, e.status "
                   + "FROM Enroll e "
                   + "JOIN Users u ON e.userId = u.userId "
                   + "JOIN Course c ON e.courseId = c.courseId "
                   + "ORDER BY e.enrollDate DESC";
        try (Connection conn = DbiUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                EnrollDTO e = new EnrollDTO(
                        rs.getString("userId"),
                        rs.getString("fullname"),
                        rs.getInt("courseId"),
                        rs.getString("courseName"),
                        rs.getInt("fee"),
                        rs.getTimestamp("enrollDate"),
                        rs.getInt("status")
                );
                list.add(e);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Integer> getCompletedCourseIds(String userId) throws Exception {
        List<Integer> list = new ArrayList<>();
        String sql = "SELECT courseId FROM Enroll WHERE userId=? AND status=2";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getInt("courseId"));
            }
        }
        return list;
    }
}