<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter" %>
<%@page import="java.util.List" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="test.db.DBConnection"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <%
	request.setCharacterEncoding("utf-8");
 	String num = request.getParameter("num"); //약 순번 변수에 입력된 삭제할 약 순번을 저장한다
 %>
</head>
<body>

<%
	Class.forName("com.mysql.cj.jdbc.Driver");
	String dbURL = "jdbc:mysql://localhost:3306/capstone?serverTimezone=Asia/Seoul";
	String dbID = "pharmacy_user";
	String dbPassword = "PHARMACY-USER";
	Connection con = DriverManager.getConnection(dbURL, dbID, dbPassword);
    PreparedStatement pstmt=null;
         try{
              con=DBConnection.getConn(); // DB에 접근하는 객체
              String sql="delete from pharmacy_stock where pi_sn=?"; //쿼리 작성-약국 재고 테이블의 약 순번과 입력 받은 약 순번 변수가 같은 약국 재고 정보를 삭제한다. 
              pstmt=con.prepareStatement(sql); //쿼리 저장-pstmt에 위의 query 저장 후 DB에 연결 준비
              pstmt.setString(1,num); //지정한 인덱스의 파라미터 값을 입력된 약 순번 변수로 지정한다.                
              pstmt.executeUpdate();
              //INSERT / DELETE / UPDATE 관련 구문에서는 반영된 레코드의 건수를 반환합니다.
  			  //SELECT 구문을 제외한 다른 구문을 수행할 때 사용되는 함수입니다.
         }catch(SQLException se){
             System.out.println(se.getMessage());
         }finally{
             if(pstmt!=null)pstmt.close();
             if(con!=null)con.close();
         }
%>
<script>
	alert("확 인!"); //재고가 삭제되었음을 알린다
    location.href="p_showstock.jsp"; //약사 재고 현황 페이지인 p_showstock.jsp로 이동한다.
</script>

</body>
</html>