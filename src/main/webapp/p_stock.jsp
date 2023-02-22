

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import= "java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
        <meta name="generator" content="Hugo 0.88.1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="canonical" href="https://getbootstrap.com/docs/5.1/examples/checkout/">

        <title>마이페이지</title>
        
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
        <link href="form-validation.css" rel="stylesheet">
    </head>
    
    <body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <main>
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
            <div class="col-sm-4"></div>	
            <div class="col-sm-4"> 
              <div style="text-align:center">        
              </div>
            </div>	
            <div class="col-sm-4"> </div>	
          </div>
        </nav>

    <div class="container">
        <div class="col">
        	
        
        	 
        	<!-- 웹 페이지에서의 입력 양식을 작성해서 재고추가 처리 페이지인 p_stockAction.jsp로 보낸다. -->
        	<!--get:서버에서 어떤 데이터를 가져와서 보여줄때 사용합니다/ 어떤 값이나 내용, 상태등을 바꾸지 않는 경우에 사용-->
            <form action="p_stockAction.jsp" method="get">
            <br>
            
            <h4 class="mb-3">재고 추가</h4>
            
            <!-- 웹 페이지에서의 입력 양식 작성 -->
            <form class="needs-validation"  action="ChangeUserInfo" method="get">
               <div class="row g-3">
                  <div class="col-12">
                  	<!--텍스트 필드에 약 순번을 입력받는다. -->
                    <label for="pill_naem" class="form-label">약 순번</label>
                    <input type="text" name="pillnum" value="${pillnum}" class="form-control" id="pillnum" placeholder="">
                  </div>
              	</div>
              	<br>
            
                <div class="row g-3">
                    <div class="col-12">
                      <!--텍스트 필드에 약 이름을 입력받는다. -->
                      <label for="pill_naem" class="form-label">약 이름</label>
                      <input type="text" name="pillname" value="${pillname}" class="form-control" id="pillname" placeholder="">
                      <div class="invalid-feedback">
                        Please enter a valid email address for shipping updates.
                      </div>
                    </div>
                </div>
                <br>
                  
                <div class="row g-3">
                    <div class="col-12">
                      <!--텍스트 필드에 약 가격을 입력받는다. -->
                      <label for="pill_naem" class="form-label">약 가격</label>
                      <input type="text" name="pillprice" value="${pillprice}" class="form-control" id="pillprice" placeholder="">
                      <div class="invalid-feedback">
                        Please enter a valid email address for shipping updates.
                      </div>
                    </div>
                </div>
                <br>
                  
                <div class="row g-3">
                    <div class="col-12">
                      <!--텍스트 필드에 약 정보를 입력받는다. -->
                      <label for="pill_naem" class="form-label">약 정보</label>
                      <input type="text" name="pillinfo" value="${pillinfo}" class="form-control" id="pillinfo" placeholder="">
                      <div class="invalid-feedback">
                        Please enter a valid email address for shipping updates.
                      </div>
                    </div>
                </div>
                <br>     
            
                <div class="row g-3">
                    <div class="col-12">
                      <!--텍스트 필드에 약 수량을 입력받는다. -->
                      <label for="pill_naem" class="form-label">약 수량</label>
                      <input type="text" name="pillcount" value="${pillcount}" class="form-control" id="pillcount" placeholder="">
                    </div>
                </div>
                <br>
			<!--버튼을 누르면 백엔드 서버에 양식이 전달되어 정보를 처리한다.-->
            <button class="w-25 btn btn-primary btn-lg" type="submit">저 장</button>
            </form>
        </div>
    </div>
    </main>
        <footer class="my-5 pt-5 text-muted text-center text-small">        </footer>

      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
      <script src="form-validation.js"></script>
  </body>
</html>
