<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 조회</title>
<style>
	#nickname {text-align: left;}
	#postdate {text-align: right;}
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
        	$('h2').html(data['title']);
        	$('h3').html(data['context']);
        	$('#nickname').html("작성자: " + data['nickname']);
        	$('#postdate').html("작성일자: " + data['postdate']);
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

$(function() {
	getQnaBoardView();
});
</script>
</head>
<body>
<%@include file="../home/topmenu.jsp" %>
<h2></h2>
<hr>
<h4 id="nickname"></h4><h4 id="postdate"></h4>
<hr>
<h3></h3>
<br><br><br>
<form>
<input type="button" value="답변하기">
</form>
<a href="qnaBoardList.do">목록보기</a>
</body>
</html>