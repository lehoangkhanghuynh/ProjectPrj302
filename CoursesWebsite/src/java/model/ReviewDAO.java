package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import utils.DbiUtils;

public class ReviewDAO {

    public static int create(ReviewDTO r) throws Exception {
        String sql = "INSERT INTO CourseReview (courseId, userId, rating, comment) "
                + "OUTPUT INSERTED.reviewId VALUES (?, ?, ?, ?)";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, r.getCourseId());
            ps.setString(2, r.getUserId());
            ps.setInt(3, r.getRating());
            ps.setString(4, r.getComment());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return -1;
    }

    public static List<ReviewDTO> getByCourse(int courseId) throws Exception {
        List<ReviewDTO> list = new ArrayList<>();
        String sql = "SELECT r.*, u.fullname "
                + "FROM CourseReview r "
                + "JOIN Users u ON r.userId = u.userId "
                + "WHERE r.courseId = ? "
                + "ORDER BY r.createdAt DESC";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    public static ReviewDTO getByUserAndCourse(String userId, int courseId) throws Exception {
        String sql = "SELECT r.*, u.fullname "
                + "FROM CourseReview r "
                + "JOIN Users u ON r.userId = u.userId "
                + "WHERE r.userId = ? AND r.courseId = ?";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setInt(2, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        }
        return null;
    }

    public static ReviewDTO getById(int reviewId) throws Exception {
        String sql = "SELECT r.*, u.fullname "
                + "FROM CourseReview r "
                + "JOIN Users u ON r.userId = u.userId "
                + "WHERE r.reviewId = ?";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, reviewId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        }
        return null;
    }

    public static double getAvgRating(int courseId) throws Exception {
        String sql = "SELECT AVG(CAST(rating AS FLOAT)) FROM CourseReview WHERE courseId = ?";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    double v = rs.getDouble(1);
                    return rs.wasNull() ? 0.0 : v;
                }
            }
        }
        return 0.0;
    }

    public static int countByCourse(int courseId) throws Exception {
        String sql = "SELECT COUNT(*) FROM CourseReview WHERE courseId = ?";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return 0;
    }

    public static Map<Integer, Integer> getRatingDistribution(int courseId) throws Exception {
        Map<Integer, Integer> dist = new LinkedHashMap<>();
        for (int i = 5; i >= 1; i--) dist.put(i, 0);
        String sql = "SELECT rating, COUNT(*) AS cnt FROM CourseReview WHERE courseId = ? GROUP BY rating";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) dist.put(rs.getInt("rating"), rs.getInt("cnt"));
            }
        }
        return dist;
    }

    public static boolean update(int reviewId, String userId, int rating, String comment) throws Exception {
        String sql = "UPDATE CourseReview SET rating = ?, comment = ?, updatedAt = GETDATE() "
                + "WHERE reviewId = ? AND userId = ?";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, rating);
            ps.setString(2, comment);
            ps.setInt(3, reviewId);
            ps.setString(4, userId);
            return ps.executeUpdate() > 0;
        }
    }

    public static boolean delete(int reviewId, String userId) throws Exception {
        String sql = "DELETE FROM CourseReview WHERE reviewId = ? AND userId = ?";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, reviewId);
            ps.setString(2, userId);
            return ps.executeUpdate() > 0;
        }
    }

    public static boolean deleteByAdmin(int reviewId) throws Exception {
        String sql = "DELETE FROM CourseReview WHERE reviewId = ?";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, reviewId);
            return ps.executeUpdate() > 0;
        }
    }

    public static boolean isEnrolled(String userId, int courseId) throws Exception {
        String sql = "SELECT 1 FROM Enroll WHERE userId = ? AND courseId = ?";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setInt(2, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public static boolean isCompleted(String userId, int courseId) throws Exception {
        String sql = "SELECT 1 FROM Enroll WHERE userId = ? AND courseId = ? AND status = 2";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setInt(2, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public static Map<Integer, double[]> getAllCourseStats() throws Exception {
        Map<Integer, double[]> map = new HashMap<>();
        String sql = "SELECT courseId, AVG(CAST(rating AS FLOAT)) AS avgRating, COUNT(*) AS reviewCount "
                + "FROM CourseReview GROUP BY courseId";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                map.put(rs.getInt("courseId"), new double[]{
                    rs.getDouble("avgRating"),
                    rs.getInt("reviewCount")
                });
            }
        }
        return map;
    }

    private static ReviewDTO map(ResultSet rs) throws Exception {
        return new ReviewDTO(
                rs.getInt("reviewId"),
                rs.getInt("courseId"),
                rs.getString("userId"),
                rs.getInt("rating"),
                rs.getString("comment"),
                rs.getTimestamp("createdAt"),
                rs.getTimestamp("updatedAt"),
                rs.getString("fullname"),
                null  // avatarUrl — cột không tồn tại, bỏ qua
        );
    }
}