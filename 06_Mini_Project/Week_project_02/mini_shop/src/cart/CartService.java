package cart;

import java.util.ArrayList;
import java.util.Scanner;

import stock.Stock;

public class CartService {
	private CartDao dao;

	public CartService() {
		dao = new CartDao();
	}

	// 장바구니 담기
	public void addCart(Scanner sc) {
		System.out.println("장바구니에 담을 상품명:");
		String cNAME = sc.next();
		System.out.println("주문 수량:");
		int cQTY = sc.nextInt();
		boolean cSTATUS = false;
		dao.insert(new Cart(cNAME, cQTY, cSTATUS));
	}

	// 장바구니 열기
	public void getCart(Scanner sc) {
		ArrayList<Cart> list = dao.selectAll();
		if (list.size() == 0) {
			System.out.println("없는 상품");
		} else {
			System.out.println(list);
		}
	}

	public void printAll() {
		ArrayList<Cart> list = dao.selectAll();
		for (Cart c : list) {
			System.out.println(c);
		}
	}
}
