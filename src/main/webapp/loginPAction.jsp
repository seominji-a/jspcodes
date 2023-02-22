<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="user.UserDAO2"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPW" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%
request.setCharacterEncoding("utf-8");
String id = request.getParameter("userID");
%>

<style>
table {
	border: 2px solid;
	border-collapse: collapse;
}

th, td {
	border: 1px solid;
	padding: 10px 5px;
}
</style>

<!-- 미디어쿼리 선언부 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<title>4here user main</title>
</head>
<body>
	<%
	UserDAO2 userDao = new UserDAO2();
	int result = userDao.login(user.getUserID(), user.getUserPW()); //result에 약사 로그인 처리 결과를 넣는다. 
	if (result == 1) { //약사 로그인이 성공했을 경우
		PrintWriter script = response.getWriter();

		Class.forName("com.mysql.cj.jdbc.Driver");
		String dbURL = "jdbc:mysql://localhost:3306/capstone?serverTimezone=Asia/Seoul";
		String dbID = "service_user";
		String dbPassword = "SERVICE-USER";
		Connection con = DriverManager.getConnection(dbURL, dbID, dbPassword);

		String sql = "select * from pharmacy;"; //쿼리 작성-약국 테이블의 모든 정보를 조회한다
		PreparedStatement pstmt = con.prepareStatement(sql); //쿼리 저장-pstmt에 위의 query 저장 후 DB에 연결 준비
		ResultSet rs = pstmt.executeQuery(sql); //query 실행 후 그 결과값을 rs에 저장
	%>

	<nav class="navbar navbar-light bg-info">
		<div class="row">
			<div class="col-sm-4"></div>
			<div class="col-sm-4">
				<div style="text-align: center">
					<div style="color: ivory">
						<h1>4here</h1>
						<br>
					</div>
				</div>
			</div>
			<div class="col-sm-4"></div>
		</div>
	</nav>


	<nav class="navbar navbar-light bg-success">
		<div class="row">
	
			<div class="col-sm-4"></div>
			<div class="col-sm-4">
				<div style="text-align: center">
					<br> <br>
					<%
					while (rs.next()) {
						//약사 로그인할 때 입력한 아이디(약국이름)와 약국테이블의 약국이름이 같을 경우
						if (rs.getString("pname").equals(id)) { 
					%>
					<table id="phar_info"> <!--약국 정보를 표시하는 테이블 -->
						<tr>
							<!--약국테이블의 약국이름을 읽어서 출력한다-->
							<th style="text-align: center">약국이름</th>
							<td style="text-align: left""><%=rs.getString("pname")%></td> 
						</tr>
						<tr>
							<!--약국테이블의 주소를 출력한다-->
							<th style="text-align: center">주소</th>
							<td style="text-align: left"><%=rs.getString("place")%></td>
						</tr>
						<tr>
							<!--약국테이블의 전화번호를 읽어서 출력한다-->
							<th style="text-align: center">전화번호</th>
							<td style="text-align: left"><%=rs.getString("cellnum")%></td>
						</tr>
						<tr>
							<!--약국테이블의 정보를 읽어서 출력한다-->
							<th style="text-align: center">정보</th>
							<td style="text-align: left"><%=rs.getString("info")%></td>
						</tr>
						<tr>
							<!--약국테이블의 휴무를 읽어서 출력한다-->
							<th style="text-align: center">휴무</th>
							<td style="text-align: left"><%=rs.getString("holi")%></td>
						</tr>
						<%
						}
						}
						%>
					</table>
					
					<!--추가 버튼을 누르면 약국 재고 현황 페이지인 p_showstock.jsp로 이동한다. -->
					<button type="button" class="btn btn-primary"
						onclick="location.href='p_showstock.jsp';">재고확인</button>					
					<br>
				</div>
			</div>
			<div class="col-sm-4"></div>
		</div>
	</nav>
	<%
	} else if (result == 0) {  //로그인 처리 결과에서 비밀번호가 불일치 하다면
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('비밀번호가 틀립니다.')"); //비밀번호가 불일치함을 알림
	script.println("history.back()"); // 이전 페이지로 사용자를 보냄
	script.println("</script>");
	} else if (result == -1) {  //로그인 처리 결과에서 아이디가 없다면
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('존재하지 않는 아이디입니다.')"); //아이디가 없음을 알림
	script.println("history.back()"); // 이전 페이지로 사용자를 보냄
	script.println("</script>");
	} else if (result == -2) { //로그인 처리 결과에서 데이터베이스 오류가 있다면
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('데이터베이스 오류가 발생했습니다.')"); //데이터베이스 오류가 났음을 알림
	script.println("history.back()"); // 이전 페이지로 사용자를 보냄
	script.println("</script>");
	}
	%>
</body>
</html>