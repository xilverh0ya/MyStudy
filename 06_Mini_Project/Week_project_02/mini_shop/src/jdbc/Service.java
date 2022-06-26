package jdbc;

import java.util.Scanner;

public class Service {
	private Dao dao;
	public static String LoginId = "";
	public static boolean mType = true;

	public Service() {
		dao = new Dao();
	}

	// 회원가입
	public void AddMember(Scanner sc) {
		System.out.println("회원가입");
		System.out.println("ID:");
		String mID = sc.next();
		System.out.println("PW:");
		int mPW = sc.nextInt();
		System.out.println("이름:");
		String mName = sc.next();
		dao.insert(new Member(mID, mPW, false, mName));
	}

	// 로그인
	public boolean Login(Scanner sc) {
		System.out.println("로그인");

		System.out.print("ID:");
		String mID = sc.next();
		System.out.print("PW:");
		int mPW = sc.nextInt();
		Member m = dao.select(mID);
		if (m == null) {
			System.out.println("가입되지 않은 회원");
		} else {
			if (m.getmPW()==(mPW)) {
				System.out.println("로그인 성공");
				// 로그인 처리
				LoginId = m.getmID();
				mType = m.ismType();
				return true;
				
			}
		}
		return false;
	}
}
