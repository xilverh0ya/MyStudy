package Seller;

import java.sql.SQLException;
import java.util.Scanner;

public class SellerMenu {
	private static final Scanner sc = new Scanner(System.in);
	
	//판매자 메뉴
    public void readMenu() throws SQLException {
        while (true) {
            System.out.print("""
                    1 : 상품 조회
                    2 : 판매 등록
                    0 : 종료하기
                    """);
            int task = sc.nextInt();

            switch (task) {
                case 0 -> {
                    return;
                }
                case 1 -> {
//                    Lookup.readMenu();
                }
                case 2 -> {
//                    Cart.readMenu();
                }
                default -> readMenu();
            }
        }
    }
}
