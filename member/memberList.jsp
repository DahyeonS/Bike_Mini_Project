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
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/memberlist.css">
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<script src="script/memberlist.js"></script>
</head>
<body>
<%@include file="../home/topmenu.jsp" %>
<h2>회원목록</h2>
<br>
<div class="manage">
<a href="../member/updateAdmin.do" id="manage">회원관리</a></td>
</div>
<table border="1" class="list">

<thead>
<tr>
	<th class="num">일련번호</th>
	<th>아이디</th>
	<th>닉네임</th>
	<th class="grade">등급</th>
	<th>가입날짜</th>
</tr>
</thead>

<tbody id="tbody">
</tbody>

</table>
</body>
</html>