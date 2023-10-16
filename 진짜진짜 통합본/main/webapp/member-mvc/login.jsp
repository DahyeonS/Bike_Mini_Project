<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login.jsp</title>
</head>
<body>
<%@include file="submenu.jsp" %>
<h2>로그인</h2>
<hr>
<form action="loginAction.do" method="post">
	<table border="1">
		<tr><th>ID</th><td><input type="text" name="id"></td></tr>
		<tr><th>PW</th><td><input type="text" name="pw"></td></tr>
		<tr><td colspan="2"><input type="submit" value="Submit"></td></tr>
	</table>
</form>
</body>
</html>