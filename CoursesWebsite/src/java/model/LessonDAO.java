package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DbiUtils;

public class LessonDAO {

    public LessonDAO() {
    }

    // Lấy tất cả lesson theo courseId
    public List<LessonDTO> getLessonsByCourse(int courseId) throws Exception {
        List<LessonDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Lessons WHERE courseId = ? ORDER BY lessonId";
        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LessonDTO l = new LessonDTO();
                l.setLessonId(rs.getInt("lessonId"));
                l.setCourseId(rs.getInt("courseId"));
                l.setTitle(rs.getString("title"));
                l.setVideo(rs.getString("video"));
                l.setDuration(rs.getInt("duration"));
                l.setContent(rs.getString("content"));
                list.add(l);
            }
        }
        return list;
    }

    // Lấy 1 lesson theo lessonId
    public LessonDTO getLessonById(int lessonId) throws Exception {
        String sql = "SELECT * FROM Lessons WHERE lessonId = ?";
        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, lessonId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                LessonDTO l = new LessonDTO();
                l.setLessonId(rs.getInt("lessonId"));
                l.setCourseId(rs.getInt("courseId"));
                l.setTitle(rs.getString("title"));
                l.setVideo(rs.getString("video"));
                l.setDuration(rs.getInt("duration"));
                l.setContent(rs.getString("content"));
                return l;
            }
        }
        return null;
    }

    public int countByCourse(int courseId) throws Exception {
        String sql = "SELECT COUNT(*) FROM Lessons WHERE courseId=?";
        try ( Connection con = DbiUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public boolean addLesson(int courseId, String lessonTitle, String videoUrl) {

        String sql = "INSERT INTO Lesson(courseId, title, videoUrl) VALUES(?,?,?)";

        try {
            Connection conn = DbiUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, courseId);
            ps.setString(2, lessonTitle);
            ps.setString(3, videoUrl);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteLesson(int lessonId) {

        String sql = "DELETE FROM Lesson WHERE lessonId=?";

        try {
            Connection conn = DbiUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, lessonId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

}
