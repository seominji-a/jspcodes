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
	System.out.println(user.getUserID() + " / " + user.getUserPW());
	if (user.getUserID() == null || user.getUserPW() == null) { //아이디와 비밀번호를 입력하지 않은 경우
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력되지 않은 사항이 있습니다.')"); //입력되지 않았음을 알림
		script.println("history.back()"); // 이전 페이지로 사용자를 보냄
		script.println("</script>");
	} else {
		UserDAO userDao = new UserDAO();
		int result = userDao.join(user);
		if (result == -1) { //존재하는 아이디가 있을 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디 입니다.')"); //아이디가 입력되지 않았음을 알림
			script.println("history.back()"); // 이전 페이지로 사용자를 보냄
			script.println("</script>");
		} else { //정상적인 회원가입 동작
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'login.jsp'"); //다시 로그인하기 위해 login.jsp페이지로 이동한다
			script.println("alert('가입되었습니다. 로그인해주세요')"); //로그인 되었음을 알림
			//script.println("history.back()");
			script.println("</script>");
		}
	}
	%>
</body>
</html>