package javaAssignment;

public class Assignment02_searchPrime {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int cnt = 0;
		
		for(int n = 2 ; n <= 100 ; n++) {
			int i;
			for(i=2;i<n;i++) {
				cnt++;
				if(n%i==0)
					break;
			}
			if(n==i)
				System.out.print(n + " ");
			
		}
	}
}
