<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>delete.jsp</title>
</head>
<body>
<%@include file="topmenu.jsp" %>
<h2>회원탈퇴</h2>
<hr>
<form action="deleteProc.do" method="post">
	<table border="1">
		<tr><th>PW</th><td><input type="password" name="pw"></td></tr>
		<tr><td colspan="2"><input type="submit" value="회원탈퇴"></td></tr>
	</table>
</form>
</body>
</html>