<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="loginCheck.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/update.css">
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<%@include file="script/updateScript.jsp"%>
</head>
<body>
<%@include file="../home/topmenu.jsp" %>
<h2>회원정보 수정</h2>
<form id="updateProc">
	<table>
		<tr class="update"><th>아이디&nbsp</th><td><input type="text" name="id" id="id" value="<%=(String)session.getAttribute("id")%>"readonly="readonly"></td></tr>
		<tr class="update"><th>비밀번호&nbsp</th><td><input type="password" name="pw" id="pw"></td></tr>
		<tr class="update"><th>닉네임&nbsp</th><td><input type="text" name="nickname" id="nickname" value="<%=(String)session.getAttribute("nickname")%>">&nbsp&nbsp
		<input id="nickcheck" type="button" value="중복확인">
		</td></tr>
		<tr id="nicksuccess"><th></th><td>사용 가능한 닉네임입니다.</td></tr>
		<tr id="nickfail"><th></th><td>사용 불가능한 닉네임입니다.</td></tr>
		<tr id="nickequal"><th></th><td>이전 닉네임과 동일합니다.</td></tr>
		<tr class="update"><td colspan="2" id="update"><input type="button" value="수정하기" id="submit"></td></tr>
	</table>
</form>
</body>
</html>