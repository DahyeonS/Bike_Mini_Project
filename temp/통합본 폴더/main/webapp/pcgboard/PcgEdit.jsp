<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./css/style.css">

<script>
	function validateForm(form) {
		if (form.uptitle.value == "") {
			alert("제목을 입력하세요")
			form.uptitle.focus();
			return false;
		}
		if (form.upcontext.value == "") {
			alert("내용을 입력하세요")
			form.upcontext.focus();
			return false;
		}

	}

	$(function() {
		$('#listBtn').click(function() {
			const wCheck = confirm("게시글 수정 안하실건가요?");
			if (!(wCheck == false)) {
				location.href = 'View.do?num=' + ${dto.num};
			}
		});
	});
</script>

</head>
<body>
	<%@include file="../home/topmenu.jsp"%>
	<div class="wrap">
		<h1>회원제 게시판 - 수정하기</h1>
		<form name="writeFrm" method="post" action="Pcgupdate.do"
			 onsubmit="return validateForm(this);">
			<input type="hidden" name="num" id="num" value="${dto.num }"> 
			<div class="main">
				<table border="1" class="container">
					<tbody>
						<tr>
							<td>제목</td>	<td><input type="text"  name="uptitle" id="uptitle" value="${dto.title }"></td>
						</tr>
						<tr>
							<td>내용</td>
							<td><div class="form-floating">
			  					<textarea  name="upcontext" id="upcontext" class="form-control" placeholder="Leave a comment here" id="floatingTextarea"> ${dto.context }</textarea>
  			  					<label for="floatingTextarea">Comments</label>
								</div>
						</tr>

						<tr>
							<td colspan="2" class="w_btn">
							<button type="submit" value="작성 완료" id="writeBtn" class="btn btn-outline-secondary btn-3">작성 완료</button>
								 <button type="reset"value="다시 입력" class="btn btn-outline-secondary btn-3">다시 입력</button>
								  <button value="취소"id="listBtn" class="btn btn-outline-secondary btn-3"> 취소</button> </td>
						</tr>

					</tbody>
				</table>
			</div>
		</form>

	</div>
	<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
			crossorigin="anonymous"></script>
		<script
			src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
			integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
			crossorigin="anonymous"></script>
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js"
			integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa"
			crossorigin="anonymous"></script>
</body>
</html>