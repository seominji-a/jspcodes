/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package user;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.DriverManager;

public class UserDAO { //사용자 데이터 베이스 처리 클래스

	private Connection conn; // DB에 접근하는 객체
	private PreparedStatement pstmt;
	private ResultSet rs; // DB data를 담을 수 있는 객체

	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/capstone";

			String dbID = "service_user";
			String dbPassword = "SERVICE-USER";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int login(String userID, String userPW) { //db값으로 사용자 로그인을 처리 하는 함수
		String SQL = "SELECT pwd FROM user WHERE id  = ?"; //쿼리 작성-입력한 아이디와 db의 아이디를 비교하여 페스워드를 조회한다.
		try {
			pstmt = conn.prepareStatement(SQL); //쿼리 저장-pstmt에 위의 query 저장 후 DB에 연결 준비
			pstmt.setString(1, userID); //지정한 인덱스의 파라미터 값을 입력한 아이디로 지정한다.
			rs = pstmt.executeQuery(); //query 실행 후 그 결과값을 rs에 저장
			//결과값 불러오기
			if (rs.next()) {
				if (rs.getString(1).equals(userPW)) { //
					return 1; // 로그인 성공
				} else {
					return 0; // 비밀번호 불일치
				}
			}
			return -1; // 아이디가 없음
		} catch (Exception e) {
			e.getStackTrace();
		}
		return -2; // 데이터베이스 오류
	}

	public int join(User user) { //db값으로 회원가입을 처리 하는 함수
		String SQL = "INSERT INTO user VALUES (?,?)"; //쿼리 작성-입력한 아이디와 비밀번호를 db에 삽입한다.
		try {
			pstmt = conn.prepareStatement(SQL); //쿼리 저장-pstmt에 위의 query 저장 후 DB에 연결 준비
			pstmt.setString(1, user.getUserID()); //지정한 인덱스의 파라미터 값을 입력한 아이디로 지정한다.
			pstmt.setString(2, user.getUserPW()); //지정한 인덱스의 파라미터 값을 입력한 비밀번호로 지정한다.

			return pstmt.executeUpdate(); 
			//INSERT / DELETE / UPDATE 관련 구문에서는 반영된 레코드의 건수를 반환합니다.
			//SELECT 구문을 제외한 다른 구문을 수행할 때 사용되는 함수입니다.
		} catch (Exception e) {
			e.getStackTrace();
		}
		return -2; // 데이터베이스 오류
	}

	public int order(User user) { //db에 로그인한 아이디를 처리하는 함수
		String SQL = "INSERT INTO stock VALUES (0,0,'', 0,?,1)"; //쿼리 작성-로그인 한 아이디를 주문테이블 db에 삽입한다.
		try {
			pstmt = conn.prepareStatement(SQL); //쿼리 저장-pstmt에 위의 query 저장 후 DB에 연결 준비
			pstmt.setString(1, user.getUserID()); //지정한 인덱스의 파라미터 값을 입력한 아이디로 지정한다.
			return pstmt.executeUpdate();
			//INSERT / DELETE / UPDATE 관련 구문에서는 반영된 레코드의 건수를 반환합니다.
			//SELECT 구문을 제외한 다른 구문을 수행할 때 사용되는 함수입니다.
		} catch (Exception e) {
			e.getStackTrace();
		}
		return -2; // 데이터베이스 오류
	}
}