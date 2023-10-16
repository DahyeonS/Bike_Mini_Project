<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FileUpload</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./css/style.css">
</head>
<script>
function validateForm(form){
	if(form.name.value ==""){
		alert('작성자를 입력하세요.');
		form.name.focus();
		return false;
	}
	if (form.title.value==""){
		alert('제목을 입력하세요.');
		form.title.focus();
		return false;
	}
	if (form.attachedFile.value ==""){
		alert('파일첨부는 필수입니다.');
		return false;
	}
}
</script>
<body>
<h3>파일 업로드</h3>
<span style="color: red;">${errorMessage}</span>
<form name="fileForm" method="post" enctype="multipart/form-data" action="UploadProcess.do" onsubmit="return validateForm(this);">
작성자 : <input type="text" name="name" value="반드시포함" /><br/>
제목 : <input type="text" name="title" /><br/>
카테고리(선택사항) :<br/> 
 <input type="checkbox" name="cate" value="사진" checked />사진<br/>
 <input type="checkbox" name="cate" value="ppt"  />ppt<br/>
 <input type="checkbox" name="cate" value="text"  />텍스트<br/>
 <input type="checkbox" name="cate" value="음원"  />음원<br/>
 첨부파일 : 
 <input type="file" name="attachedFile"/><br/>
 <input type="submit" value="전송하기"/>
 </form>
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