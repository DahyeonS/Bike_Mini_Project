<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/join.css">
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<script src="script/join.js"></script>
</head>
<body>
<%@include file="../home/topmenu.jsp" %>
<div class="joinPage">
<h2>회원가입</h2>
<form id="joinForm" method="post">
	<table>
		<tr class="join"><th>아이디&nbsp</th>
		<td class="btn">
		<input type="text" name="id" id="id">&nbsp&nbsp
		<input id="check" type="button" value="ID 확인">
		</td></tr>
		<tr id="success" class="success"><th></th><td>사용 가능한 아이디입니다.</td></tr>
		<tr id="fail" class="fail"><th></th><td>사용 불가능한 아이디입니다.</td></tr>
		
		<tr class="join"><th>비밀번호&nbsp</th><td><input type="password" name="pw" id="pw"></td></tr>
		<tr class="join"><th>비밀번호 확인&nbsp</th><td><input type="password" name="pw2" id="pw2"></td></tr>
		
		<tr class="join"><th>닉네임&nbsp</th>
		<td class="btn">
		<input type="text" name="nickname" id="nickname">&nbsp&nbsp
		<input id="nickcheck" type="button" value="중복확인">
		</td></tr>
		<tr id="nicksuccess" class="success"><th></th><td>사용 가능한 닉네임입니다.</td></tr>
		<tr id="nickfail" class="fail"><th></th><td>사용 불가능한 닉네임입니다.</td></tr>
		
		<tr class="join"><th colspan="2">&nbsp</th></tr>
		<tr><td colspan="2" id="join" class="btn"><input id="submit" type="button" value="가입하기"></td></tr>
	</table>
</form>
</div>
</body>
</html>