<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 게시판</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/boardlist.css">
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<%@include file="script/boardListScript.jsp"%>
</head>
<body>
<%@include file="../home/topmenu.jsp" %>
<h2>Q&A 게시판</h2>
	<form id="board">
		<div>
			<div class="search">
				<select class="select">
					<option value="title">제목</option>
					<option value="context">내용</option>
					<option value="nickname">작성자</option>
				</select>
				<input type="text" id="context">
				<input type="button" value="검색하기" id="search">
			</div>
			<table border="1">
				<thead>
					<tr>
						<th class="num">번호</th>
						<th class="title">제목</th>
						<th class="nickname">작성자</th>
						<th class="count">조회수</th>
						<th class="date">작성일</th>
						<c:if test="${id != null && grade != 'GENERAL'}">
						<th class="control">&nbsp</th>
						</c:if>
					</tr>
				</thead>
				<tbody id="tbody">
				</tbody>
				<tbody id="paging">
				</tbody>
			</table>
		</div>
	<div style="float: right;"><input type="button" value="글쓰기" id="write"></div>
	</form>
</body>
</html>