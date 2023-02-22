<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="test.db.DBConnection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.io.PrintWriter"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>4here</title>
<script src="https://code.jquery.com/jquery-1.9.1.js"></script>
<%
	request.setCharacterEncoding("utf-8");
 	String pname = request.getParameter("abc");
 %>
<!-- 미디어쿼리 선언부 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
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
	<%
    // POST 방식의 한글처리
	request.setCharacterEncoding("UTF-8");

	// 파라미터 정보 가져오기
    Class.forName("com.mysql.cj.jdbc.Driver");
	String dbURL = "jdbc:mysql://localhost:3306/capstone?serverTimezone=Asia/Seoul";
	String dbID = "pharmacy_user";
	String dbPassword = "PHARMACY-USER";
	Connection con = DriverManager.getConnection(dbURL, dbID, dbPassword);
    PreparedStatement pstmt=null;

    try{
    	con = DBConnection.getConn();
    	//앞 페이지에서 가져온 약국의 이름을 통해 약국의 아이디를 검색하여 제일 최근에 추가된 행의 약국 아이디를 바꾼다.
    	String sql="update stock set p_id=(select id from (select id from pharmacy where pname=?)F) where s_order=(select s_order from (select s_order from stock order by s_order desc limit 1)A);";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, pname);
        pstmt.executeUpdate();
        
        //약국의 재고를 불러온다.
		String sql2="select * from pharmacy_stock";
		pstmt = con.prepareStatement(sql2);
		ResultSet rs = pstmt.executeQuery(sql2);
	%>

	<%-- row : col-[size]-[row] --%>
	<nav class="navbar navbar-light bg-success">
		<div class="row">
			<%-- col-sm --%>
			<div class="col-sm-4"></div>
			<div class="col-sm-4">
				<div style="text-align: center">
					<br>
					<br>
					<script>
              	
					// 선택된 목록 가져오기
					//document.querySelectorAll() 함수-전체 체크박스에서 선택된 목록 전체를 가져옴
					// 이 함수는 query문을 파라미터로 받아서, query문을 만족하는 모든 element를 포함하는 NodeList를 리턴한다
              		function getCheckboxValue()  {
              		// 선택된 목록 가져오기
              			const query = 'input[name="pillname"]:checked'; //query문은 element 중 name은 pillname이고  체크박스가 체크된 element를 검색한다
              			const selectedEls = 
              		    document.querySelectorAll(query);
              		  
              			// 선택된 목록에서 value 찾기
              			//querySelectorAll() 함수가 리턴한 값이 element 목록이기 때문에 반복문을 사용하여 각각의 element에 접근해 value값을 가져옴 
              			let result = '';
              			let sum=0;
              			let price=0;
              			selectedEls.forEach((el) => {
              				sum+=1;
              		    	result += el.value + " ";
              		    	price=parseInt(el.id);
              		  	});
              		  
              		  // form에 해당 아이디 값을 가진 입력창에 가져온 값을 지정해준다. 
              		  document.getElementById('result').innerText =result;
              		  document.getElementById("abc").value=result;
              		  document.getElementById('sum').innerText = sum;
              		  document.getElementById("sum").value=sum;
              		  document.getElementById('price').innerText = price;
              		  document.getElementById("price").value=price;
              		}
              		</script>

					<h2><%= pname %></h2>
					<h4>하나만 선택해주세요.</h4>

					<table id="table" border="1">
						<thead>
							<tr>
								<th>약이름</th>
								<th>약가격</th>
								<th>약정보</th>
								<th>약수량</th>
							</tr>
						</thead>
						<%
              			while (rs.next()) {			
              			%>
						<tbody>
							<tr>
								<!--선택한 행의 약가격을 paycheck.jsp로 넘기기 위해서 id를 약가격으로 지정함--> 
								<td><input type='checkbox' name='pillname'
									id=<%=rs.getString("pi_price")%> 
									value=<%=rs.getString("pi_name")%> /><%=rs.getString("pi_name")%></td> <!--약국 재고 테이블의 약이름를 출력한다-->
								<td><%=rs.getString("pi_price")%></td>  <!--약국 재고 테이블의 약가격을 출력한다--> 
								<td><%=rs.getString("pi_info")%></td>  <!--약국 재고 테이블의 약정보을 출력한다-->
								<td><%=rs.getString("pi_num")%></td> <!--약국 재고 테이블의 약수량을 출력한다-->
							</tr>
						</tbody>
						<%		
              			}
              			%>
					</table>
					<a id="result"></a>
					
					<!-- 버튼을 눌렸을 경우 웹 페이지에서의 hidden form에 각 정보를 세팅해주고 그 값을 user_paycheck.jsp로 정보를 전달한다.-->
					<form action="user_paycheck.jsp">
						<input type="hidden" name="abc" id="abc" value="{{form.abc.value}}">
						<input type="hidden" name="sum" id="sum" value="{{form.sum.value}}">
						<input type="hidden" name="price" id="price" value="{{form.price.value}}">
						<button type="submit" class="btn btn-primary mb-3" id="chkall"
							onclick="getCheckboxValue();">확인</button>
					</form>
				</div>
			</div>
			<div class="col-sm-4"></div>
		</div>
	</nav>
			<% 
            }catch(SQLException se){
                System.out.println(se.getMessage());
            }finally{
                try{
                    if(pstmt!=null)pstmt.close();
                    if(con!=null)con.close();
                }catch(SQLException se){
                    System.out.println(se.getMessage());
                }
            }
            %>

</body>
</html>