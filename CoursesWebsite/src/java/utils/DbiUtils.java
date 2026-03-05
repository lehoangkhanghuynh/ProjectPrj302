package utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class DbiUtils {

    private static final String DB_URL
            = "jdbc:postgresql://dpg-d6kroankijhs73fq558g-a.oregon-postgres.render.com:5432/dpg_cour_render_com?sslmode=require";

    private static final String DB_USER = "dpg_cour_render_com_user";
    private static final String DB_PASSWORD = "MBWlTqxIGqdbOGYFCyoQ89oZqESY2ZiH";

    public static Connection getConnection() throws Exception {

        Class.forName("org.postgresql.Driver");

        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    public static void main(String[] args) {
        try {
            Connection conn = getConnection();
            System.out.println(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
