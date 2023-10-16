<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%@include file="../member/loginCheck.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/boardwrite.css">
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<%@include file="script/boardWriteScript.jsp"%>
</head>
<body>
<%@include file="../home/topmenu.jsp" %>
<div class="question">
<h2 id="qtitle"></h2>
<h4 id="nickname"></h4><h4 id="postdate"></h4><h4 id="updatedate"></h4>
<br>
<h3 id="qcontext"></h3>
<br><br><br>
<hr style="border: solid black 1pt;">
<h1 style="text-align: left; font-weight: bold;">답변 작성</h1>
<br>
</div>
<form>
<h2><input type="text" id="title" placeholder="제목을 입력하세요."></h2>
<br>
<textarea id="context" placeholder="내용을 입력하세요."></textarea>
</form>
<br>
<form style="text-align: right;" id="write">
<c:if test="${param.update == null}">
<input type="button" value="작성하기" id="submit">
</c:if>
<c:if test="${param.update != null}">
<input type="button" value="수정하기" id="update">
</c:if>
<input type="button" value="취소" id="cancel">
</form>
</body>
</html>