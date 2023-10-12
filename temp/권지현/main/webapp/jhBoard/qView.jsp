<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QView.jsp</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Caveat&family=Nanum+Pen+Script&display=swap');
</style>
<style>
	body {
		background-image: url('jhImages8.png');
		background-size: 100%;
		background-repeat: no-repeat;
		background-attachment: fixed;
		background-position: 0px, 50%;
	}
	
	* {
		font-family: 'Caveat', cursive;
		font-family: 'Nanum Pen Script', cursive;		
	}
	
	.border {
		border: 100px
	}
	
	table {
		margin : auto;
   		width : 80%;
   		background-color: white;
	}
	
	.head {
		font-weight: bold;
	}
	
	
</style>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
<script>

function viewBoard() {
	num = location.search.split('=')[1];
	const param = {num : num};
	$.ajax({	
		type: 'post',
		url: '../jhBoard/QViewBoard.json',
    	data: param,
    	dataType: 'json',
    	success: function(data) {
    		$('#title').attr('value', data['title']);
    		str = '<textarea name="context" id="context" style="width:100%; height: 300px;">' + data['context'] + '</textarea>';
    		$('#textArea').html(str);    	
    	},
    	error: function(xhr, status, error) {
        	console.log(xhr, status, error);
    	}
	});
	visitCount();
}

function visitCount() {
	num = location.search.split('=')[1];
	const param = {num};
	$.ajax({
		type: 'post',
        url: '../jhBoard/visitCount.json',
        data: param,
        dataType: 'json',
        success: function(data) {
      	
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });	
}

function aViewBoard() {
	num = location.search.split('=')[1];
	const param = {num : num};
	$.ajax({	
		type: 'post',
		url: '../jhBoard/AViewBoard.json',
    	data: param,
    	dataType: 'json',
    	success: function(data) {
    		str = '<tr><td class="num head">번호</td><td class="context head">내용</td><td class="nickname head">닉네임</td><td class="postdate head">작성 날짜</td></tr>';
        	for(item of data) {
        		str += '<tr><td class="num">' + item['num'];
        		str += '</td><td class="context">' + item['context'];
        		str += '</td><td class="nickname">' + item['nickname'];
        		str += '</td><td class="postdate">' + item['postdate'] + '</td></tr>';
        	}
    		$('#aViewBoard').html(str);    	
    	},
    	error: function(xhr, status, error) {
        	console.log(xhr, status, error);
    	}
	});
}

function editBoard() {
	console.log("고자");
	num = location.search.split('=')[1];
	const param = {num : num, title : $('#title').val(), context : $('#context').val()};
	$.ajax({
		type: 'post',
        url: '../jhBoard/QEditBoard.json',
        data: param,
        dataType: 'json',
        success: function(data) {
        	if(data['rs'] == 1) {
        		alert('수정이 완료 되었습니다');
        		location.href = '../jhBoard/qnaBoardList.do';
        	}
        	else {
        		alert('정상적으로 처리 하지 못했습니다');
        		location.href = '../jhBoard/qView.do';
        	}
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
	
}

function deleteBoard () {
    num = location.search.split('=')[1];
    const param = {num : num};

    $.ajax({
        contentType: 'application.json',
        type: 'GET',
        url: '..jhboard/deleteBoard.json',
        data: param,
        dataType: 'json',
        success: function(data) {
        	if(data['rs'] == 1) {
        		alert('게시글 삭제가 완료 되었습니다');
        		location.href = '../jhBoard/boardList.do';
        	}
        	else {
        		alert('정상적으로 처리 하지 못했습니다');
        		location.href = '../jhBoard/view.do';
        	}
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
}

function check () {
    num = location.search.split('=')[1];
    const param = {num : num};    
    $.ajax({
        contentType: 'application.json',
        type: 'GET',
        url: '..jhboard/qGetBoard.json',
        data: param,
        dataType: 'json',
        success: function(data) {
        	str = '${id}';
        	if(data['id'] == str) {
        		$('.buttons').show();
        	}
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
}

function beforeBoard () {
    num = location.search.split('=')[1];
    const param = {num : num};
    $.ajax({
        contentType: 'application.json',
        type: 'GET',
        url: '..jhboard/qBeforeBoard.json',
        data: param,
        dataType: 'json',
        success: function(data) {
        	if(data['beforeNum'] == 0) {
        		alert('이전 게시글이 존재하지 않습니다');
        		location.href = '../jhBoard/qView.do?num=' + num;
        	}
        	else {
        		location.href = '../jhBoard/qView.do?num=' + data['beforeNum'];
        	}
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    
    
	});
}

function nextBoard () {
    num = location.search.split('=')[1];
    const param = {num : num};
    $.ajax({
        contentType: 'application.json',
        type: 'GET',
        url: '..jhboard/qNextBoard.json',
        data: param,
        dataType: 'json',
        success: function(data) {
        	if(data['nextNum'] == 0) {
        		alert('다음 게시글이 존재하지 않습니다');
        		location.href = '../jhBoard/qView.do?num=' + num;
        	}
        	else {
        		location.href = '../jhBoard/qView.do?num=' + data['nextNum'];
        	}
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    
    
	});
}

window.onload = function() {
	viewBoard();
	aViewBoard();
	$('.buttons').hide();
	check();
}

$(function name() {
	$('#editBtn').on('click', function() {
		editBoard();
		viewBoard();
	});	
	
	$('#deleteBtn').on('click', function() {
		deleteBoard();
		viewBoard();
	});	
	$('#writeBtn').on('click', function() {
		num = location.search.split('=')[1];
		location.href = "../jhBoard/aWrite.do?num=" + num;		
	});
	
	$('#beforeBtn').on('click', function() {
		beforeBoard();
		viewBoard();
	});
	
	$('#nextBtn').on('click', function() {
		nextBoard();
		viewBoard();
	});	
});
</script>
</head>
<body>
<%@include file="../home/topmenu.jsp" %>
<h3 class="head">&nbsp; 상세 보기</h3>
<form name ="board">
<table border ="1" width="70%">
	<tr>
		<td align="center" width="20%" class="head" >제목</td>
		<td><input type="text" id="title" style="width:50%"></td>	
	</tr>
	<tr>
		<td align="center" class="head">내용</td>
		<td id="textArea"></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
		<input type="button" value="<<<이전 글 보기" class="border" id="beforeBtn" style="float: left;"/> 
		<input type="button" value ="수정하기" class="border buttons" id="editBtn"/>
		<input type="button" value ="삭제하기" class="border buttons" id="deleteBtn"/>
		<input type="button" value="다음 글 보기>>>" class="border" id="nextBtn" style="float: right;"/> 
		</td>
	</tr>
</table>
</form>
<h3 class="head">&nbsp; 답글 목록</h3>

<form name="answerList">
		<table border="1" width="70%" class="table table-striped">
			<tbody id="aViewBoard">
		
			</tbody>
		</table>
	</form>	
	<div id="reply">
			&nbsp; <input type="button" id="writeBtn" value="답변하기" class="border">
		</div>
</body>
</html>