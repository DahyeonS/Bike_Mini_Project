<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="loginCheck.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<style>
	h2 {text-align: center;}
	table, th, td, input {
		margin: 0 auto;
		border-collapse: collapse;
		font-size: 14pt;
	}
	#update {text-align: right;}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<%@include file="./script/updateScript.jsp"%>
</head>
<body>
<%@include file="../home/topmenu.jsp" %>
<h2>회원정보 수정</h2>
<hr>
<form action="updateProc" method="post">
	<table>
		<tr><th>아이디&nbsp</th><td><input type="text" name="id" id="id" value="<%=(String)session.getAttribute("id")%>"readonly="readonly"></td></tr>
		<tr><th>비밀번호&nbsp</th><td><input type="password" name="pw" id="pw"></td></tr>
		<tr><th>닉네임&nbsp</th><td><input type="text" name="nickname" id="nickname" value="<%=(String)session.getAttribute("nickname")%>"></td></tr>
		<tr><td colspan="2" id="update"><input type="button" value="수정하기" id="submit"></td></tr>
	</table>
</form>
</body>
</html>