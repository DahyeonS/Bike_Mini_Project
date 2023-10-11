<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../home/topmenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>aWrite.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
<script src="script/sendAjax.js"></script>
<script>

	function aGetBoard () {
	    num = location.search.split('=')[1];
	    const param = {num, num};
	    
	    sendAjax('qGetBoard.json', param).then( (data) => {
	    	$('#title2').attr('value', data['title']);
        	str = data['context'];
        	$('#context2').html(str);
		})
	}
	    
	function aInsertWrite () {
		num = location.search.split('=')[1];
    	const params = {title: $('#title').val(), context: $('#context').val(), num:num};
    	
    	sendAjax('aInsertWrite.json', params).then( (data) => {
    		if(data['rs'] == 1) {
	        		alert('글 작성이 완료 되었습니다');
	        		location.href = '../khBoard/qnaList.do';
	        }
    		else {
    			 alert('글 작성에 실패했습니다');
	        		location.href = '../khBoard/qnaList.do';
    		}
 		})
 	}
	  

	$(function name() {  // 실행시 자동으로 실행
		$('#writeBtn').on('click', function() {
			aInsertWrite();
		});

	});
	
	window.onload = function() {
		a();
	}
	
	function aGetBoard () {
	    num = location.search.split('=')[1];
	    const param = {num, num};
	    
	    sendAjax('qGetBoard.json', param).then( (data) => {
	    	$('#title2').attr('value', data['title']);
        	str = data['context'];
        	$('#context2').html(str);
		})
	}
	
</script>
</head>
<body>
<div class="card mb-4">
	<div class="card-header">
		<h3>Q&A 게시글 - 답글 작성하기</h3>
	</div>
	<div class="col-lg-6 wow fadeInUp" data-wow-delay=".5s">
		<div class="rounded contact-form">
			<div class="mb-4">
				<input type="text" class="form-control p-3" placeholder="제목" id="title"><br>
				<textarea class="w-100 form-control p-3" rows="6" cols="10" placeholder="내용" id="context"></textarea>
			</div>
			<div class="mb-4" align="center">
				<input class="btn btn-secondary btn-sm" type="button" value="작성 완료" id="writeBtn" />
				<button class="btn btn-secondary btn-sm" type="reset">다시 입력</button>
				<button class="btn btn-secondary btn-sm" type="button" onclick="location.href = 'qnaList.do';">목록 보기</button></td>
			</div>
		</div>
	</div>
</div>
<div class="card mb-4">
	<div class="card-header">
		<h3>Q&A 게시글 - 질문 내용</h3>
	</div>
	<div class="col-lg-6 wow fadeInUp" data-wow-delay=".5s">
		<div class="rounded contact-form">
			<div class="mb-4">
				<input type="text" class="form-control p-3" placeholder="제목" id="title2" readonly><br>
				<textarea class="w-100 form-control p-3" rows="6" cols="10" placeholder="내용" id="context2" readonly></textarea>
			</div>
		</div>
	</div>
</div>

	<h1 class="test"></h1>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
</body>
</html>