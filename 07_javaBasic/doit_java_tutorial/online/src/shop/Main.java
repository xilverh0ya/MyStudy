package shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.mysql.cj.xdevapi.Result;

public class Main {
	
	public static void startProgram() {
		System.out.print("""
#############################
### 쇼핑몰 프로그램을 시작합니다 ###
#############################
				""");
	}
	
	public static void endProgram() {
        System.out.print("""
#############################
### 쇼핑몰 프로그램을 종료합니다 ###
#############################
                """);
    }
	
	public static void main(String[] args) throws SQLException {
		// TODO Auto-generated method stub
		startProgram();
		LoginMenu.readMenu();
        endProgram();
	}

}