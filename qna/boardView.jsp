<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../member/loginCheck.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style>
	#nickname {text-align: left;}
	#postdate, #visitcount {text-align: right;}
	form, h2 {text-align: center;}
	table, th, td, input, select {
		margin: 0 auto;
		border-collapse: collapse;
		font-size: 14pt;
	}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<script>
function getQnaBoardView() {
	const num = '<%=request.getParameter("num")%>';
	const param = {num};
    $.ajax({
        type: 'POST',
        url: 'qnaBoardView.json',
        dataType: 'json',
        data: param,
        success: function(data) {
        	$('title').html(data['title']);
        	$('h2').html(data['title']);
        	$('h3').html(data['context']);
        	$('#nickname').html("작성자 " + data['nickname']);
        	$('#postdate').html("작성일자 " + data['postdate']);
        	$('#visitcount').html("조회수 " + data['visitCount']);
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

$(function() {
	getQnaBoardView();
	$('#list').click(function() {
		location.href = '../qna/qnaBoardList.do';
	});
	$('#write').click(function() {
		location.href = '../qna/qnaWrite.do';
	});
	$('#answer').click(function() {
		location.href = '../qna/qnaWrite.do?num=<%=request.getParameter("num")%>';
	});
});
</script>
</head>
<body>
<%@include file="../home/topmenu.jsp" %>
<h2></h2>
<hr>
<h4 id="nickname"></h4><h4 id="postdate"></h4><h4 id="visitcount"></h4>
<hr>
<h3></h3>
<br><br><br>
<form>
<input type="button" value="답변하기" id="answer">
</form>
<input type="button" value="목록보기" id="list">
<input style="text-align: right;" type="button" value="글쓰기" id="write">
</body>
</html>