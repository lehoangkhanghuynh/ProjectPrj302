/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author dell
 */
public class CourseDTO {
    private int CourseId;
    private String Topic;
    private String CourseName;
    private double Fee;
    private String Status;

    public CourseDTO() {
    }

    public CourseDTO(int CourseId, String Topic, String CourseName, double Fee, String Status) {
        this.CourseId = CourseId;
        this.Topic = Topic;
        this.CourseName = CourseName;
        this.Fee = Fee;
        this.Status = Status;
    }

    public int getCourseId() {
        return CourseId;
    }

    public void setCourseId(int CourseId) {
        this.CourseId = CourseId;
    }

    public String getTopic() {
        return Topic;
    }

    public void setTopic(String Topic) {
        this.Topic = Topic;
    }

    public String getCourseName() {
        return CourseName;
    }

    public void setCourseName(String CourseName) {
        this.CourseName = CourseName;
    }

    public double getFee() {
        return Fee;
    }

    public void setFee(double Fee) {
        this.Fee = Fee;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }
}
