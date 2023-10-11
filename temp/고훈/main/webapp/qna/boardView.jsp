<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%@include file="../member/loginCheck.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style>
	#nickname, #anickname {text-align: left;}
	#postdate, #updatedate, #visitcount, #apostdate, #aupdatedate {text-align: right;}
	form, h2 {text-align: center;}
	#answertext {text-align: left;}
	#rcontext {text-align: left;}
	table, th, td, input, select {
		margin: 0 auto;
		border-collapse: collapse;
		font-size: 14pt;
	}
	textarea {
		width:300px;
		height:50px;
		text-align: initial;
	}
	#rpostdate {
		font-size: 12pt;
		text-align: right;
		font-style: italic;
	}
	#rdelete {
		font-size: 12pt;
		text-align: right;
	}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<%@include file="./script/boardViewScript.jsp"%>
</head>
<body>
<%@include file="../home/topmenu.jsp" %>
<div class="question">
<h2 id="title"></h2>
<hr>
<h4 id="nickname"></h4><h4 id="postdate"></h4><h4 id="updatedate"></h4><br><h4 id="visitcount"></h4>
<hr>
<h3 id="context"></h3>
<div class="control"></div><br><br>
<br><br><br>
<div class="replies">
<table id="replylist${param.num}">
</table>
<br><br><br>
</div>
<table>
<tr>
<td>${nickname}님</td>
<td>&nbsp&nbsp<textarea id="reply${param.num}"></textarea>&nbsp&nbsp</td>
<td><input type="button" value="댓글 작성" onclick="writeReply(${param.num});"></td>
<tr>
</table>
</div>
<br><br><br>
<form>
<br>
<input type="button" value="답변하기" id="answer">
</form>
<div class="answer">
<br>
<br><br><br><br>
<hr style="border: solid black 1pt;">
<h2 id="answertext">답변</h2>
<div class="answerlist">
</div>
</div>
<br><br><br><br>
<input type="button" value="목록보기" id="list">
<input style="text-align: right;" type="button" value="글쓰기" id="write">
</body>
</html>