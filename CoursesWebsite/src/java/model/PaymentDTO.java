package model;

import java.sql.Timestamp;

public class PaymentDTO {

    private int paymentId;
    private String userId;
    private int courseId;
    private int amount;
    private String paymentMethod;
    private Timestamp paymentDate;
    private String paymentStatus;
    private Timestamp createdAt;

    public PaymentDTO(int paymentId, String userId, int courseId, int amount,
            String paymentMethod, Timestamp paymentDate,
            String paymentStatus, Timestamp createdAt) {
        this.paymentId = paymentId;
        this.userId = userId;
        this.courseId = courseId;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
        this.paymentDate = paymentDate;
        this.paymentStatus = paymentStatus;
        this.createdAt = createdAt;
    }

    public PaymentDTO(String userId, int courseId, int amount,
            String paymentMethod, String paymentStatus) {
        this.userId = userId;
        this.courseId = courseId;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
    }

    public int getPaymentId() {
        return paymentId;
    }

    public String getUserId() {
        return userId;
    }

    public int getCourseId() {
        return courseId;
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

    public Timestamp getCreatedAt() {
        return createdAt;
    }
}
