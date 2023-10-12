<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 게시판</title>
<style>
	form, h2 {text-align: center;}
	table, th, td, input, select {
		margin: 0 auto;
		border-collapse: collapse;
		font-size: 14pt;
	}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<%@include file="./script/boardListScript.jsp"%>
</head>
<body>
<%@include file="../home/topmenu.jsp" %>
<h2>Q&A 게시판</h2>
<hr>
	<form id="board">
		<div>
			<div>
				<div>
					<select id="select">
						<option value="title">제목</option>
						<option value="context">내용</option>
						<option value="nickname">작성자</option>
					</select>
					<input type="text" id="context">
					<input type="button" value="검색하기" id="search">
				</div>
			</div>
			<table border="1">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>조회수</th>
						<th>작성일</th>
						<c:if test="${id != null && grade != 'GENERAL'}">
						<th>&nbsp</th>
						</c:if>
					</tr>
				</thead>
				<tbody id="tbody">
						
				</tbody>
			</table>
		</div>
	<div style="float: right;"><input type="button" value="글쓰기" id="write"></div>
	</form>
</body>
</html>