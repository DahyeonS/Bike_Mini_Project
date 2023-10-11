<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../home/topmenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>qnaUpdate.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
<script src="./script/sendAjax.js"></script>
<script>
	num = location.search.split('=')[1];
	
	function getBoard () {
	    num = location.search.split('=')[1];
	    const param = {num, num};
	    
    	sendAjax('qGetBoard.json', param).then( (data) => {
    		$('#title').attr('value', data['title']);
        	str = data['context'];
        	$('#context').html(str);
		})
	}
	
	function boardList () {
		num = location.search.split('=')[1];
		param = {num:num};
		
		sendAjax('aBoardList.json', param).then( (data) => {
			str = '<thead><tr><th style="width: 2%; text-align: center;">번호</th>';
			str += '<th style="width: 40.47713717693837%; text-align: center">제목</th>';
			str += '<th style="width: 3.302186878727635%; text-align: center">닉네임</th>';
			str += '<th style="width: 9.72962226640159%; text-align: center">작성일자</th></tr></thead>';
        	for(item of data) {
   
        		str += '<tr><td style="width: 2%; text-align: center;">' + item['num'] + '</td>';
        		str += '<td class="title" style="width: 40.47713717693837%;">' + '<a class="nav-link" href="#" onclick="aClick(' + item.num + ');">' + item['title'] + '</a>';
        		str += '</td><td class="nickname" style="text-align: center;">' + item['nickname'];
        		str += '</td><td class="postdate" style="text-align: center;">' + item['postdate'] + '</td></tr>';
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
        		location.href = '../khBoard/qnaList.do';
        	}
        	else {
        		alert('정상적으로 처리 하지 못했습니다');
        		location.href = '../khBoard/qnaUpdate.do';
        	}
		})
	}
	   
	function deleteBoard () {
	    num = location.search.split('=')[1];
	    const param = {num : num};
	    
	    sendAjax('deleteBoard.json', param).then( (data) => {
	    	if(data['rs'] == 1) {
        		alert('게시글 삭제가 완료 되었습니다');
        		location.href = '../khBoard/qnaList.do';
        	}
        	else {
        		alert('정상적으로 처리 하지 못했습니다');
        		location.href = '../khBoard/qnaUpdate.do';
        	}
		})
	}
	
	function beforeBoard () {
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
	
	function nextBoard () {
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
		$('#writeBtn').on('click', function() {
			location.href ='aWrite.jsp?num=' + num;
		});
	});
	
	window.onload = function() {
		getBoard();
		$('.buttons').hide();
		check();
		boardList();
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

<div class="card mb-4">
	<div class="card-header">
		<h3>Q&A 게시글 - 수정하기</h3>
	</div><br>
	<div class="col-lg-6 wow fadeInUp" data-wow-delay=".5s">
		<div class="rounded contact-form">
			<div class="mb-4">
				<input type="text" class="form-control p-3" placeholder="제목" id="title"><br>
				<textarea class="w-100 form-control p-3" rows="6" cols="10" placeholder="내용" id="context"></textarea>
			</div>
			<div class="mb-4" align="center">
				<input class="btn btn-secondary btn-sm" type="button" value="<<<이전글" id="beforeBtn" style="float: left;"/>
				<input class="btn btn-secondary btn-sm" type="button" value="수정 하기" id="updateBtn"/>
				<input class="btn btn-secondary btn-sm" type="reset" value="다시 입력" id="resetBtn">
				<input class="btn btn-secondary btn-sm" type="button" value="삭제 하기" id="deleteBtn">
				<button class="btn btn-secondary btn-sm" type="button" onclick="location.href = 'qnaList.do';">목록 보기</button>
				<input class="btn btn-secondary btn-sm" type="button" value="다음글>>>" id="nextBtn" style="float: right;">
			</div>
		</div>
	</div>
</div>

<div class="card mb-4">
	<div class="card-header">
		<h3>답변 목록</h3>
	</div><br>
</div>

<form name="answerList">
	<div id="aWrite">
		<input class="btn btn-secondary btn-sm" type="button" id="writeBtn" value="답변 작성"/>
	</div><br>
	<div class="datatable-container d-grid">
		<table id="aBoardList" class="datatable-table"></table>
	</div>
</form>
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
</body>
</html>