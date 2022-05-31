package hello;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Assignment02_printTri {

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		System.out.println("숫자를 입력하시오 : ");
		
		// 버퍼로 입력 받기
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		
		// 입력받은 값 int 형 변환
		int n = Integer.parseInt(br.readLine());
		
		// 1. 크기 : 확장, 좌측정렬
		System.out.println("[ 1번 결과 ]");
		for (int i = 0 ; i < n ; i++ ) {
			for(int j = i + 1 ; j > 0 ; j--) {
				System.out.print("*");
			}
			System.out.println();
		}
		System.out.println("===================");
		
		// 2. 크기 : 확장, 우측정렬
		System.out.println("[ 2번 결과 ]");
		for (int i = 0 ; i < n ; i++ ) {
			for(int j = n - i ; j > 0 ; j-- ) 
				System.out.print(" ");
			for(int k = 0 ; k <= i ; k++ ) 
				System.out.print("*");
			System.out.println();
		}
		System.out.println("===================");
		
		// 3. 크기 : 밑변, 중앙정렬
		System.out.println("[ 3번 결과 ]");
		for (int i = 0 ; i < n ; i++ ) {
			for(int j = n - i ; j > 0 ; j-- ) 
				System.out.print(" ");
			for(int k = 0 ; k <= i ; k++ ) 
				if (i != 0) {
					System.out.print("*");
					System.out.print(" ");
				} else {
				System.out.print("*");
				}
			System.out.println();
		}
		System.out.println("===================");
		
		// 4. 크기 : 중간줄, 중앙정렬 // 마름모 출력
		System.out.println("[ 4번 결과 ]");
		for (int i = 0 ; i < n ; i++ ) {
			for(int j = n - i ; j > 0 ; j-- ) 
				System.out.print(" ");
			for(int k = 0 ; k <= i ; k++ ) 
				if (i != 0) {
					System.out.print("*");
					System.out.print(" ");
				} else {
				System.out.print("*");
				}
			System.out.println();
		}
		for (int i = n - 1 ; i > 0  ; i-- ) {
			for(int j = n - i + 1 ; j > 0 ; j-- ) 
				System.out.print(" ");
			for(int k = 0 ; k < i ; k++ ) 
				if (i != 0) {
					System.out.print("*");
					System.out.print(" ");
				} else {
				System.out.print("*");
				}
			System.out.println();
		}
		System.out.println("===================");		
	}

}
