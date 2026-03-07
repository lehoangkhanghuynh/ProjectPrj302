/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author HOANG KHANG PC
 */
public class UserDTO {

    private String userId;
    private String fullname;
    private String email;
    private String password;
    private byte role; //auto 3 student
    private boolean status;
    private double balance;
    private int age;
    private String location, sex, marital_status;
    public double getBalance() {
        return balance;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getMarital_status() {
        return marital_status;
    }

    public void setMarital_status(String marital_status) {
        this.marital_status = marital_status;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public UserDTO(String userId, String fullname, String email, String password, byte role, boolean status, double balance) {
        this.userId = userId;
        this.fullname = fullname;
        this.email = email;
        this.password = password;
        this.role = role;
        this.status = status;
        this.balance = balance;
    }

    public UserDTO(String userId, String fullname, String email, String password, byte role, boolean status, double balance, int age, String location, String sex, String marital_status) {
        this.userId = userId;
        this.fullname = fullname;
        this.email = email;
        this.password = password;
        this.role = role;
        this.status = status;
        this.balance = balance;
        this.age = age;
        this.location = location;
        this.sex = sex;
        this.marital_status = marital_status;
    }

    public UserDTO() {
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String UserId) {
        this.userId = UserId;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public byte getRole() {
        return role;
    }

    public void setRole(byte role) {
        this.role = role;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

}
