<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
<link rel="stylesheet" type="text/css" href="../css/write.css">
<script type="text/javascript"
	src="http://code.jquery.com/jquery-3.5.1.min.js"></script>

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
				<table border="1">
					<tbody>
						<tr>
							<td class="up_name">제목</td>
							<td><input type="text"  name="uptitle" id="uptitle" value="${dto.title }"></td>
						</tr>
						<tr>
							<td class="up_name">내용</td>
							<td><textarea name="upcontext" id="upcontext" > ${dto.context }</textarea></td>
						</tr>

						<tr>
							<td colspan="2" class="w_btn">
							<input type="submit" value="작성 완료" id="writeBtn">
								 <input type="reset"value="다시 입력">
								  <input type="button" value="취소"id="listBtn"></td>
						</tr>

					</tbody>
				</table>
			</div>
		</form>

	</div>
</body>
</html>