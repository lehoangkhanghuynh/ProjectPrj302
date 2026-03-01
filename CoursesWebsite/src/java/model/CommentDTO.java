package model;

import java.sql.Timestamp;

public class CommentDTO {

    private int commentId;
    private int lessonId;
    private String userId;
    private String content;
    private Timestamp createdAt;
    private String username; // JOIN từ bảng users

    public CommentDTO() {
    }

    public CommentDTO(int commentId, int lessonId, String userId, String content, Timestamp createdAt, String username) {
        this.commentId = commentId;
        this.lessonId = lessonId;
        this.userId = userId;
        this.content = content;
        this.createdAt = createdAt;
        this.username = username;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int v) {
        this.commentId = v;
    }

    public int getLessonId() {
        return lessonId;
    }

    public void setLessonId(int v) {
        this.lessonId = v;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String v) {
        this.userId = v;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String v) {
        this.content = v;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp v) {
        this.createdAt = v;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String v) {
        this.username = v;
    }
}
