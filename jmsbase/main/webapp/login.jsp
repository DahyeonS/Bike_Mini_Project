<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login.jsp</title>

</head>
<body>
<h2>로그인</h2>
<hr>
<form action="loginProc.do" method="post">
	<table border="1">
		<tr><th>ID</th><td><input type="text" name="id"></td></tr>
		<tr><th>PW</th><td><input type="password" name="pw"></td></tr>
		<tr><td colspan="2"><input type="submit" value="로그인"></td></tr>
	</table>
</form>
</body>
</html>