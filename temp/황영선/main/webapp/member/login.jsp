<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
	h2 {text-align: center;}
	table, th, td, input {
		margin: 0 auto;
		border-collapse: collapse;
		font-size: 14pt;
	}
	#login {text-align: right;}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<script src="./script/login.js"></script>
</head>
<body>
<%@include file="../home/topmenu.jsp" %>
<h2>로그인</h2>
<form action="loginProc" method="post">
	<table>
		<tr><th>아이디&nbsp</th><td><input type="text" name="id" id="id"></td></tr>
		<tr><th>비밀번호&nbsp</th><td><input type="password" name="pw" id="pw"></td></tr>
		<tr><td colspan="2" id="login">&nbsp<input type="button" value="로그인" id="submit"></td></tr>
	</table>
</form>
</body>
</html>