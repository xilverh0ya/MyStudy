package shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Login {

	public static void loginCheck(String id, int pw) {
		boolean fg = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = JDBCUtil.getConnection();
			String sql = "SELECT mID, mPW FROM Member WHERE mID = ?, mPW = ?";
			
		}finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
	}
}
