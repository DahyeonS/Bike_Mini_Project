<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="loginCheck.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update.jsp</title>
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<%@include file="./script/updateScript.jsp"%>
</head>
<body>
<%@include file="loginmenu.jsp"%>
<h2>회원정보 수정</h2>
<hr>
<form action="updateProc" method="post">
	<table border="1">
		<tr><th>아이디</th><td><input type="text" name="id" id="id" value="<%=(String)session.getAttribute("id")%>"readonly="readonly"></td></tr>
		<tr><th>비밀번호</th><td><input type="password" name="pw" id="pw"></td></tr>
		<tr><th>닉네임</th><td><input type="text" name="nickname" id="nickname" value="<%=(String)session.getAttribute("nickname")%>"></td></tr>
		<tr><td colspan="2"><input type="button" value="수정하기" id="submit"></td></tr>
	</table>
</form>
</body>
</html>