<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FileUpload</title>
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

</body>
</html>