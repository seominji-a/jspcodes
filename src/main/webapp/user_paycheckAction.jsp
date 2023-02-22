<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="test.db.DBConnection"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<%
	request.setCharacterEncoding("utf-8");
	//넘겨받은것=약이름
	String pi_name = request.getParameter("num");
	
	//db 연결
    String id = request.getParameter("userID");
    Class.forName("com.mysql.cj.jdbc.Driver");
    String dbURL = "jdbc:mysql://localhost:3306/capstone?serverTimezone=Asia/Seoul";
    String dbID = "service_user";
    String dbPassword = "SERVICE-USER";
    Connection con = DriverManager.getConnection(dbURL, dbID, dbPassword);
  
    PreparedStatement pstmt=null;
    con=DBConnection.getConn();
								  
    //선택한 약의 재고수량 불러오기
    String sql = "select pi_num from pharmacy_stock where pi_name=?;"; //쿼리 작성-선택한 약이름과 약국 재고 테이블의 약이름이 동일한 약 수량을 조회한다
    pstmt = con.prepareStatement(sql); //쿼리 저장-pstmt에 위의 query 저장 후 DB에 연결 준비
    pstmt.setString(1,pi_name);  //지정한 인덱스의 파라미터 값을 약이름으로 지정한다.
    
    ResultSet rs = pstmt.executeQuery(); //query 실행 후 그 결과값을 rs에 저장
    int x=0;
    
    while(rs.next()){
    	//재고수량 x에 저장하기
        x = Integer.parseInt(rs.getString("pi_num"))-1;
    }
    //약 수량 String 타입으로 바꾸기
    String txt=Integer.toString(x);
    
    //입력받은 약의 재고수량 하나 감소
    String sql2="update pharmacy_stock set pi_num=? where pi_name=?;"; //쿼리 작성-선택한 약이름과 약국 재고 테이블의 약이름이 동일한 약 수량을 변경한다
    pstmt=con.prepareStatement(sql2); //쿼리 저장-pstmt에 위의 query 저장 후 DB에 연결 준비
    pstmt.setString(1,txt);  //지정한 인덱스의 파라미터 값을 약 수량을으로 지정한다.
    pstmt.setString(2,pi_name);  //지정한 인덱스의 파라미터 값을 약이름으로 지정한다.
                                                     
    pstmt.executeUpdate();
  	//INSERT / DELETE / UPDATE 관련 구문에서는 반영된 레코드의 건수를 반환합니다.
	//SELECT 구문을 제외한 다른 구문을 수행할 때 사용되는 함수입니다.
    
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("location.href = 'user_pharmacy.jsp'");  //결제가 완료되면 약국 검색 페이지인 user_pharmacy.jsp로 이동한다. 
	script.println("alert('결제완료되었습니다.')"); //결제가 완료되었음을 알린다.
	script.println("</script>");
%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 웹 페이지에서의 입력 양식을 작성한다. -->	
<form>
	<!-- 결제페이지에 결제한 약이름을 전달하기위해서 value에 지도에서 선택한 약이름을 대입한다.-->
	<input type="hidden" name="abc" id="abc" value="{{form.abc.value}}">
	<!-- 결제페이지에 합계를 전달하기위해서 value에 총수량을 대입한다.-->
	<input type="hidden" name="sum" id="sum" value="{{form.sum.value}}">
	<!-- 결제페이지에 가격을 전달하기위해서 value에 가격을 대입한다.-->
	<input type="hidden" name="price" id="price" value="{{form.price.value}}">
	<!--버튼을 누르면 처크박스에 지동된 value값이 백엔드 서버에 양식이 전달되어 정보를 처리한다.-->
	<button type="submit" class="btn btn-primary mb-3" onclick="getCheckboxValue();">확인</button> 
</form>
</body>
</html>