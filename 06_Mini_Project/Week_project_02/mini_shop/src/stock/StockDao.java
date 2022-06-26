package stock;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.cj.x.protobuf.MysqlxCrud.Order;

import jdbc.MysqlConnect;

//장바구니담기, 장바구니 목록, 결제, 타입
public class StockDao {
	private MysqlConnect dbconn;

	public StockDao() {
		dbconn = MysqlConnect.getInstance();
	}

	public void insert(Stock s) {
		// 1. db연결
		Connection conn = dbconn.getConn();

		// 2. sql
		String sql = "insert into Stock(sID, sNAME, sQTY, sPRICE) values(?, ?, ?, ?)";

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, s.getsID());
			pstmt.setString(2, s.getsNAME());
			pstmt.setInt(3, s.getsQTY());
			pstmt.setInt(4, s.getsPRICE());

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

	public ArrayList<Stock> selectByName(String sNAME) {
		ArrayList<Stock> list = new ArrayList<Stock>();
		ResultSet rs = null;
		Connection conn = dbconn.getConn();
		String sql = "select * from Stock where sNAME=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sNAME);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.add(new Stock(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4)));
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

	public ArrayList<Stock> selectAll() {
		ArrayList<Stock> list = new ArrayList<Stock>();
		ResultSet rs = null;
		Connection conn = dbconn.getConn();
		String sql = "select * from Stock";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.add(new Stock(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4)));
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
	
	public int selectPrice(String name) {
		ResultSet rs = null;
		Connection conn = dbconn.getConn();
		String sql = "select sPRICE from Stock where sNAME=?";
		int price = 0;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				price = rs.getInt(1);
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
		return price;
	}
}
