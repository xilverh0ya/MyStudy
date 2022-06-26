package stock;

import java.util.ArrayList;
import java.util.Scanner;

import com.mysql.cj.x.protobuf.MysqlxCrud.Order;

public class StockService {
	private StockDao dao;

	public StockService() {
		dao = new StockDao();
	}

	// 상품 등록
	public void addProduct(Scanner sc) {
		System.out.println("상품 등록");
		System.out.println("상품 번호:");
		int sID = sc.nextInt();

		System.out.println("상품 이름:");
		String sName = sc.next();

		System.out.println("상품 갯수:");
		int sQTY = sc.nextInt();

		System.out.println("상품 가격:");
		int sPRICE = sc.nextInt();

		// vo에 정보 담아서 배열 추가
		Stock s = new Stock(sID, sName, sQTY, sPRICE);
		dao.insert(s);
	}
	
	// 이름으로 검색
		public void getStockByName(Scanner sc) {
			System.out.print("search name:");
			String name = sc.next();

			ArrayList<Stock> list = dao.selectByName(name);
			if (list.size() == 0) {
				System.out.println("없는 상품");
			} else {
				System.out.println(list);
			}
		}

	// 전체출력
	public void printAll() {
		ArrayList<Stock> list = dao.selectAll();
		for (Stock s : list) {
			System.out.println(s);
		}
	}
}
