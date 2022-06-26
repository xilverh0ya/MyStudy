package jdbc;

import java.util.Scanner;

import stock.StockService;
import cart.CartService;

public class Menu {
	private Service service;
	private StockService sservice;
	private CartService cservice;

	public Menu() {
		service = new Service();
		sservice = new StockService();
		cservice = new CartService();
	}

	// 상위메뉴
	public void run(Scanner sc) {
		boolean flag = true;
		int m;
		while (flag) {
			System.out.println("1.로그인 2.회원가입 3.종료");
			m = sc.nextInt();
			switch (m) {
			case 1:
				boolean x = service.Login(sc);
				if (x) {
					if (Service.mType == false) {
						runCart(sc);
					} else {
						System.out.println("관리자 계정");
						break;
					}
				}
				break;
			case 2:
				service.AddMember(sc);
				break;
			case 3:
				flag = false;
				break;
			}
		}
	}

	// 회원 주문
	public void runCart(Scanner sc) {
		boolean flag = true;
		int m = 0;
		while (flag) {
			System.out.println("1.상품 목록 2.상품명으로 검색 3.장바구니 담기 4.장바구니 목록 5.종료");
			// System.out.printAll();
			m = sc.nextInt();
			switch (m) {
			case 1:
				sservice.printAll();
				break;
			case 2:
				sservice.getStockByName(sc);
				break;
			case 3:
				cservice.addCart(sc);
				break;
			case 4:
				cservice.getCart(sc);
				break;
			case 5:
				flag = false;
				break;
			}
		}
	}
}