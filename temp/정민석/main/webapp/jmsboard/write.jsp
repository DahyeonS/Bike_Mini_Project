<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="stylesheet" type="text/css" href="../css/write.css">
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
		$('#resetBtn').click(function() {
			$('#wTitle').val('');
			$('#wContext').val('');
		});
	});
	$(function() {
		$('#listBtn').click(function() {
			const wCheck = confirm("게시글 작성 안하실건가요?");
			if(!(wCheck == false)) {
				location.href = 'board.jsp';				
			}
		});
	});
</script>
<title>write</title>

</head>
<%@include file="../home/topmenu.jsp" %>
<body>
	 <div class="wrap">
        <h1>회원제 게시판 - 글쓰기</h1>
        <!-- jmsboard패키지에 jmscontroller쪽으로 가게됩니다 -->
        <form name="writeFrm" method="post" enctype="multipart/form-data"
        action="upload.do">
            <div class="main">
                <table border="1">
                    <tbody>
        				<tr>
               <td class="w_name">제목</td>
               <td><input type="text" name="wTitle"></td>
            </tr>
            <tr>
               <td class="w_name">내용</td>
               <td><input type="text" name="wContext" ></td>
            </tr>
            <tr><td colspan="2" class="upload"><input type="file" value="파일 업로드" name="fileUp"></td></tr>
            <tr>
               <td colspan="2" class="w_btn">
                               <input type="hidden" name="category" value="일반">
                               <input type="submit" value="작성 완료" id="writeBtn">
                               <input type="button" value="다시 입력" id="resetBtn">
                               <input type="button" value="목록 보기" id="listBtn">
               </td>
            </tr>
            <tr>
            	<td> <input type="button" value="&lt;" id="prevBtn"></td>
               	<td><input type="button" value="&gt;" id="nextBtn"></td>
           </tr>                
                    </tbody>
                </table>
            </div>
        </form>
        
    </div>
</body>
</html>