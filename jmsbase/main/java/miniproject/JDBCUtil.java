package miniproject;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class JDBCUtil {
	public static Connection getConnection() {
		Connection conn = null;
		String driver = "oracle.jdbc.driver.OracleDriver";
		try {
			Class.forName(driver);
			
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String user = "scott";
			String password = "tiger";
			
			conn = DriverManager.getConnection(url, user, password);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		try {
			if (rs != null) rs.close();
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void close(Connection conn, PreparedStatement pstmt) {
		try {
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
