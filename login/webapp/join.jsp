<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>join.jsp</title>
<style>
	h2 {text-align: center;}
	table, th, td, input {
		margin: 0 auto;
		border-collapse: collapse;
		font-size: 14pt;
	}
	#success, #fail {margin-left: 10%;}
	#final {text-align: right;}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<script src="./script/join.js"></script>
</head>
<body>
<%@include file="loginmenu.jsp" %>
<h2>회원가입</h2>
<hr>
<form name="joinForm" method="post">
	<table>
		<tr><th>아이디&nbsp</th>
		<td>
		<input type="text" name="id" id="id">&nbsp&nbsp
		<input id="check" type="button" value="ID 확인">
		</td></tr>
		
		<tr id="success"><td colspan="2">사용가능한 아이디입니다.</td></tr>
		<tr id="fail"><td colspan="2">사용불가능한 아이디입니다.</td></tr>
		<tr><th>비밀번호&nbsp</th><td><input type="password" name="pw" id="pw"></td></tr>
		<tr><th>비밀번호 확인&nbsp</th><td><input type="password" name="pw2" id="pw2"></td></tr>
		<tr><th>닉네임&nbsp</th><td><input type="text" name="nickname" id="nickname"></td></tr>
		<tr><th colspan="2">&nbsp</th></tr>
		<tr><td colspan="2" id="final"><input id="submit" type="button" value="가입하기"></td></tr>
	</table>
</form>
</body>
</html>