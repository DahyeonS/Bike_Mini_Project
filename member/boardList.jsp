<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 조회</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/boardlist.css">
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<%@include file="script/boardListScript.jsp"%>
</head>
<body>
<%@include file="../home/topmenu.jsp" %>
<h2>게시글 조회</h2>
<hr>
	<form id="board">
		<div>
			<div>
				<div>
					<select id="select">
						<option value="title">제목</option>
						<option value="context">내용</option>
					</select>
					<input type="text" id="context">
					<input type="button" value="검색하기" id="search">
					<select id="category">
						<option value="none">선택</option>
						<option value="question">질문</option>
						<option value="normal">일반</option>
						<option value="answer">답변</option>
						<option value="reply">답글</option>
						<option value="novel">소설</option>
						<option value="free">자유</option>
						<option value="photo">사진</option>
					</select>
				</div>
			</div>
			<table border="1">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>카테고리</th>
						<th>조회수</th>
						<th>작성일</th>
						<th>&nbsp</th>
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