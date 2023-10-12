<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="loginCheck.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원목록</title>
<style>
	h2 {text-align: center;}
	table, th, td, input, #manage {
		margin: 0 auto;
		border-collapse: collapse;
		font-size: 14pt;
	}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<script src="./script/memberlist.js"></script>
</head>
<body>
<%@include file="../home/topmenu.jsp" %>
<h2>회원목록</h2>
<hr>
<a href="updateAdmin.do" id="manage">회원관리</a>
<br><br>
<table border="1">

<thead>
<tr>
	<th>일련번호</th>
	<th>아이디</th>
	<th>비밀번호</th>
	<th>닉네임</th>
	<th>등급</th>
	<th>가입날짜</th>
</tr>
</thead>

<tbody id="tbody">
</tbody>

</table>
</body>
</html>