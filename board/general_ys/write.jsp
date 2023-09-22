<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="stylesheet" type="text/css" href="./css/write.css">
 <script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
 <script>
 function writeBoard() {
		const wTitle = $('#wTitle').val();
		const wContext = $('#wContext').val();
		const cateHidden = $('#cateHidden').val();
		const param = {wTitle:wTitle, wContext:wContext, cateHidden:cateHidden};
		console.log("param : " + param);
		$.ajax({
	        type: 'POST',
	        url: 'writeJson.json',
	        dataType: 'json',
	        data: param,
	        success: function(data) {
	        	if (data['rs'] === 1) {
	        		alert('게시글이 작성되었습니다');
	        		location.href = 'view.jsp';
	        	}
				else alert('죄송합니다 잠시 후에 다시 시도해주세요 ㅠ');
	        }, error: function(xhr, status, error) {
	        	console.log(xhr, status, error);
	        }
		});
	};
	
	$(function() {
		$('#writeBtn').click(function() {
			writeBoard();
		});
	});
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
<%@include file="loginmenu.jsp" %>
<body>
	 <div class="wrap">
        <h1>회원제 게시판 - 글쓰기</h1>
        <form action="view">
            <div class="main">
                <table border="1">
                    <tbody>
                        <tr>
                            <td class="w_name">제목</td>
                            <td><input type="text" name="wTitle" id="wTitle"></td>
                        </tr>
                        <tr>
                            <td class="w_name">내용</td>
                            <td><input type="text" name="wContext" id="wContext"></td>
                        </tr>
                        <tr><td colspan="2" class="upload"><input type="button" value="파일 업로드" id="fileUp"></td></tr>
                        <tr>
                            <td colspan="2" class="w_btn">
                                <input type="hidden" name="category" value="일반" id="cateHidden">
                                <input type="button" value="작성 완료" id="writeBtn">
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