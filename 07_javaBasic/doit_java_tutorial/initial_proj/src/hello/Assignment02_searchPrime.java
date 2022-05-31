package hello;

public class Assignment02_searchPrime {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int cnt = 0;
		for (int i = 2 ; i < 100 ; i++) {
			if( i == 2 | i == 3 ) {
				System.out.print(i + "\t");
				cnt ++;
			}
			else if(i % 2 != 0 && i % 3 != 0) {
				System.out.print(i + "\t");
				cnt++;
			}
			if (cnt % 10 == 0 && cnt != 0) {
				System.out.println();
				cnt = 0;
			}
		}
	}
}
