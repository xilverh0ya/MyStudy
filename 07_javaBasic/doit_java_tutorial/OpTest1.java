package hello;

public class OpTest1 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int a = 10;
		a++; // a=a+1
		System.out.println("a:" + a);

		a = 10;
		int b = 0;
		b = a++; // a:11, b:10
		System.out.println("a:" + a + ", b:" + b);
		b = ++a; // a:12, b:12
		System.out.println("a:" + a + ", b:" + b);

		System.out.println("a++:" + a++); // 출력:12, a: 13
		System.out.println("++a:" + (++a)); // 출력:14, a: 14

		char gender = 'm';
		int age = 30;
		System.out.println(gender == 'm' && age > 30);
		System.out.println(gender == 'm' || age > 30);

		int x = 9;
		String res = (x > 10) ? "x>10" : "x<=10";
		System.out.println("res:" + res);

		int num = 4;
		// 삼항 연산자 활용해서 num이 짝수/홀수 출력
		res = (num % 2 == 0) ? "even" : "odd";
		System.out.println(num + "은 " + res);
	}

}
