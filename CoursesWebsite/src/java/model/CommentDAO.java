package model;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DbiUtils;
public class CommentDAO {
    /** Lấy danh sách comment của 1 bài học (mới nhất trước) */
    public List<CommentDTO> getCommentsByLesson(int lessonId) throws Exception {
        List<CommentDTO> list = new ArrayList<>();
        String sql = "SELECT c.commentId, c.lessonId, c.userId, c.content, c.createdAt, u.fullname " +
                     "FROM lesson_comments c " +
                     "JOIN Users u ON u.userId = c.userId " +
                     "WHERE c.lessonId = ? " +
                     "ORDER BY c.createdAt DESC";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, lessonId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CommentDTO cm = new CommentDTO();
                cm.setCommentId(rs.getInt("commentId"));
                cm.setLessonId(rs.getInt("lessonId"));
                cm.setUserId(rs.getString("userId"));
                cm.setContent(rs.getString("content"));
                cm.setCreatedAt(rs.getTimestamp("createdAt"));
                cm.setUsername(rs.getString("fullname"));
                list.add(cm);
            }
        }
        return list;
    }
    /** Thêm comment mới */
    public boolean addComment(int lessonId, String userId, String content) throws Exception {
        String sql = "INSERT INTO lesson_comments (lessonId, userId, content) VALUES (?, ?, ?)";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, lessonId);
            ps.setString(2, userId);
            ps.setString(3, content);
            return ps.executeUpdate() > 0;
        }
    }
    /** Xóa comment (chỉ chủ sở hữu) */
    public boolean deleteComment(int commentId, String userId) throws Exception {
        String sql = "DELETE FROM lesson_comments WHERE commentId = ? AND userId = ?";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, commentId);
            ps.setString(2, userId);
            return ps.executeUpdate() > 0;
        }
    }
}
