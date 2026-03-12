package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import utils.DbiUtils;

public class CategoryDAO {

    public CategoryDAO() {}

    // ── Lấy toàn bộ category (cho filter chips) ───────────────────
    public List<CategoryDTO> getAll() throws Exception {
        List<CategoryDTO> list = new ArrayList<>();
        String sql = "SELECT categoryId, categoryName FROM Category";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    // ── Thêm category mới ─────────────────────────────────────────
    public boolean add(String categoryName) throws Exception {
        String sql = "INSERT INTO Category (categoryName) VALUES (?)";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, categoryName);
            return ps.executeUpdate() > 0;
        }
    }

    // ── Xóa category (hard delete) ────────────────────────────────
    public boolean delete(int categoryId) throws Exception {
        String sql = "DELETE FROM Category WHERE categoryId = ?";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            return ps.executeUpdate() > 0;
        }
    }

    // ── Gán category cho course ───────────────────────────────────
    public boolean assignToCourse(int courseId, int categoryId) throws Exception {
        String sql = "INSERT INTO Course_Category (courseId, categoryId) VALUES (?, ?)";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ps.setInt(2, categoryId);
            return ps.executeUpdate() > 0;
        }
    }

    // ── Bỏ category khỏi course ───────────────────────────────────
    public boolean removeFromCourse(int courseId, int categoryId) throws Exception {
        String sql = "DELETE FROM Course_Category WHERE courseId = ? AND categoryId = ?";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ps.setInt(2, categoryId);
            return ps.executeUpdate() > 0;
        }
    }

    // ── Map courseId → categoryName (primary category) cho filter ─
    // Mỗi course lấy 1 category có categoryId nhỏ nhất (primary)
    public Map<Integer, String> getCourseCategoryMap() throws Exception {
        Map<Integer, String> map = new java.util.LinkedHashMap<>();
        String sql = "SELECT cc.courseId, c.categoryName "
                   + "FROM Course_Category cc "
                   + "JOIN Category c ON cc.categoryId = c.categoryId "
                   + "ORDER BY cc.courseId, cc.categoryId ASC";
        try (Connection con = DbiUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int courseId = rs.getInt("courseId");
                // putIfAbsent: chỉ giữ category đầu tiên (primary)
                map.putIfAbsent(courseId, rs.getString("categoryName").toLowerCase());
            }
        }
        return map;
    }

    // ── Helper ────────────────────────────────────────────────────
    private CategoryDTO mapRow(ResultSet rs) throws Exception {
        return new CategoryDTO(
            rs.getInt("categoryId"),
            rs.getString("categoryName")
        );
    }
}