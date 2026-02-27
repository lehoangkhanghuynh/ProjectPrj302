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
    private String Email;
    private String Password;
    private byte Role; //auto 3 student
    private boolean status; //auto 3 student

    public UserDTO(String userId, String fullname, String Email, String Password, byte Role, boolean status) {
        this.userId = userId;
        this.fullname = fullname;
        this.Email = Email;
        this.Password = Password;
        this.Role = Role;
        this.status = status;
    }

    public UserDTO() {
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String UserId) {
        this.userId = UserId;
    }

    public String getfullname() {
        return fullname;
    }

    public void setfullname(String UserName) {
        this.fullname = UserName;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }

    public byte getRole() {
        return Role;
    }

    public void setRole(byte Role) {
        this.Role = Role;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }


}
