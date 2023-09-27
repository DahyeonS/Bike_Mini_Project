<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../member/loginCheck.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
<style>
	#nickname {text-align: left;}
	#postdate {text-align: right;}
	form, h2 {text-align: center;}
	#write {text-align: right;}
	table, th, td, input, select {
		margin: 0 auto;
		border-collapse: collapse;
		font-size: 14pt;
	}
	#context {
		width:1000px;
		height:800px;
		text-align: initial;
	}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<script>
function getQnaWriteView(param) {
    $.ajax({
        type: 'POST',
        url: 'qnaWriteView.json',
        dataType: 'json',
        data: param,
        success: function(data) {
        	console.log(data);
        	$('#qtitle').html(data['title']);
        	$('#qcontext').html(data['context']);
        	$('#nickname').html(data['nickname']);
        	$('#postdate').html("작성일자: " + data['postdate']);
        	$('.question').show();
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function qnaWrite(num) {
	const id = '<%=session.getAttribute("id")%>';
	const nickname = '<%=session.getAttribute("nickname")%>';
	const title = $('#title').val();
	const context = $('#context').val();
	const params = {num, id, nickname, title, context};
	console.log(params);
    $.ajax({
        type: 'POST',
        url: 'qnaWrite.json',
        dataType: 'json',
        data: params,
        success: function(data) {
        	console.log(data);
        	if(data['rs'] !== 0) {
                alert('게시글이 작성되었습니다.');
                location.href = '../qna/qnaBoardView.do?num=' + data['rs'];
            } else alert('다시 시도해주세요.');
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

$(function() {
	$('.question').hide();
	let num = <%=request.getParameter("num")%>
	if (num !== null) {
		const param = {num};
		getQnaWriteView(param)
	}
	$('#cancel').click(function() {
		const input = confirm('작성을 취소합니까?');
		if (input) history.back();
		else return;
	});
	$('#submit').click(function() {
		if (num == null) num = 0;
		qnaWrite(num);
	});
});
</script>
</head>
<body>
<%@include file="../home/topmenu.jsp" %>
<div class="question">
<h2 id="qtitle"></h2>
<hr>
<h4 id="nickname"></h4><h4 id="postdate"></h4>
<hr>
<h3 id="qcontext"></h3>
<br><br><br>
<hr><hr>
<h1 style="text-align: left;">답변 작성</h1>
<hr>
</div>
<form>
<h2><input type="text" id="title" placeholder="제목을 입력하세요."></h2>
<hr>
<textarea id="context" placeholder="내용을 입력하세요."></textarea>
</form>
<br>
<form style="text-align: right;" id="write">
<input type="button" value="작성하기" id="submit">
<input type="button" value="취소" id="cancel">
</form>
</body>
</html>