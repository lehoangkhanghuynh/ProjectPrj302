/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class UserCourseDTO {

    private int id;
    private String userId;
    private String courseId;
    private boolean status;

    public UserCourseDTO() {
    }

    public UserCourseDTO(String userId, String courseId) {
        this.userId = userId;
        this.courseId = courseId;
        this.status = true;
    }

    public UserCourseDTO(int id, String userId, String courseId, boolean status) {
        this.id = id;
        this.userId = userId;
        this.courseId = courseId;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public String getUserId() {
        return userId;
    }

    public String getCourseId() {
        return courseId;
    }

    public boolean isStatus() {
        return status;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}
