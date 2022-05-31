package hello;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class PikachuGame {

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		System.out.println("피카츄 게임을 시작합니다.");
		int hp = 30;
		int exp = 0;
		int lv = 1;
		boolean flag = true;
		
		while(flag) {
			System.out.println("1.밥 먹기 2.잠자기 3.놀기 4.운동하기 5.상태확인 6.종료");
			
			// 버퍼로 입력받기
			BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
			
			// 입력 받은 값 int형으로 전환
			int K = Integer.parseInt(br.readLine());
			
			switch(K) {
			
			case 1:
				hp += 5;
				break;
				
			case 2:
				hp += 13;
				break;
				
			case 3:
				hp -= 8;
				if (hp < 0) {
					System.out.println("피카츄가 사망했습니다. 게임을 종료합니다.");
					flag = false;
				} else {
					exp += 5;
					if (exp >= 20) {
						lv++;
						exp -= 20;
					}
				}
				break;
			case 4:
				hp -= 13;
				if (hp < 0) {
					System.out.println("피카츄가 사망했습니다. 게임을 종료합니다.");
					flag = false;
				} else {
					exp += 10;
					if (exp >= 20) {
						lv++;
						exp -= 20;
					}
				}
				break;
				
			case 5:
				System.out.println("[ 피카츄 상태 ]");
				System.out.println("HP : " + hp);
				System.out.println("EXP : " + exp);
				System.out.println("Level : " + lv);
				break;
				
			case 6:
				System.out.println("게임을 종료합니다.");
				flag = false;
				break;
			}
		}
	}

}
