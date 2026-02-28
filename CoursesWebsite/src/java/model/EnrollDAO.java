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

    // 1. Check user đã enroll khóa học chưa
    public boolean isEnrolled(String userId, int courseId) throws Exception {
        String sql = "SELECT 1 FROM Enroll WHERE userId=? AND courseId=?";
        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, userId);
            ps.setInt(2, courseId);

            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }

    // 2. Enroll khóa học (mặc định status = 0 → pending)
    public boolean enrollCourse(String userId, int courseId) throws Exception {
        String sql = "INSERT INTO Enroll(userId, courseId, status) VALUES (?, ?, 0)";
        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, userId);
            ps.setInt(2, courseId);

            return ps.executeUpdate() > 0;
        }
    }

    // 3. Update trạng thái enroll
    public boolean updateStatus(String userId, int courseId, int status) throws Exception {
        String sql = "UPDATE Enroll SET status=? WHERE userId=? AND courseId=?";
        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, status);
            ps.setString(2, userId);
            ps.setInt(3, courseId);

            return ps.executeUpdate() > 0;
        }
    }

    // 4. Lấy danh sách khóa học đã thanh toán → My Courses
    public List<CourseDTO> getMyCourses(String userId) throws Exception {
        List<CourseDTO> list = new ArrayList<>();
        String sql = "SELECT c.* FROM Course c JOIN Enroll e ON c.courseId = e.courseId WHERE e.userId=? AND e.status=1";

        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CourseDTO c = new CourseDTO();
                c.setCourseId(rs.getInt("courseId"));
                c.setTopic(rs.getString("topic"));
                c.setCourseName(rs.getString("courseName"));
                c.setFee(rs.getInt("fee"));
                c.setStatus(rs.getString("status"));
                list.add(c);
            }
        }
        return list;
    }

    // 5. Lấy trạng thái enroll của 1 khóa học
    public int getEnrollStatus(String userId, int courseId) throws Exception {
        String sql = "SELECT status FROM Enroll WHERE userId=? AND courseId=?";
        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {

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
        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("fee");
            }
        }
        return 0;
    }
}
