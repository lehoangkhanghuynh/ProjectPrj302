/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author USER
 */
public class PaymentDTO {
    private int PaymentID, UserId, CourseId, Amount;
    private String PaymentMethod, PaymentStatus;
    private Timestamp PaymentDate;

    public PaymentDTO() {
    }

    public PaymentDTO(int PaymentID, int UserId, int CourseId, int Amount, String PaymentMethod, String PaymentStatus, Timestamp PaymentDate) {
        this.PaymentID = PaymentID;
        this.UserId = UserId;
        this.CourseId = CourseId;
        this.Amount = Amount;
        this.PaymentMethod = PaymentMethod;
        this.PaymentStatus = PaymentStatus;
        this.PaymentDate = PaymentDate;
    }

    public int getPaymentID() {
        return PaymentID;
    }

    public void setPaymentID(int PaymentID) {
        this.PaymentID = PaymentID;
    }

    public int getUserId() {
        return UserId;
    }

    public void setUserId(int UserId) {
        this.UserId = UserId;
    }

    public int getCourseId() {
        return CourseId;
    }

    public void setCourseId(int CourseId) {
        this.CourseId = CourseId;
    }

    public int getAmount() {
        return Amount;
    }

    public void setAmount(int Amount) {
        this.Amount = Amount;
    }

    public String getPaymentMethod() {
        return PaymentMethod;
    }

    public void setPaymentMethod(String PaymentMethod) {
        this.PaymentMethod = PaymentMethod;
    }

    public String getPaymentStatus() {
        return PaymentStatus;
    }

    public void setPaymentStatus(String PaymentStatus) {
        this.PaymentStatus = PaymentStatus;
    }

    public Timestamp getPaymentDate() {
        return PaymentDate;
    }

    public void setPaymentDate(Timestamp PaymentDate) {
        this.PaymentDate = PaymentDate;
    }
    
}
