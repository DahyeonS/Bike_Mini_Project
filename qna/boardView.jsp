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
	#postdate, #visitcount, #apostdate, #avisitcount {text-align: right;}
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
        	$('#title').html(data['title']);
        	$('#context').html(data['context']);
        	$('#nickname').html("작성자 " + data['nickname']);
        	$('#postdate').html("작성일자 " + data['postdate']);
        	$('#visitcount').html("조회수 " + data['visitCount']);
        	let string = '';
        	if ('<%=session.getAttribute("nickname")%>' === data['nickname'] || '<%=session.getAttribute("grade")%>' !== 'GENERAL') string += '<input type="button" value="삭제하기" onclick="deleteBoard(' + data['num'] + ');" style="float: right;">';
    		if ('<%=session.getAttribute("nickname")%>' === data['nickname']) string += '<input type="button" value="수정하기" onclick="updateBoard(' + data['num'] + ');" style="float: right;">';
    		$('.control').html(string);
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function getQnaAnswerView() {
	const num = '<%=request.getParameter("num")%>';
	const param = {num};
    $.ajax({
        type: 'POST',
        url: 'qnaAnswerView.json',
        dataType: 'json',
        data: param,
        success: function(data) {
        	if (data[0]['num'] !== 0) {
	        	let string = '';
	        		for (item of data) {
		        		string += '<br><br><h2>' + item['title'] + '</h2><hr><h4>작성자 ' + item['nickname'] + '</h4><h4>작성일자 ';
		        		string += item['postdate'] + '</h4><hr><h3>' + item['context'] + '</h3>';
		        		if ('<%=session.getAttribute("nickname")%>' === item['nickname'] || '<%=session.getAttribute("grade")%>' !== 'GENERAL') string += '<input type="button" value="삭제하기" onclick="deleteAnswer(' + item['num'] + ');" style="float: right;">';
		        		if ('<%=session.getAttribute("nickname")%>' === item['nickname']) string += '<input type="button" value="수정하기" onclick="updateBoard(' + item['num'] + ');" style="float: right;">';
		        		getQnaReplyView(item['num']);
		        		string += '<br><br><br><br><div class="replies"><table id="replylist' + item['num'] + '"></table>'
		        		string += '<br><br><br><table><tr><td>${nickname}님</td><td>&nbsp&nbsp<textarea id="reply' + item['num'] + '"></textarea>&nbsp&nbsp</td><td><input type="button" value="댓글 작성" onclick="writeReply(' + item['num'] + ');"></td><tr></table>';
	        		}
				$('.answerlist').html(string);
				$('.answer').show();
				getQnaReplyView(item['num']);
        	}
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function qnaDeleteBoard(param) {
    $.ajax({
        type: 'POST',
        url: 'qnaDeleteBoard.json',
        dataType: 'json',
        data: param,
        success: function(data) {
            if(data['rs'] !== 0) {
                alert('게시글이 삭제되었습니다.');
                location.href = '../qna/qnaBoardList.do';
            } else alert('죄송합니다. 다시 시도해주세요.');
        }, error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function qnaDeleteAnswer(param) {
	const num = '<%=request.getParameter("num")%>';
    $.ajax({
        type: 'POST',
        url: 'qnaDeleteBoard.json',
        dataType: 'json',
        data: param,
        success: function(data) {
            if(data['rs'] === 1) {
                alert('게시글이 삭제되었습니다.');
                location.href = '../qna/qnaBoardView.do?num=' + num;
            } else alert('죄송합니다. 다시 시도해주세요.');
        }, error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function writeReply(num) {
	const id = '<%=session.getAttribute("id")%>';
	const nickname = '<%=session.getAttribute("nickname")%>';
	const context = $('#reply' + num).val();
	
	if (context === '') alert('내용을 입력해주세요.');
	else {
		const params = {id, num, nickname, context};
		console.log(params);
	    $.ajax({
	        type: 'POST',
	        url: 'qnaWriteReply.json',
	        dataType: 'json',
	        data: params,
	        success: function(data) {
	        	if(data['rs'] !== 0) {
	                alert('댓글이 작성되었습니다.');
	                location.href = '../qna/qnaBoardView.do?num=' + ${param.num};
	            } else alert('다시 시도해주세요.');
	        },
	        error: function(xhr, status, error) {
	            console.log(xhr, status, error);
	        }
	    });
	}
};

function getQnaReplyView(num) {
	const param = {num};
    $.ajax({
        type: 'POST',
        url: 'qnaReplyView.json',
        dataType: 'json',
        data: param,
        success: function(data) {
        	console.log(data[0]['num']);
        	if (data[0]['num'] !== 0) {
	        	let string = '';
	        	for (item of data) {
	        		string += '<tr><td id="rnickname">' + item['nickname'] + '님&nbsp&nbsp&nbsp</td><td id="rcontext">' + item['context'] + '</td></tr><tr><td id="rpostdate">' + item['postdate'] + '</td><td id="rdelete"><a href="#" onclick="deleteReply(' + item['num'] + ')">삭제</td></tr><tr><td>&nbsp</td></tr>';
	        	}
	        	$('#replylist' + num).html(string);
	        	$('.replies').show();
        	}
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function updateBoard(update) {
	const num = '<%=request.getParameter("num")%>';
	if (num == update) location.href = '../qna/qnaWrite.do?update=' + update;
	else location.href = '../qna/qnaWrite.do?update=' + update + '&num=' + num;
};

function deleteBoard(num) {
	const input = confirm('해당 게시글을 삭제합니까?');
	if (input) {
		const param = {num};
		qnaDeleteBoard(param);
	} else return;
};

function deleteAnswer(num) {
	const input = confirm('해당 게시글을 삭제합니까?');
	if (input) {
		const param = {num};
		qnaDeleteAnswer(param);
	} else return;
};

$(function() {
	$('.answer').hide();
	getQnaBoardView();
	getQnaAnswerView();
	
	$('.replies').hide();
	const num = '<%=request.getParameter("num")%>';
	getQnaReplyView(num);
	
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
<div class="question">
<h2 id="title"></h2>
<hr>
<h4 id="nickname"></h4><h4 id="postdate"></h4><h4 id="visitcount"></h4>
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