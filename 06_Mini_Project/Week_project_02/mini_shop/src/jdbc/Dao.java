package jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

//장바구니담기, 장바구니 목록, 결제, 타입
public class Dao {
	private MysqlConnect dbconn;

	public Dao() {
		dbconn = MysqlConnect.getInstance();
	}

	public void insert(Member m) {
		// 1. db연결
		Connection conn = dbconn.getConn();

		// 2. sql
		String sql = "insert into Member(mID, mPW, mNAME) values(?, ?, ?)";

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m.getmID());
			pstmt.setInt(2, m.getmPW());
			pstmt.setString(3, m.getmNAME());

			pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	// ID가 같은 사람 검색.
	public Member select(String mID) { // mID가 primary key
		ResultSet rs; // 검색결과 타입
		Member m = null;

		// db연결
		Connection conn = dbconn.getConn();

		// 실행할 sql문
		String sql = "select * from Member where mID=?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);

			// 매칭
			pstmt.setString(1, mID);

			// sql 실행
			rs = pstmt.executeQuery(); // 반환값은 ResultSet

			if (rs.next()) {
				String mID1 = rs.getString(1);
				int mPW = rs.getInt(2);
				boolean mType = rs.getBoolean(3);
				String mNAME = rs.getString(4);
				m = new Member(mID1, mPW, mType, mNAME);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return m;
	}

}
