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
public class PaymentDTO {

    private int paymentId;
    private String userId;
    private int amount;
    private String paymentMethod;
    private Timestamp paymentDate;
    private String paymentStatus;
    private boolean isTopup;

    public PaymentDTO(int paymentId, String userId, int amount,
            String paymentMethod, Timestamp paymentDate,
            String paymentStatus, boolean isTopup) {
        this.paymentId = paymentId;
        this.userId = userId;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
        this.paymentDate = paymentDate;
        this.paymentStatus = paymentStatus;
        this.isTopup = isTopup;
    }

    public PaymentDTO(String userId, int amount, String paymentMethod, String paymentStatus) {
        this.userId = userId;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.isTopup = true;
    }

    public int getPaymentId() {
        return paymentId;
    }

    public String getUserId() {
        return userId;
    }

    public int getAmount() {
        return amount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public Timestamp getPaymentDate() {
        return paymentDate;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public boolean isTopup() {
        return isTopup;
    }

    public boolean isIsTopup() {
        return isTopup;
    }

    public void setIsTopup(boolean isTopup) {
        this.isTopup = isTopup;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public void setPaymentDate(Timestamp paymentDate) {
        this.paymentDate = paymentDate;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }
    
}
