<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="loginCheck.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/delete.css">
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<script src="script/delete.js"></script>
</head>
<body>
<%@include file="../home/topmenu.jsp" %>
<h2>회원탈퇴</h2>
<form id="deleteProc">
	<table>
		<tr><th>비밀번호 입력&nbsp</th><td><input type="password" name="pw" id="pw"></td></tr>
		<tr><td colspan="2" id="delete"><input type="button" value="회원탈퇴" id="submit"></td></tr>
	</table>
</form>
</body>
</html>