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

    // ================= HELPER: map 1 row -> CourseDTO (có img) =================
    private CourseDTO mapRow(ResultSet rs) throws Exception {
        CourseDTO c = new CourseDTO();
        c.setCourseId(rs.getInt("courseId"));
        c.setTopic(rs.getString("topic"));
        c.setCourseName(rs.getString("courseName"));
        c.setFee(rs.getDouble("fee"));
        c.setStatus(rs.getString("status"));
        try {
            c.setImg(rs.getString("img"));
        } catch (Exception ignored) {
        }
        return c;
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
                result.add(mapRow(rs));
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
                result.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // ================= SEARCH BY ID =================
    public CourseDTO searchByIDc(int id) {
        ArrayList<CourseDTO> list = searchByColumn("courseId", String.valueOf(id));
        if (!list.isEmpty()) {
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
            ps.setString(5, "active");
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
                    + "SET topic = ?, courseName = ?, fee = ?, status = ? "
                    + "WHERE courseId = ? AND userId = ?";
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

    // update danh cho admin
    public boolean adminUpdate(CourseDTO c) {
        int result = 0;
        try {
            Connection conn = DbiUtils.getConnection();
            String sql = "UPDATE Course "
                    + "SET topic = ?, courseName = ?, fee = ?, status = ? "
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
    public boolean softDelete(String id, String userId) {
        int result = 0;
        try {
            Connection conn = DbiUtils.getConnection();
            String sql = "UPDATE Course SET status = 0 WHERE courseId = ? AND userId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ps.setString(2, userId);
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return result > 0;
    }

    public boolean adminSoftDelete(String id) {
        int result = 0;
        try {
            Connection conn = DbiUtils.getConnection();
            String sql = "UPDATE Course SET status = 'deleted' WHERE courseId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return result > 0;
    }

    // ================= ADMIN APPROVE (MỚI) =================
    public boolean adminApprove(String id) {
        int result = 0;
        try {
            Connection conn = DbiUtils.getConnection();
            String sql = "UPDATE Course SET status = 'active' WHERE courseId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            result = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result > 0;
    }

    // ================= GET ALL =================
    public ArrayList<CourseDTO> getAll() {
        ArrayList<CourseDTO> list = new ArrayList<>();
        try {
            Connection conn = DbiUtils.getConnection();
            String sql = "SELECT * FROM Course WHERE status = 'active'";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
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
            String sql = "SELECT c.courseId, c.topic, c.courseName, c.fee, c.status, c.img "
                    + "FROM Course c "
                    + "JOIN UserCourse uc ON c.courseId = uc.courseId "
                    + "WHERE uc.userId = ? AND uc.status = 'active'";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
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
            String sql = "SELECT c.courseId, c.topic, c.courseName, c.fee, c.status, c.img, "
                    + "c.instructorId, "
                    + "COUNT(e.userId) AS totalStudents "
                    + "FROM Course c "
                    + "LEFT JOIN Enroll e ON c.courseId = e.courseId "
                    + "GROUP BY c.courseId, c.topic, c.courseName, c.fee, c.status, c.img, c.instructorId"; // ✅ thêm
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CourseDTO c = mapRow(rs);
                c.setTotalStudents(rs.getInt("totalStudents"));
                c.setInstructorId(rs.getString("instructorId"));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getLastInsertedCourseId(String instructorId) throws Exception {
        String sql = "SELECT TOP 1 courseId FROM Course WHERE instructorId = ? ORDER BY courseId DESC";
        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, instructorId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("courseId");
            }
        }
        return -1;
    }

    // ================= GET COURSES BY INSTRUCTOR =================
    public List<CourseDTO> getCoursesByInstructor(String userId) {
        List<CourseDTO> list = new ArrayList<>();
        String sql = "SELECT courseId, topic, courseName, fee, status, img "
                + "FROM Course WHERE instructorId = ?";
        try {
            Connection conn = DbiUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean createCourse(String topic, String courseName, double fee, String userId) {
        return createCourse(topic, courseName, fee, userId, null, "active");
    }

    public boolean createCourse(String topic, String courseName, double fee, String userId, String imgPath) {
        return createCourse(topic, courseName, fee, userId, imgPath, "active");
    }

    // ================= CREATE COURSE =================
    public boolean createCourse(String topic, String courseName, double fee, String userId, String imgPath, String status) {
        try {
            Connection conn = DbiUtils.getConnection();
            String sql = "INSERT INTO Course(topic, courseName, fee, instructorId, img, status) VALUES(?,?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, topic);
            ps.setString(2, courseName);
            ps.setDouble(3, fee);
            ps.setString(4, userId);
            ps.setString(5, imgPath);
            ps.setString(6, (status != null && !status.isEmpty()) ? status : "active");
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<String> getReviewsByCourse(int courseId) {
        List<String> list = new ArrayList<>();
        String sql = "SELECT comment FROM CourseReview WHERE courseId=?";
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

    public List<CourseDTO> searchByKeyword(String keyword) {
        return filterByColumn("courseName", keyword);
    }

    public boolean deleteCourseByInstructor(int courseId, String userId) {
        String sql = "UPDATE Course SET status = 'deleted' WHERE courseId = ? AND instructorId = ?";
        try ( Connection conn = DbiUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ps.setString(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ================= INSTRUCTOR DASHBOARD STATS =================
    public double[] getInstructorStats(String userId) {
        double[] stats = {0, 0, 0, 0};
        String sql = "SELECT "
                + "  COUNT(DISTINCT c.courseId)                AS totalCourses, "
                + "  COUNT(DISTINCT e.userId)                  AS totalStudents, "
                + "  COALESCE(SUM(c.fee), 0)                   AS totalRevenue, "
                + "  COALESCE(AVG(CAST(r.rating AS FLOAT)), 0) AS avgRating "
                + "FROM Course c "
                + "LEFT JOIN Enroll e ON c.courseId = e.courseId "
                + "LEFT JOIN CourseReview r ON c.courseId = r.courseId "
                + "WHERE c.instructorId = ?";
        try ( Connection conn = DbiUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                stats[0] = rs.getInt("totalCourses");
                stats[1] = rs.getInt("totalStudents");
                stats[2] = rs.getDouble("totalRevenue");
                stats[3] = rs.getDouble("avgRating");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return stats;
    }

    // ================= UPDATE COURSE (cho instructor) =================
    public boolean updateCourse(int courseId, String topic, String courseName, double fee) {
        String sql = "UPDATE Course SET topic=?, courseName=?, fee=? WHERE courseId=?";
        try ( Connection conn = DbiUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
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

    public CourseDTO searchByID(String id) {
        return searchByIDc(Integer.parseInt(id));
    }

    public boolean updateCourseStatus(int courseId, String instructorId, String newStatus) {
        String sql = "UPDATE course SET status = ? WHERE courseId = ? AND instructorId = ?";
        try ( Connection con = utils.DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, courseId);
            ps.setString(3, instructorId); // ← String thay vì int
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
