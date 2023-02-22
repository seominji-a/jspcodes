<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="user.UserDAO2"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="test.db.DBConnection"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
</head>
<body>

	<div class="container">
		<br>
		<!-- 웹 페이지에서의 입력 양식 작성해서 재고 삭제 처리 페이지인 p_stock_delete_action.jsp로 보낸다. -->
		<form class="row g-3" accept-charset="utf-8"
			action="p_stock_delete_action.jsp">
			<div class="col-auto">
				<input type="text" readonly class="form-control-plaintext" id="num_"
					value="삭제할 약 번호: ">
			</div>
			<div class="col-auto">
				<!--텍스트 필드에 삭제할 약 순번을 입력받는다-->
				<input type="text" class="form-control" name="num">
			</div>
			<div class="col-auto">
				<!--버튼을 누르면 백엔드 서버에 양식이 전달되어 정보를 처리한다.-->
				<button type="submit" class="btn btn-primary mb-3">삭제</button>
			</div>
		</form>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
</body>
</html>