package model;

import java.sql.Timestamp;

public class PaymentDTO {

    private int paymentId;
    private String userId;
    private Integer courseId;       // nullable
    private int amount;
    private String paymentMethod;
    private Timestamp paymentDate;
    private String paymentStatus;
    private Timestamp createdAt;
    private boolean isTopup;        // true = nạp ví

    // Constructor đầy đủ (đọc từ DB)
    public PaymentDTO(int paymentId, String userId, Integer courseId, int amount,
            String paymentMethod, Timestamp paymentDate,
            String paymentStatus, Timestamp createdAt, boolean isTopup) {
        this.paymentId = paymentId;
        this.userId = userId;
        this.courseId = courseId;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
        this.paymentDate = paymentDate;
        this.paymentStatus = paymentStatus;
        this.createdAt = createdAt;
        this.isTopup = isTopup;
    }

    // Constructor nạp ví (courseId = null, isTopup = true)
    public PaymentDTO(String userId, int amount, String paymentMethod, String paymentStatus) {
        this.userId = userId;
        this.courseId = null;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.isTopup = true;
    }

    // Constructor mua khóa học (có courseId, isTopup = false)
    public PaymentDTO(String userId, int courseId, int amount, String paymentMethod, String paymentStatus) {
        this.userId = userId;
        this.courseId = courseId;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.isTopup = false;
    }

    public int getPaymentId() {
        return paymentId;
    }

    public String getUserId() {
        return userId;
    }

    public Integer getCourseId() {
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

    public boolean isTopup() {
        return isTopup;
    }
}
