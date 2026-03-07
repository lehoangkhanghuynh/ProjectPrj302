package model;

import java.sql.Timestamp;

public class EnrollDTO {

    private String userId;
    private String fullname;
    private int courseId;
    private String courseName;
    private int fee;
    private Timestamp enrollDate;
    private int status;

    public EnrollDTO(String userId, String fullname, int courseId, String courseName, int fee, Timestamp enrollDate, int status) {
        this.userId = userId;
        this.fullname = fullname;
        this.courseId = courseId;
        this.courseName = courseName;
        this.fee = fee;
        this.enrollDate = enrollDate;
        this.status = status;
    }

    public EnrollDTO() {
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public int getFee() {
        return fee;
    }

    public void setFee(int fee) {
        this.fee = fee;
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
