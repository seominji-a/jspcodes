<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="user.UserDAO"%>
<%@page import="java.io.PrintWriter"%>
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
<title>4here user main</title>
</head>
<body>
	<%
	UserDAO userDao = new UserDAO();
	int result = userDao.login(user.getUserID(), user.getUserPW()); //result에 사용자 로그인 처리 결과를 넣는다.
	if (result == 1) { //로그인 처리 결과가 성공이라면
		int res = userDao.order(user);  //res 에 로그인한 아이디를 처리 결과를 넣는다. 
		if (res == 1) {  //로그인이 정상적으로 되었을 경우 (주문-주문테이블에 id가 입력된다)
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 성공')");
			script.println("location.href = 'user_pharmacy.jsp'"); //약국 선택 화면으로 이동한다. 
			script.println("</script>");
		} else { //로그인이 정상적으로 되지 않았을 경우 (주문X-주문테이블에 id가 입력되지 않는다.)
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('order실패')"); //주문 실패 알림
			script.println("history.back()"); // 이전 페이지로 사용자를 보냄
			script.println("</script>");
		}
	} else if (result == 0) { //로그인 처리 결과에서 비밀번호가 불일치 하다면 
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.')"); //비밀번호가 불일치함을 알림
		script.println("history.back()"); // 이전 페이지로 사용자를 보냄
		script.println("</script>");
	} else if (result == -1) { //로그인 처리 결과에서 아이디가 없다면
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