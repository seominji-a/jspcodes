<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="test.db.DBConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<%
	request.setCharacterEncoding("utf-8");
 	String txt = request.getParameter("abc"); // 약이름 변수에 약이름을 저장한다.
 	String sum = request.getParameter("sum"); // 약이름 변수에 총수량을 저장한다.
 	String price = request.getParameter("price"); // 약가격 변수에 약가격을 저장한다.
 %>

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
					<br>
					<h3></h3>
					<br>
					<form class="d-flex">
						<!--                      <input class="form-control me-2" type="search" style="text-align:center" placeholder="건물명, 도로명, 지번으로 검색하세요." aria-label="Search">
                      <br>
                      <a class="btn btn-info" href="http://localhost:8080/parmacy.jsp" role="button" type="submit">search</a>-->
					</form>
					<br>
				</div>
			</div>
			<div class="col-sm-4"></div>
		</div>
	</nav>

	<script>
                        function payment(){ //id가 x인 html요소의 값을 들고와서 take변수에 넣는 함수 
                        	take=document.getElementById('x').innerText
                        	result = take.substr(5);

                    		document.getElementById('num').innerText =result;
                    		document.getElementById('num').value=result;
                        }
                        </script>

	<div class="container" style="text-align: center;">
		<div class="row">
			<div class="col"></div>
			<div class="col">
				<div class="card" style="width: 120rem;" style="text-align:center">
					<div class="card-header" style="text-align: center">
						<h3>배달정보</h3>
					</div>
					<%
                        request.setCharacterEncoding("utf-8");
                        String id = request.getParameter("userID");
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        String dbURL = "jdbc:mysql://localhost:3306/capstone?serverTimezone=Asia/Seoul";
                        String dbID = "service_user";
                        String dbPassword = "SERVICE-USER";
                        Connection con = DriverManager.getConnection(dbURL, dbID, dbPassword);
  
                        PreparedStatement pstmt=null;
                        con=DBConnection.getConn();
                        //삽입 
                   		//쿼리 작성- 주문테이블이 마지막행의 약순번을 조회하고, 주문테이블의 마지막행에 사용자가 선택한 약이름, 약수량, 약가격을 추가한다.   
                        String sql="update stock set pi_name=?, _num=?, pi_price=? where s_order=(select s_order from (select s_order from stock order by s_order desc limit 1)A);";
                        pstmt=con.prepareStatement(sql);
                        pstmt.setString(1,txt); //sql문의 처음의 pi_name값을 앞페이지에서 받아온 약이름(txt)로 지정한다  
                        pstmt.setString(2,sum);  //sql문의 처음의 _num 값을 앞페이지에서 받아온 약 수량(sum)로 지정한다  
                        pstmt.setString(3,price);  //sql문의 처음의 pi_price 값을 앞페이지에서 받아온 약 가격(price)로 지정한다  
                                 
                        pstmt.executeUpdate();
								  
                        //선택(불러오기)
                        //쿼리 작성- 앞에서 업데이트한 주문테이블의 마지막행을 조회한다. 
                        String sql2 = "select * from stock where s_order=(select s_order from stock order by s_order desc limit 1);";
                        PreparedStatement pstmt2 = con.prepareStatement(sql2); //쿼리 저장-pstmt에 위의 query 저장 후 DB에 연결 준비
                        ResultSet rs = pstmt.executeQuery(sql2); ///query 실행 후 그 결과값을 rs에 저장
                                  
                        while (rs.next()) {
                    %>
                    <!--마지막행의 정보를 다 가져와서 출력한다. -->
					<ul class="list-group list-group-flush" style="text-align: center">
						<li class="list-group-item"><p id='x'>품명 : <%=rs.getString("pi_name")%></p> 
							<br> <p>가격 : <%=rs.getString("pi_price")%>원 
						</p><br>
						<p>총 수량 : <%=rs.getString("_num")%>개
						</p></li>
						<%
                            }
                        %>
					</ul>

				</div>
			</div>
			<div class="col"></div>
		</div>
	</div>

	<div class="container">
		<div class="row">
			<div class="col"></div>
			<div class="col">
			     <!--결제 방식을 라디오 버튼으로 선택한다. -->
				<div class="card" style="width: 120rem;" style="text-align:center">
					<div class="card-header" style="text-align: center">
						<h3>결제 수단</h3>
					</div>
					<ul class="list-group list-group-flush" style="text-align: center">
						<div class="form-check">
							<input class="form-check-input" type="radio"
								name="flexRadioDefault" id="flexRadioDefault1"> <label
								class="form-check-label" for="flexRadioDefault1"> 신용카드 </label>
						</div>
						<div class="form-check">
							<input class="form-check-input" type="radio"
								name="flexRadioDefault" id="flexRadioDefault2" checked>
							<label class="form-check-label" for="flexRadioDefault2">
								휴대폰 결제 </label>
						</div>
						<div class="form-check">
							<input class="form-check-input" type="radio"
								name="flexRadioDefault" id="flexRadioDefault1"> <label
								class="form-check-label" for="flexRadioDefault1"> 네이버페이
							</label>
						</div>
						<div class="form-check">
							<input class="form-check-input" type="radio"
								name="flexRadioDefault" id="flexRadioDefault2" checked>
							<label class="form-check-label" for="flexRadioDefault2">
								카카오페이 </label>
						</div>

						<form action="user_paycheckAction.jsp">
							<input type="hidden" name="num" id="num"
								value="{{form.num.value}}">
							<button type="submit" class="btn btn-primary mb-3"
								onclick="payment();">결 제</button>
						</form>

					</ul>
				</div>
			</div>
			<div class="col"></div>
		</div>
	</div>



	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
</body>
</html>