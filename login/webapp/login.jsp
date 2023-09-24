<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login.jsp</title>
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<script src="./script/login.js"></script>
</head>
<body>
<%@include file="loginmenu.jsp" %>
<%--<%@include file="topmenu.jsp" %>--%>
<h2>로그인</h2>
<hr>
<form action="loginProc" method="post">
	<table border="1">
		<tr><th>아이디</th><td><input type="text" name="id" id="id"></td></tr>
		<tr><th>비밀번호</th><td><input type="password" name="pw" id="pw"></td></tr>
		<tr><td colspan="2"><input type="button" value="로그인" id="submit"></td></tr>
	</table>
</form>
</body>
</html>