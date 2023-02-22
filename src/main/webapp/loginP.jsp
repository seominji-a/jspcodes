<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<title>4here user main</title>
</head>
<body>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<body style="background-color: lightblue;">


	<nav class="navbar navbar-inverse">
		<!-- navbar-색상(inverse = 검은색, default = 색x) -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span>
				<!-- 아이콘 이미지 -->
			</button>
			<a class="navbar-brand" href="main.jsp">4here</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<!-- navbar-nav => 네비게이션 바의 메뉴 -->
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a> 
					<ul class="dropdown-menu">

						<li class="active"><a href="loginP.jsp">로그인</a></li>
						<!-- active = 활성화 되었을때 로그인, 회원가입-->
					</ul></li>
			</ul>
		</div>
	</nav>
	
	
	<div class="container">
		<!-- 전체 레이아웃 감싸주기 -->

		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
			
				<!-- 웹 페이지에서의 입력 양식을 작성해서 약사 로그인 처리 페이지인 loginPAction.jsp로 보낸다. -->	
				<form accept-charset="utf-8" action="loginPAction.jsp">
					<h2 style="text-align: center;">로그인 화면</h2>
					<div class="form-group">
						<!--텍스트 필드에 아이디(약국이름)를 입력받는다. -->
						<input type="text" class="form-control" placeholder="아이디"
							name="userID" maxlength="20">
					</div>
					<div class="form-group">
						<!--텍스트 필드에 비밀번호(약국 전화번호)를 입력받는다. -->
						<input type="password" class="form-control" placeholder="비밀번호"
							name="userPW" maxlength="20">
					</div>
					<!--버튼을 누르면 백엔드 서버에 양식이 전달되어 정보를 처리한다.-->	
					<button type="submit" class="btn btn-primary form-control">로그인</button>
				</form>
			</div>
		</div>
</body>
</html>