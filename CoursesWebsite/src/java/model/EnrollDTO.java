package model;

import java.sql.Timestamp;

public class EnrollDTO {

    private String userId;
    private int courseId;
    private Timestamp enrollDate;
    private int status;

    public EnrollDTO() {
    }

    public EnrollDTO(String userId, int courseId, Timestamp enrollDate, int status) {
        this.userId = userId;
        this.courseId = courseId;
        this.enrollDate = enrollDate;
        this.status = status;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public Timestamp getEnrollDate() {
        return enrollDate;
    }

    public void setEnrollDate(Timestamp enrollDate) {
        this.enrollDate = enrollDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}