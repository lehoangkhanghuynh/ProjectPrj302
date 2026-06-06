
import java.sql.Timestamp;

public class PasswordResetDTO {

    private String token;
    private String userId;
    private String email;
    private Timestamp expireTime;

    public PasswordResetDTO() {
    }

    public PasswordResetDTO(String token, String userId, String email, Timestamp expireTime) {
        this.token = token;
        this.userId = userId;
        this.email = email;
        this.expireTime = expireTime;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Timestamp getExpireTime() {
        return expireTime;
    }

    public void setExpireTime(Timestamp expireTime) {
        this.expireTime = expireTime;
    }
}
