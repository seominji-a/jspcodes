<%-- 
    Document   : p_stockAction
    Created on : 2022. 6. 5., 오후 8:27:36
    Author     : yejin
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="test.db.DBConnection"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        // POST 방식의 한글처리
		request.setCharacterEncoding("UTF-8");
	
		// 파라미터 정보 가져오기
	    String pillnum = request.getParameter("pillnum");  // 약 순번 변수에 입력받은 약 순번을 저장한다.
		String pillname = request.getParameter("pillname"); // 약 이름 변수에 입력받은 약 이름을 저장한다.
		String pillprice = request.getParameter("pillprice"); // 약 가격 변수에 입력받은 약 가격 변수를 저장한다.
		String pillinfo = request.getParameter("pillinfo"); // 약 정보 변수에 입력받은 약 정보 변수를 저장한다.
		String pillcount = request.getParameter("pillcount"); // 약 수량 변수에 입력받은 약 수량 변수를 저장한다.
	
        Connection con = null; // DB에 접근하는 객체
        PreparedStatement pstmt=null;
        String sql="INSERT INTO pharmacy_stock (pi_sn, pi_name, pi_price, pi_info, pi_num) VALUES (?, ?, ?, ?, ?)";
		//쿼리 작성-약국 재고 테이블에 재고 추가 정보들을 삽입한다.
        

	      int n=0; //재고 수정이 되었는지 확인하는 변수 초기화    
	      try{
	          con = DBConnection.getConn(); 
	          pstmt = con.prepareStatement(sql); //쿼리 저장-pstmt에 위의 query 저장 후 DB에 연결 준비
	          pstmt.setString(1, pillnum);  // 약국 재고 테이블의 약 순번을 저장된 약 순번 변수로 지정한다.
	          pstmt.setString(2, pillname); // 약국 재고 테이블의 약 이름을 저장된 약 이름 변수로 지정한다.
	          pstmt.setString(3, pillprice); // 약국 재고 테이블의 약 가격을 저장된 약 가격 변수로 지정한다.
	          pstmt.setString(4, pillinfo); // 약국 재고 테이블의 약 정보을 저장된 약 정보 변수로 지정한다.
	          pstmt.setString(5, pillcount); // 약국 재고 테이블의 약 수량을 저장된 약 수량 변수로 지정한다.
	          n=pstmt.executeUpdate();
	          //변수 n에 반용된 레코드의 건수를 저장한다
	        	//INSERT / DELETE / UPDATE 관련 구문에서는 반영된 레코드의 건수를 반환한다.
		  //SELECT 구문을 제외한 다른 구문을 수행할 때 사용되는 함수입니다.
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
            
        <script type="text/javascript">
            if(<%=n%> > 0){ //반용된 레코드의 건수인 변수 n이 0보다 클 경우 (약 재고가 수정되었을 경우)
                alert("재고 수정 완료"); //재고 수정 완료를 알림
               location.href="p_showstock.jsp"; //<!--약국 재고 현황 페이지인 p_showstock.jsp로 이동한다. -->
            }else{ //반용된 레코드의 건수인 변수 n이 0보다 크지 않을 경우 (약 재고가 수정되지 않았을 경우 )
                alert("실패"); //재고 수정이 실패하였음을알림
                history.go(-1); //한 페이지 뒤로 가기 (back()를 호출한 것과 동일)
            }
        </script>
    </body>
</html>