<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../home/topmenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardUpdate.jsp</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
<script src="./script/sendAjax.js"></script>
<script>
	
	function getBoard () {
	    num = location.search.split('=')[1];
	    const param = {num, num};
	    
	    sendAjax('getBoard.json', param).then( (data) => {
	    	$('#title').attr('value', data['title']);
        	str = '<textarea name="context" id="context"style="width:100%; height: 300px;">' + data['context'] + '</textarea>';
        	$('#textArea').html(str);
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
	
	function beforeBoard () {
	    num = location.search.split('=')[1];
	    const param = {num : num};
	    
	    sendAjax('beforeBoard.json', param).then( (data) => {
	    	if(data['beforeNum'] == 0) {
        		alert('이전 게시글이 존재하지 않습니다');
        		location.href = '../khBoard/boardUpdate.do?num=' + num;
        	}
        	else {
        		location.href = '../khBoard/boardUpdate.do?num=' + data['beforeNum'];
        	}
		})
	}
	
	function nextBoard () {
	    num = location.search.split('=')[1];
	    const param = {num : num};
	    
	    sendAjax('nextBoard.json', param).then( (data) => {
	    	if(data['nextNum'] == 0) {
        		alert('다음 게시글이 존재하지 않습니다');
        		location.href = '../khBoard/boardUpdate.do?num=' + num;
        	}
        	else {
        		location.href = '../khBoard/boardUpdate.do?num=' + data['nextNum'];
        	}
		})
	}
	
	$(function name() {  // 실행시 자동으로 실행
		$('#updateBtn').on('click', function() {
			updateBoard();
			getBoard();
		});
		$('#resetBtn').on('click', function() {
			$('#title').attr('value', '');
        	str = '<textarea name="context" id="context"style="width:100%; height: 300px;"></textarea>';
        	$('#textArea').html(str);
		});
		$('#deleteBtn').on('click', function() {
			deleteBoard();
			getBoard();
		});
		$('#beforeBtn').on('click', function() {
			beforeBoard();
			getBoard();
		});
		$('#nextBtn').on('click', function() {
			nextBoard();
			getBoard();
		});
	});
	
	window.onload = function() {
		getBoard();
	}
	
</script>
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
		<td colspan="2" align="center">
			<input type="button" value="<<<이전글" id="beforeBtn" style="float: left;"/>
			<input type="button" value="수정 하기" id="updateBtn"/>
			<input type="button" value="다시 입력" id="resetBtn">
			<input type="button" value="삭제 하기" id="deleteBtn">
			<button type="button" onclick="location.href = 'boardList.do';">목록 보기</button>
			<input type="button" value="다음글>>>" id="nextBtn" style="float: right;">
		</td>
	</tr>
	</table>

</form>
</body>
</html>