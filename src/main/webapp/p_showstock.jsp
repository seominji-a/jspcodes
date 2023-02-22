<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import= "java.sql.*"%>

<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title>약사 재고 관리</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="canonical" href="https://getbootstrap.com/docs/5.1/examples/pricing/">
    <%
	request.setCharacterEncoding("utf-8");
    %>

    

    <!-- Bootstrap core CSS -->
<link href="/docs/5.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <!-- Favicons -->
<link rel="apple-touch-icon" href="/docs/5.1/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
<link rel="manifest" href="/docs/5.1/assets/img/favicons/manifest.json">
<link rel="mask-icon" href="/docs/5.1/assets/img/favicons/safari-pinned-tab.svg" color="#7952b3">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon.ico">
<meta name="theme-color" content="#7952b3">


    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>
    
    <!-- Custom styles for this template -->
    <link href="pricing.css" rel="stylesheet">
  </head>
  <body>
      <nav class="navbar navbar-light bg-info">
            <div class="row">
              <div class="col-sm-4"></div>	
                 <div class="col-sm-4">
                   <div style="text-align:center">
                     <div style="color:ivory">
                    <h1>4here</h1>
                     </div>
                   </div>
                 </div>	
              <div class="col-sm-4"></div>	
            </div>  
        </nav>

        <nav class="navbar navbar-light bg-success">
          <div class="row">
              <div class="col-sm-4"> </div>	
            <div class="col-sm-4"> 
              <div style="text-align:center">  
              </div>
            </div>	
            <div class="col-sm-4"> </div>	
          </div>
        </nav>
    
    <div class="container py-3">

    <main>
        <%
            Class.forName("com.mysql.cj.jdbc.Driver");
            String dbURL = "jdbc:mysql://localhost:3306/capstone?serverTimezone=Asia/Seoul";
            String dbID = "p1";
            String dbPassword = "p1";
            Connection con = DriverManager.getConnection(dbURL, dbID, dbPassword);

            String sql = "select * from pharmacy_stock;"; //쿼리 작성-약국 재고 테이블의 모든 정보를 조회한다
            PreparedStatement pstmt = con.prepareStatement(sql); //쿼리 저장-pstmt에 위의 query 저장 후 DB에 연결 준비
            ResultSet rs = pstmt.executeQuery(sql); //query 실행 후 그 결과값을 rs에 저장
            System.out.println("pstmt="+pstmt);
	%>
      <h2 class="display-6 text-center mb-4">재고 현황</h2>

      <div class="table-responsive">
        <table class="table text-center"> <!--약국 재고 정보를 표시하는 테이블 -->
          <thead>
            <tr>
              <th style="width: 20%;">약 순번</th>
              <th style="width: 20%;">약 이름</th>
              <th style="width: 20%;">약 가격</th>
              <th style="width: 20%;">약 정보</th>
              <th style="width: 20%;">약 수량</th>
            </tr>
            
          </thead>
          <%
          	//int _id=1;
            while (rs.next()) {
                    //if(rs.getString("pi_sn").equals(_id)){
            %>
<!--          <tbody>-->
            <tr>
              <td><%=rs.getString("pi_sn")%></td> <!--약국 재고 테이블의 약 순번을 읽어서 출력한다-->
              <td><%=rs.getString("pi_name")%></td> <!--약국 재고 테이블의 약 이름을 읽어서 출력한다-->
              <td><%=rs.getString("pi_price")%></td> <!--약국 재고 테이블의 약 가격을 읽어서 출력한다-->
              <td><%=rs.getString("pi_info")%></td> <!--약국 재고 테이블의 약 정보을 읽어서 출력한다-->
              <td><%=rs.getString("pi_num")%></td> <!--약국 재고 테이블의 약 수량을 읽어서 출력한다-->
            </tr>
          <!--</tbody>-->
          <%
                    
            }
            %>
      </table>
      <br>
    <!--재고 추가 버튼-재고 추가 페이지로 이동한다.-->
	<button type="button" class="btn btn-primary" onclick="location.href='p_stock.jsp';">재고 추가</button>
	
	<!--재고 삭제 버튼-재고 삭제 페이지로 이동한다.-->
	<button type="button" class="btn btn-primary" onclick="location.href='p_stock_delete.jsp';">재고 삭제</button> 
      
    </div>
  </main>
</div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
  </body>
</html>
