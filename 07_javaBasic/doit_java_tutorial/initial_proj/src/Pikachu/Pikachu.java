package Pikachu;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Pikachu {

	private int hp;
	private int exp;
	private int lv;
	
	// 피카츄
	public Pikachu(int hp, int exp, int lv) {
		this.hp = hp;
		this.exp = exp;
		this.lv = lv;
	}
	
	// 상태 확인
	public void getStatus() {
		System.out.println("피카츄의 현 상태");
		System.out.println("HP : " + hp);
		System.out.println("EXP : " + exp);
		System.out.println("Level :" + lv);
	}
	
	// 밥 먹기
	public void eatMeal() {
		hp += 5;
	}
	
	// 잠자기
	public void sleep() {
		hp += 10;
	}
	
	// 놀기
	public void play() {
		hp -= 8;
		if (hp < 0) {
			System.out.println("피카츄가 사망했습니다. 게임을 종료합니다.");
			System.exit(0);
		} else {
			exp += 5;
			if (exp >= 20) {
				lv++;
				System.out.println("Level Up!");
				exp -= 20;
			}
		}
	}
	
	// 운동하기
	public void exercise() {
		hp -= 13;
		if (hp < 0) {
			System.out.println("피카츄가 사망했습니다. 게임을 종료합니다.");
			System.exit(0);
		} else {
			exp += 10;
			if (exp >= 20) {
				lv++;
				System.out.println("Level Up!");
				exp -= 20;
			}
		}
	}

}
