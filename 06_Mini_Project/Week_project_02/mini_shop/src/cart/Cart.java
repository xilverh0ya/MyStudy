package cart;

import stock.StockDao;

public class Cart {
	StockDao s = new StockDao();
	private int cNUM;
//	private String cmID;
//	private int csID;
	private String cNAME;
	private int cQTY;
	private int cPRICE;
	private boolean cSTATUS;
	

	public Cart() {
	}
//	cNUM, cNAME, cQTY, cPRICE, cSTATUS
	public Cart(int cNUM, String cNAME, int cQTY, int cPRICE, boolean cSTATUS) {
		this.cNUM = cNUM;
		this.cNAME = cNAME;
		this.cQTY = cQTY;
		this.cPRICE = cPRICE;
		this.cSTATUS = cSTATUS;
	}
	
	public Cart(String cNAME, int cPRICE, int cQTY) {
		this.cNAME = cNAME;
		this.cQTY = cQTY;
		this.cPRICE = cPRICE;
	}

	public Cart(String cNAME, int cQTY, boolean cSTATUS) {
		
//		this.cmID = cmID;
//		this.csID = csID;
		this.cNAME = cNAME;
		this.cQTY = cQTY;
		this.cSTATUS = cSTATUS;
	}

	public int getcNUM() {
		return cNUM;
	}

	public void setcNUM(int cNUM) {
		this.cNUM = cNUM;
	}

//	public String getCmID() {
//		return cmID;
//	}
//
//	public void setCmID(String cmID) {
//		this.cmID = cmID;
//	}
//
//	public int getCsID() {
//		return csID;
//	}
//
//	public void setCsID(int csID) {
//		this.csID = csID;
//	}

	public String getcNAME() {
		return cNAME;
	}

	public void setcNAME(String cNAME) {
		this.cNAME = cNAME;
	}

	public int getcQTY() {
		return cQTY;
	}

	public void setcQTY(int cQTY) {
		this.cQTY = cQTY;
	}

	public int getcPRICE() {
		return cPRICE;
	}


	public void setcPRICE(int cPRICE) {
		this.cPRICE = cPRICE;
	}
	
	public int gettotalPRICE() {
		return s.selectPrice(cNAME) * cQTY;
	}

	public boolean iscSTATUS() {
		return cSTATUS;
	}

	public void setcStatus(boolean cSTATUS) {
		this.cSTATUS = cSTATUS;
	}

	@Override
	public String toString() {
		return "  장바구니 [주문번호 : " + cNUM  + ", 상품명 : " + cNAME + ", 수량 : " + cQTY
				+ ", 총 가격 : " + cPRICE + ", 결제 여부 : " + cSTATUS + "]\n";
	}

}