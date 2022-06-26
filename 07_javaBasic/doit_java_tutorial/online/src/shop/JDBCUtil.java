package shop;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JDBCUtil {
	// JDBC 연결
    public static Connection getConnection() {
    	Connection conn = null;
        try {
        	String url = "jdbc:mysql://localhost:3306/mini_shop";
        	String id = "root";
        	String pw = "1234";
        	conn = DriverManager.getConnection(url, id, pw);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }

    public static void close(PreparedStatement stmt, Connection conn) {
        // JDBC 연결 해제
        try {
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        try {
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public static void close(ResultSet rs, PreparedStatement stmt,
                             Connection conn) {
        // JDBC 연결 해제
        try {
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        try {
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        try {
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}
