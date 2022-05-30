package hello;

import java.util.Scanner;

public class Assignment01 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int []score;
		float avg;
			
		score = new int[4];
			
		Scanner sc = new Scanner(System.in);
			
		System.out.println("국어, 영어, 수학 성적을 차례대로 입력하시오 : ");
			
		for(int i=0 ; i < score.length - 1 ; i++) { 
			score[i] = sc.nextInt();
			score[3] += score[i];
		}
			avg = score[3] / 3.f;
			
			
		// 출력 구현
			
		String []str = {"국어","영어","수학","총점"};
			
		for(int i=0;i<score.length;i++) {
			System.out.println(str[i]+" : "+score[i]);
				
		}
		System.out.println("평균 : "+avg);
		
	}

}
