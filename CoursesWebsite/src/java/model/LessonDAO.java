package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DbiUtils;

public class LessonDAO {

    public LessonDAO() {}

    // Lấy tất cả lesson theo courseId
    public List<LessonDTO> getLessonsByCourse(int courseId) throws Exception {
        List<LessonDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Lesson WHERE courseId = ? ORDER BY lessonId";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
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
        String sql = "SELECT * FROM Lesson WHERE lessonId = ?";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
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
}