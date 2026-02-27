package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import utils.DbUtils;

public class PaymentDAO {
    
    public PaymentDAO() {
    }
    
    public PaymentDTO createPayment(int userId, int courseId, int amount, 
                                     String paymentMethod, Timestamp paymentDate, 
                                     String paymentStatus) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet gk = null;
        
        try {
            conn = DbUtils.getConnection();
            String sql = "INSERT INTO Payment(UserId, CourseId, Amount, PaymentMethod, PaymentDate, PaymentStatus) "
                    + "VALUES(?, ?, ?, ?, ?, ?)";
            
            ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setInt(1, userId);
            ps.setInt(2, courseId);
            ps.setInt(3, amount);
            ps.setString(4, paymentMethod);
            ps.setTimestamp(5, paymentDate);
            ps.setString(6, paymentStatus);
            
            int rows = ps.executeUpdate();
            
            if (rows > 0) {
                gk = ps.getGeneratedKeys();
                if (gk.next()) {
                    return new PaymentDTO(
                        gk.getInt(1), 
                        userId, 
                        courseId, 
                        amount, 
                        paymentMethod, 
                        paymentStatus, 
                        paymentDate
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (gk != null) gk.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }
}