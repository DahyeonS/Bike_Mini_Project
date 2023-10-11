<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../home/topmenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardUpdate.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
<script src="./script/sendAjax.js"></script>
<script>
	
	function getBoard () {
	    num = location.search.split('=')[1];
	    const param = {num, num};
	    
	    sendAjax('getBoard.json', param).then( (data) => {
	    	$('#title').attr('value', data['title']);
        	str = data['context'];
        	$('#context').html(str);
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
	
	function visit_count_plus () {
		num = location.search.split('=')[1];
		const param = {num : num};
	    sendAjax('visit_count_plus.json', param).then( (data) => {
		})
	}
	
	window.onload = function() {
		visit_count_plus();
		getBoard();
	}
	
</script>
</head>
<body>

	<div class="container text-center">
		<div class="row justify-content-md-center">
			<div class="col col-lg-2"></div>
			<div class="card mb-4 border-light justify-content-md-center">
				<div class="card-header ">
					<h3>일반 게시판 수정하기</h3>
				</div>
				<br>
				<div class="card-body" data-wow-delay=".5s">
					<div class="rounded contact-form">
						<div class="mb-4 justify-content-md-center">
							<input type="text" class="form-control p-1" placeholder="제목"
								id="title"><br>
							<textarea class="w-100 form-control p-3" rows="6" cols="10"
								placeholder="내용" id="context"></textarea>
						</div>
						<div class="mb-4" align="center">
							<input class="btn btn-secondary btn-sm" type="button"
								value="<<<이전글" id="beforeBtn" style="float: left;" /> <input
								class="btn btn-secondary btn-sm" type="button" value="수정 하기"
								id="updateBtn" /> <input class="btn btn-secondary btn-sm"
								type="reset" value="다시 입력" id="resetBtn"> <input
								class="btn btn-secondary btn-sm" type="button" value="삭제 하기"
								id="deleteBtn">
							<button class="btn btn-secondary btn-sm" type="button"
								onclick="location.href = 'boardList.do';">목록 보기</button>
							<input class="btn btn-secondary btn-sm" type="button"
								value="다음글>>>" id="nextBtn" style="float: right;">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
</body>
</html>