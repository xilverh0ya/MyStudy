package hello;

public class Test1 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		// �젙�닔���엯
		byte a = 10; //�옄�룞 �삎蹂��솚. 
		a = 11; //蹂��닔�뒗 媛� 蹂�寃쎌씠 媛��뒫
		a = 12;
		//a = "asdf"; //蹂��닔�쓽 �꽑�뼵�븳 ���엯 媛믪쑝濡� �븷�떦
		short b = 20;//�옄�룞 �삎蹂��솚. 
		int c = 30; // ���엯 蹂��닔紐�; => 硫붾え由� �븷�떦
		long d = 40l;

		// �떎�닔���엯
		//float e =  (float) 31.143;  //�삎蹂��솚
		float e =   31.143f;  //�삎蹂��솚
		double f = 23.346;

		// 臾몄옄���엯
		char g = 'a';
		String h = "apple"; // 媛앹껜 ���엯

		// 遺덈┛���엯
		boolean i = true;
		boolean j = 10>20;

		System.out.println("a:" + a);
		System.out.println("b:" + b);
		System.out.println("c:" + c);
		System.out.println("d:" + d);
		System.out.println("e:" + e);
		System.out.println("f:" + f);
		System.out.println("g:" + g);
		System.out.println("h:" + h);
		System.out.println("i:" + i);
		System.out.println("j:" + j);
	}

}
