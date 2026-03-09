/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author dell
 */
public class CertificateDTO {

    private int certificateId;
    private String userId;
    private int courseId;
    private Timestamp issueDate;
    private String code;

    public CertificateDTO() {
    }

    public CertificateDTO(int certificateId, String userId, int courseId, Timestamp issueDate, String code) {
        this.certificateId = certificateId;
        this.userId = userId;
        this.courseId = courseId;
        this.issueDate = issueDate;
        this.code = code;
    }

    public int getCertificateId() {
        return certificateId;
    }

    public void setCertificateId(int certificateId) {
        this.certificateId = certificateId;
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

    public Timestamp getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Timestamp issueDate) {
        this.issueDate = issueDate;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

}
