<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
 <link rel="stylesheet" type="text/css" href="./css/write.css">
  <script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>

 <script>
	function validateForm(form){
		if(form.wTitle.value==""){
			alert("제목을 입력하세요")
			form.wTitle.focus();
			return false;
		}
		if(form.wContext.value==""){
			alert("내용을 입력하세요")
			form.wContext.focus();
			return false;
		}
		
	}

	
	$(function() {
		$('#listBtn').click(function() {
			const wCheck = confirm("게시글 수정 안하실건가요?");
			if(!(wCheck == false)) {
				location.href = 'View.do?num='+${dto.num}+'&index='+${index };				
			}
		});
	});

</script>

</head>
<body>
<%@include file="../home/topmenu.jsp" %>
	 <div class="wrap">
        <h1>회원제 게시판 - 수정하기</h1>
        <form name="writeFrm" method="post" action="EditProcess.do"  enctype="multipart/form-data"
        onsubmit="return validateForm(this);">
        <input type="hidden" name="num" value="${dto.num }">
        <input type="hidden" name="index" value="${index }">
        <input type="hidden" name="prevSfile" value="${dto.fileName }">
            <div class="main">
               <table border="1">
                <tbody>
        		<tr>
              	 	<td class="w_name">제목</td>
              	 	<td><input type="text" name="wTitle" id="wTitle" value="${dto.title }"></td>
            	</tr>
           		<tr>
              	 	<td class="w_name">내용</td>
              	 	<td><input type="text" name="wContext" id="wContext" value="${dto.context }"></td>
            	</tr>
            	<tr>
            		<td colspan="2">
            			<input type=file name="fileUp" value="파일 업로드">
            		</td>
            	</tr>
            <tr>
               <td colspan="2" class="w_btn">
                               <input type="submit" value="작성 완료" id="writeBtn">
                               <input type="reset" value="다시 입력" >
                               <input type="button" value="취소" id="listBtn">
               </td>
            </tr>
               
                    </tbody>
                </table>
            </div>
        </form>
        
    </div>
</body>
</html>