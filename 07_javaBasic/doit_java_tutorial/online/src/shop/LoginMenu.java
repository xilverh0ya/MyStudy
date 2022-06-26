package shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Scanner;

import com.mysql.cj.xdevapi.Result;

import Buyer.*;
import Seller.*;
import project.MemberDAO;
import project.MemberVO;

public class LoginMenu {
	private static final Scanner sc = new Scanner(System.in);
	
	// 로그인 메뉴
	static void readMenu() throws SQLException {
		
        while (true) {
            System.out.print("""
                    1 : 로그인
                    2 : 회원가입
                    0 : 종료하기
                    """);
            int task = sc.nextInt();

            switch (task) {
                case 0 -> {
                    return;
                }
                case 1 -> {
                	System.out.println("ID를 입력하세요 : ");
                	String input_id = sc.next();
                	System.out.println("PW를 입력하세요 : ");
                	int input_pw = sc.nextInt();
                	Login.loginCheck(input_id, input_pw);
                	
                	}
                case 2 -> {
//                	SellerMenu cm = new CartMenu(); 
//                    Cart.readMenu();
                }
                default -> readMenu();
            }
        }
    }
	
	//회원 목록 조회
    public static void getMemberList() {
        MemberDAO dao = new MemberDAO();

        List<MemberVO> memberList = dao.getMemberList();
        if (memberList.isEmpty()) {
            System.out.println("등록된 회원이 없습니다.");
        } else {
            System.out.println("현재 등록된 회원 목록입니다.");
            System.out.println("---> Member" + memberList);
        }
    }
    
	// 로그인하기
	public void Login(String id, int pw) {
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
	
	// 계정 구분(로그인 완료 후 화면 이동)
	public void loginFlag(String id) throws SQLException {
		boolean f = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = JDBCUtil.getConnection();
			String sql = "SELECT mTYPE FORM Member WHERE mID = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next() && rs.getBoolean(1) == true) {	//조회 결과가 1이면 Admin 계정
				f = true;
				// 판매자 계정 메뉴로 이동
				SellerMenu s = new SellerMenu();
				s.readMenu();
			}
			
			else {
				//구매자 계정 메뉴로 이동
				BuyerMenu b = new BuyerMenu();
				b.readMenu();
			}
		}finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
	}
}
