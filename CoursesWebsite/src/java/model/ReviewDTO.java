/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author HOANG KHANG PC
 */
public class ReviewDTO {

    private int       reviewId;
    private int       courseId;
    private String    userId;
    private int       rating;      // 1 – 5
    private String    comment;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // --- thêm từ JOIN Users (để hiển thị trên UI) ---
    private String    fullname;
    private String    avatarUrl;   // tuỳ chọn nếu bảng Users có cột này

    // ===== Constructor đầy đủ (dùng khi map từ DB) =====
    public ReviewDTO(int reviewId, int courseId, String userId,
                     int rating, String comment,
                     Timestamp createdAt, Timestamp updatedAt,
                     String fullname, String avatarUrl) {
        this.reviewId  = reviewId;
        this.courseId  = courseId;
        this.userId    = userId;
        this.rating    = rating;
        this.comment   = comment;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.fullname  = fullname;
        this.avatarUrl = avatarUrl;
    }

    // ===== Constructor tạo mới / cập nhật (từ form) =====
    public ReviewDTO(int courseId, String userId, int rating, String comment) {
        this.courseId = courseId;
        this.userId   = userId;
        this.rating   = rating;
        this.comment  = comment;
    }

    // ===== Getters =====
    public int       getReviewId()  { return reviewId;  }
    public int       getCourseId()  { return courseId;  }
    public String    getUserId()    { return userId;    }
    public int       getRating()    { return rating;    }
    public String    getComment()   { return comment;   }
    public Timestamp getCreatedAt() { return createdAt; }
    public Timestamp getUpdatedAt() { return updatedAt; }
    public String    getFullname()  { return fullname;  }
    public String    getAvatarUrl() { return avatarUrl; }

    // ===== Setters =====
    public void setReviewId (int       v) { this.reviewId  = v; }
    public void setCourseId (int       v) { this.courseId  = v; }
    public void setUserId   (String    v) { this.userId    = v; }
    public void setRating   (int       v) { this.rating    = v; }
    public void setComment  (String    v) { this.comment   = v; }
    public void setCreatedAt(Timestamp v) { this.createdAt = v; }
    public void setUpdatedAt(Timestamp v) { this.updatedAt = v; }
    public void setFullname (String    v) { this.fullname  = v; }
    public void setAvatarUrl(String    v) { this.avatarUrl = v; }

    /** Tiện ích: trả về chuỗi "★★★★☆" dựa trên rating */
    public String getStarString() {
        StringBuilder sb = new StringBuilder();
        for (int i = 1; i <= 5; i++)
            sb.append(i <= rating ? "★" : "☆");
        return sb.toString();
    }
}