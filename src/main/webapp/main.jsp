<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
	<%-- grid(그리드) : 페이지 레이아웃 --%>

	<%-- bootstrap의 container class 활용 --%>
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


	<%-- row : col-[size]-[row] --%>
	<nav class="navbar navbar-light bg-success">
		<div class="row">
			<%-- col-sm --%>
			<div class="col-sm-4"></div>
			<div class="col-sm-4">
				<div style="text-align: center">
					<br> <br>
					<form class="d-flex">
						<div id="locationField">
							<a href="http://localhost:8080/pha/loginP.jsp"
								class="btn btn-success btn-lg btn-block" tabindex="-1"
								role="button" aria-disabled="true">Pharmacy</a>
							<%-- Pharmacy 버튼을 누르면 약사 로그인 화면인 loginp.jsp 페이지로 넘어간다.--%>
							
							<a href="http://localhost:8080/pha/login.jsp"
								class="btn btn-primary btn-lg btn-block" tabindex="-1"
								role="button" aria-disabled="true">User</a>
							<%-- User 버튼을 누르면 사용자 로그인 화면인 login.jsp 페이지로 넘어간다.--%>
						</div>
					</form>
					<br> <br>
				</div>
			</div>
			<div class="col-sm-4"></div>
		</div>
	</nav>
</body>
</html>