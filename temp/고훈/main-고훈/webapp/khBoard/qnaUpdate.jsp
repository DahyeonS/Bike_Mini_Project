<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../home/topmenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>qnaUpdate.jsp</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
<script src="./script/sendAjax.js"></script>
<script>
	num = location.search.split('=')[1];
	
	function qGetBoard () {
	    num = location.search.split('=')[1];
	    const param = {num, num};
	    
    	sendAjax('qGetBoard.json', param).then( (data) => {
    		$('#title').attr('value', data['title']);
        	str = '<textarea name="context" id="context"style="width:100%; height: 300px;">' + data['context'] + '</textarea>';
        	$('#textArea').html(str);
		})
	}
	
	function aBoardList () {
		num = location.search.split('=')[1];
		param = {num:num};
		
		sendAjax('aBoardList.json', param).then( (data) => {
			str = '<tr><td class="num">번호</td><td class="context">내용</td><td class="nickname">닉네임</td><td class="postdate">작성 날짜</td></tr>';
        	for(item of data) {
        		str += '<tr><td class="num">' + item['num'];
        		str += '</td><td class="context">' + item['context'];
        		str += '</td><td class="nickname">' + item['nickname'];
        		str += '</td><td class="postdate">' + item['postdate'] + '</td></tr>';
        	}
        	$('#aBoardList').html(str);
		})
	}
	   
	function updateBoard () {
	    num = location.search.split('=')[1];
	    const param = {num : num, title : $('#title').val(), context : $('#context').val()};
	
	    sendAjax('updateBoard.json', param).then( (data) => {
	    	if(data['rs'] == 1) {
        		alert('수정이 완료 되었습니다');
        		location.href = '../khBoard/boardList.do';
        	}
        	else {
        		alert('정상적으로 처리 하지 못했습니다');
        		location.href = '../khBoard/boardUpdate.do';
        	}
		})
	}
	   
	function deleteBoard () {
	    num = location.search.split('=')[1];
	    const param = {num : num};
	    
	    sendAjax('deleteBoard.json', param).then( (data) => {
	    	if(data['rs'] == 1) {
        		alert('게시글 삭제가 완료 되었습니다');
        		location.href = '../khBoard/boardList.do';
        	}
        	else {
        		alert('정상적으로 처리 하지 못했습니다');
        		location.href = '../khBoard/boardUpdate.do';
        	}
		})
	}
	
	function qBeforeBoard () {
	    num = location.search.split('=')[1];
	    const param = {num : num};
	    
	    sendAjax('qBeforeBoard.json', param).then( (data) => {
	    	if(data['beforeNum'] == 0) {
        		alert('이전 게시글이 존재하지 않습니다');
        		location.href = '../khBoard/qnaUpdate.do?num=' + num;
        	}
        	else {
        		location.href = '../khBoard/qnaUpdate.do?num=' + data['beforeNum'];
        	}
		})
	}
	
	function qNextBoard () {
	    num = location.search.split('=')[1];
	    const param = {num : num};
	    
	    sendAjax('qNextBoard.json', param).then( (data) => {
	    	if(data['nextNum'] == 0) {
        		alert('다음 게시글이 존재하지 않습니다');
        		location.href = '../khBoard/qnaUpdate.do?num=' + num;
        	}
        	else {
        		location.href = '../khBoard/qnaUpdate.do?num=' + data['nextNum'];
        	}
		})
	}
	
	function check () {
	    num = location.search.split('=')[1];
	    const param = {num : num};
	    
	    sendAjax('qGetBoard.json', param).then( (data) => {
	    	if(data['id'] == "${id}") {
        		$('.buttons').show();
        	}
		})
	}
	 
	function aClick (num) {
		str = '${id}';
		if(str == '') {
			alert('회원만 게시물을 확인할 수 있습니다');
			location.href = "../khBoard/qnaList.do";
		}
		else {
			location.href = "../khBoard/aWrite.jsp?num=" + num;		
		}
	}
	
	$(function name() {  // 실행시 자동으로 실행
		$('#updateBtn').on('click', function() {
			updateBoard();
			qGetBoard();
		});
		$('#resetBtn').on('click', function() {
			$('#title').attr('value', '');
        	str = '<textarea name="context" id="context"style="width:100%; height: 300px;"></textarea>';
        	$('#textArea').html(str);
		});
		$('#deleteBtn').on('click', function() {
			deleteBoard();
			qGetBoard();
		});
		$('#beforeBtn').on('click', function() {
			qBeforeBoard();
			qGetBoard();
		});
		$('#nextBtn').on('click', function() {
			qNextBoard();
			qGetBoard();
		});
		$('#writeBtn').on('click', function() {
			location.href ='aWrite.jsp?num=' + num;
		});
	});
	
	window.onload = function() {
		qGetBoard();
		$('.buttons').hide();
		check();
		aBoardList();
	}
	
</script>
<style>
	.num {width: 4%; text-align: center;}
	.context {width: 30%;}
	.nickname {width: 5%; text-align: center;}
	.postdate {width: 5%; text-align: center;}
	a { text-decoration-line: none; color:black;}
	a:visited { color:black;}

</style>
</head>
<body>
<h2> 회원제 게시판 - 수정하기</h2>
<form name="writeForm">
	<table border="1" width="60%">
	<tr>
		<td align="center" width="50px">제목</td>
		<td><input type="text" name="title" id="title" style="width:100%" /></td>
	</tr>
	<tr>
		<td align="center">내용</td>
		<td id="textArea"></td>
	</tr>
	<tr>
		<td colspan="2" align="center" >
			<input type="button" value="<<<이전글" id="beforeBtn" style="float: left;"/>
			<input type="button" value="수정 하기" id="updateBtn" class='buttons'/>
			<input type="button" value="다시 입력" id="resetBtn" class='buttons'/>
			<input type="button" value="삭제 하기" id="deleteBtn" class='buttons'/>
			<button type="button" onclick="location.href = 'boardList.do';">목록 보기</button>
			<input type="button" value="다음글>>>" id="nextBtn" style="float: right;">
		</td>
	</tr>
	</table>
</form>


<h3> 답변 목록 </h3>

<form name="answerList">
	<div id="aWrite">
		<input type="button" id="writeBtn" value="답변 작성"/>
	</div>
	<table border="1" width="60%">
		<tbody id="aBoardList">
		</tbody>
	</table>
</form>

</body>
</html>