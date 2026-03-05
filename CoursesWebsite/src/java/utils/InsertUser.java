package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class InsertUser {

    public static void main(String[] args) {
        try {
            Connection conn = DbiUtils.getConnection();

            String sql = "INSERT INTO Users (userId, fullname, email, password, role, status, balance) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, "U001");
            ps.setString(2, "Le Khang");
            ps.setString(3, "khang@gmail.com");
            ps.setString(4, "123456");
            ps.setInt(5, 0);      // role: user
            ps.setInt(6, 1);      // status: active
            ps.setDouble(7, 0);   // balance

            int rows = ps.executeUpdate();

            if (rows > 0) {
                System.out.println("Insert success!");
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}