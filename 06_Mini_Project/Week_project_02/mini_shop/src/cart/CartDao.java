package cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import jdbc.Member;
import jdbc.Dao;


import jdbc.MysqlConnect;

//장바구니담기, 장바구니 목록, 결제, 타입
public class CartDao {
	private MysqlConnect dbconn;
	Member m = new Member();
	Dao d = new Dao();
	
	
	public CartDao() {
		dbconn = MysqlConnect.getInstance();
	}

	public void insert(Cart c) {
		// 1. db연결
		Connection conn = dbconn.getConn();

		// 2. sql
		String sql = "insert into Cart(cNAME, cQTY, cPRICE) values(?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, c.getcNAME());
			pstmt.setInt(2, c.getcQTY());
			pstmt.setInt(3, c.gettotalPRICE());

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
	
	//장바구니 목록
	public ArrayList<Cart> selectAll() {
		ArrayList<Cart> list = new ArrayList<Cart>();
		ResultSet rs = null;
		// 1. db연결
		Connection conn = dbconn.getConn();
		// 2. sql
		String sql = "select cNUM, cNAME, cQTY, cPRICE, cSTATUS from Cart";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				list.add(new Cart(rs.getInt(1), rs.getString(2), rs.getInt(3),
						rs.getInt(4), rs.getBoolean(5)));
			}
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
		return list;
	}
}
