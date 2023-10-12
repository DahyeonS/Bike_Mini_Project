<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../home/topmenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardWrite.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
<script src="./script/sendAjax.js"></script>
<script>

	function check (form) {
		if(form.attechedFile.value == "") {
			alert('사진 파일을 첨부해 주세요');
			return false;
		}
	}
	function rsCheck() {
		if(${rs} == 0) {
			alert('게시글 작성에 실패 했습니다');
		}
	}

	$(function name() {  // 실행시 자동으로 실행
		$('#uploadBtn').on('click', function() { 
	
		});

	});
	
	window.onload = function() {
		rsCheck();
	}

</script>
</head>
<body>

	<div class="container text-center">
		<div class="row justify-content-md">
			<div class="col col-lg-2"></div>
			<div class="card mb-4 border-light justify-content">
				<div class="card-header ">
					<h3>사진 업로드 하기</h3>	
				</div>
				<div class="card-body" data-wow-delay=".5s">
					<form method="post" enctype="multipart/form-data" name="form" id="form" action="../khBoard/uploadProcess.do" onsubmit="return check(this)">
						<div class="rounded contact-form">
							<div class="mb-4">
								<input type="text" class="form-control p-3" placeholder="제목" id="title" name="title"><br>
								<textarea class="w-100 form-control p-3" rows="6" cols="10" placeholder="내용" id="context"  name="context"></textarea>
							</div>
							<div class="relative top-0 start-0" style="float:left;">
								첨부파일 : <input class="btn" type="file" name="attechedFile"/>
							</div>
							<div class="mb-4" align="center" style="float:right;">
								<input class="btn btn-secondary btn-sm" type="submit" value="작성 완료"/> 
								<button class="btn btn-secondary btn-sm" type="reset">다시 입력</button> 
								<button class="btn btn-secondary btn-sm" type="button" onclick="location.href = 'imageList.do';">목록 보기</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
</body>
</html>