/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package user;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.DriverManager;


public class UserDAO2 { //약사 데이터 베이스 처리 클래스

    private Connection conn; // DB에 접근하는 객체
    private PreparedStatement pstmt;
    private ResultSet rs; // DB data를 담을 수 있는 객체

    public UserDAO2() {  
        try {
            String dbURL = "jdbc:mysql://localhost:3306/capstone";
            String dbID = "pharmacy_user";
            String dbPassword = "PHARMACY-USER";
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int login(String userID, String userPW) { //db값으로 약사 로그인을 처리 하는 함수
        String SQL = "SELECT cellnum FROM pharmacy WHERE pname  = ?"; //쿼리 작성-입력한 아이디와 db의 아이디를 비교하여 페스워드를 조회한다.
        try {
            pstmt = conn.prepareStatement(SQL); //쿼리 저장-pstmt에 위의 query 저장 후 DB에 연결 준비
            pstmt.setString(1, userID); //지정한 인덱스의 파라미터 값을 입력한 아이디로 지정한다.
            rs = pstmt.executeQuery(); //query 실행 후 그 결과값을 rs에 저장
            //결과값 불러오기
            if (rs.next()) {
            	System.out.println("rs.getString="+rs.getString(1));
                if (rs.getString(1).equals(userPW)) {
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
}