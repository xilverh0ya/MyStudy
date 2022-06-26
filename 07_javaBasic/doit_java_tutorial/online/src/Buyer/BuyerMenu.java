package Buyer;

import java.sql.SQLException;
import java.util.List;
import java.util.Scanner;
import java.util.regex.Pattern;

public class BuyerMenu {
	private static final Scanner sc = new Scanner(System.in);
	
	//구매자 메뉴
    public void readMenu() throws SQLException {
        while (true) {
            System.out.print("""
                    1 : 상품 조회
                    2 : 장바구니
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
