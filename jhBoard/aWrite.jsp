<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>aWrite.jsp</title>
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
		border: 20px
	}
	
	.head {
		font-weight: bold;
	}
	
	table {
		margin : auto;
   		width : 80%;
   		background-color: white;
	}
	
</style>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<%@ include file="../home/topmenu.jsp" %>
<script>
function validateForm(form){
	if(form.name.value == "") {
		alert("작성자를 입력하세요");
		form.name.focus();
		return false;		
	}
	
	if(form.title.value == "") {
		alert("제목을 입력하세요");
		form.title.focus();
		return false;
	}
	if(form.content.value == ""){
		alert("제목을 입력하세요");
		form.co.focus();
		return false;
	}
	
}

function writeUpload() {
	num = location.search.split('=')[1];	
	const params = {title: $('#title').val(), context: $('#context').val(), num:num};
		console.log(params);
		$.ajax({
	        type: 'POST',
	        url: '../jhBoard/AInsertWrite.json',
	        data: params,
	        dataType: 'json',
	        success: function(data) {
	        	if(data['rs'] == 1) {
	        		alert("업로드 완료 되었습니다");
	        		location.href = '../jhBoard/qnaBoardList.do';
	        	}
	        	else {
	        		alert("업로드 실패하였습니다")
	        	}
	        },
	        error: function(xhr, status, error) {
	            console.log(xhr, status, error);
	        }
	    });
	}

$(function() {
	$('#resetBtn').click(function() {
		$('#name').val('');
		$('#title').val('');
		$('#content').val('');
	});
	
	$('#submitBtn').click(function() {
		writeUpload();
	});
});


</script>
</head>
<h5>&nbsp; Q&A 게시판 - 답변하기</h5>
<form onsubmit="return validateForm(this);">
<table border="1" width="90%">
	<tr>
		<td class="head" align ="center">작성자</td>
		<td>
			<input type ="text" name="name" id="name" style="width:90%;" value="${nickname}" readonly/>
		</td>
	</tr>
	<tr>
		<td class="head" align ="center">제목</td>
		<td>
			<input type ="text" name="title" id="title" style="width:90%;"/>
		</td>
	</tr>
	<tr>
		<td class="head" align ="center">내용</td>
		<td>
			<textarea name="context" id="context" style="width:90%; height:100px;"></textarea>
		</td>
	</tr>
	<tr>
		<td class="head" align ="center">첨부 파일</td>
		<td>
			<input type="file" name="ofile">
		</td>
	<tr> 
		<td colspan="2" align="center">
		<input type="button" id="submitBtn" value = "작성 완료" class="border">
		<button type ="reset" id="resetBtn" class="border" >다시 작성하기</button>
		<button type ="button" onclick="location.href='qnaBoardList.jsp';" class="border">
			목록 바로가기
		</button>
	</tr>
</table>
</form>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
</body>
</html>