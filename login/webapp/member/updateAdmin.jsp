<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="loginCheck.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정(관리자용)</title>
<style>
	h2, h3 {text-align: center;}
	table, th, td, input, select {
		margin: 0 auto;
		border-collapse: collapse;
		font-size: 14pt;
	}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<script src="../script/updateadmin.js"></script>
</head>
<body>
<%@include file="../loginmenu.jsp"%>
<h2>회원정보 수정</h2>
<hr>
<form>
	<h3>조회할 회원의 아이디 또는 닉네임을 입력하세요.</h3>
	<table>
	<tr><td><input type="text" name="context" id="context"></td>
	<td><input type="button" value="검색" id="search"></tr>
	</table>
</form>
<br>
<form id="member">
	<table>
		<tr><th>아이디</th><td><input type="text" name="id" id="id" readonly="readonly"></td></tr>
		<tr><th>닉네임</th><td><input type="text" name="nickname" id="nickname"></td></tr>
<% 		String seGrade = (String)session.getAttribute("grade");
		if (seGrade.equals("MANAGER")) { %>
		<tr><td colspan="2"><select name="grade" id="grade">
			<option value="ASSOCIATE">부매니저</option>
			<option value="STAFF">스태프</option>
			<option value="GENERAL" selected="selected">일반회원</option>
		</select></td></tr>
<% 		} %>
		<tr><th colspan="2">&nbsp</th><td><input type="button" value="수정하기" id="submit"></td></tr>
		<tr><th>&nbsp</th></tr>
		<tr><th colspan="2">&nbsp</th><td><input type="button" value="회원탈퇴" id="delete" onclick="memberDeleteConfirm();"></td></tr>
	</table>
</form>
</body>
</html>