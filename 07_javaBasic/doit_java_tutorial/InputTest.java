package hello;

import java.util.Scanner;

public class Test1 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		// Scanner 입력 도구 클래스. 객체는 힙에 할당받아야 함.
		// 힙에 메모리 할당 연산자 new

		// 입력 도구 스캐너 생성
		Scanner sc = new Scanner(System.in);

		// next(): 공백없는 문자열 한개 입력
		System.out.println("이름을 입력하시오");
		String name = sc.next(); // 단어 한개 입력받음
		System.out.println("name:" + name);
		
		System.out.println("점수를 입력하시오");
		int score = sc.nextInt();
		
		System.out.println("평균을 입력하시오");
		double avg = sc.nextDouble();
		
		System.out.println("score:" + score);
		System.out.println("avg:" + avg);
		
		System.out.println("주소를 입력하시오");
		sc.nextLine();// 버퍼에 남은 엔터 제거
		String addr = sc.nextLine();//한줄 다시 입력받음
		System.out.println("addr:" + addr);
	}
}
 
