package utils;

import java.sql.Connection;
import java.sql.Statement;

public class CreateTable {

    public static void main(String[] args) {
        try {
            Connection conn = DbiUtils.getConnection();

            String sql = "CREATE TABLE Users ("
                    + "userId VARCHAR(20) PRIMARY KEY,"
                    + "fullname VARCHAR(50),"
                    + "email VARCHAR(100),"
                    + "password VARCHAR(255),"
                    + "role SMALLINT,"
                    + "status SMALLINT,"
                    + "balance DECIMAL(18,2)"
                    + ")";

            Statement st = conn.createStatement();
            st.execute(sql);

            System.out.println("Create table success!");

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}