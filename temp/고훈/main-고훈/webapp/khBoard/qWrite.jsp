<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../home/topmenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>aWrite.jsp</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
<script src="./script/sendAjax.js"></script>
<script>

	function insertWrite () {
    	const params = {title: $('#title').val(), context: $('#context').val()};
    	
    	sendAjax('qInsertWrite.json', params).then( (data) => {
    		if(data['rs'] == 1) {
	        		alert('글 작성이 완료 되었습니다');
	        		location.href = '../khBoard/qnaList.do';
	        }
 		})
 	}

	$(function name() {  // 실행시 자동으로 실행
		$('#writeBtn').on('click', function() {
			insertWrite();
		});

	});
</script>
</head>
<body>
<h2> 질문 게시판 - 글쓰기</h2>
<form name="writeForm">
	<table border="1" width="60%">
	<tr>
		<td align="center" width="50px">제목</td>
		<td><input type="text" name="title" id="title" style="width:100%" /></td>
	</tr>
	<tr>
		<td align="center">내용</td>
		<td><textarea name="context" id="context"style="width:100%; height: 300px;"></textarea></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="button" value="작성 완료" id="writeBtn"/>
			<button type="reset">다시 입력</button>
			<button type="button" onclick="location.href = 'qnaList.do';">목록 보기</button>
		</td>
	</tr>
	</table>

</form>
</body>
</html>