<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="stylesheet" type="text/css" href="../css/write.css">
 <script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
 <script>
 function writeBoard() {
	 <%String num_de = request.getParameter("num");
		int numD = Integer.parseInt(num_de);
		%>
		console.log("num : " + num);
		const num = "<%=numD%>";
		const title = $('#wTitle').val();
		const context = $('#wContext').val();
		const param = {title:title, context:context, num:num};
		                                                                                                                                                                                                                                                                                                                                                    
		$.ajax({
			contentType: 'application/json',
	        type: 'POST',
	        url: 'updateJson.json',
	        dataType: 'json',
	        data: param,
	        success: function(data) {
	        	console.log("data : "+ data);
	        	console.log("param : "+ param);
	        	
	        	if (data['rs'] === 1) {
	        		alert('게시글이 수정되었습니다');
	        		location.href = 'board.do';
	        	}
				else alert('죄송합니다 잠시 후에 다시 시도해주세요 ㅠ');
	        }, error: function(xhr, status, error) {
	        	console.log(xhr, status, error);
	        }
		});
	};
	function prevWrite() {
			<%String numCh = request.getParameter("num2");
				int n = Integer.parseInt(numCh);
				%>
				const num2 = "<%=numCh%>";
			                                                                                                                                                                                                                                                                                                                                                    
			$.ajax({
				contentType: 'application/json',
		        type: 'POST',
		        url: 'prevWrite.json',
		        dataType: 'json',
		        data: {num:num2},
		        success: function(data) {
		        	console.log("num2 : "+ num2);
		        	
		        	if (data['rs'] === 1) {
		        		alert('헤헤헿');
		        		console.log("data : " + JSON.stringify(data));
			        	 
	        			$('#wTitle').html(data['title']);
	        			$('#wContext').html(data['context']);
		        	}
					else alert('삐바 좀 있다 다시혀');
		        }, error: function(xhr, status, error) {
		        	console.log(xhr, status, error);
		        }
			});
		};
	
	$(function() {
		prevWrite();
		$('#writeBtn').click(function() {
			writeBoard();
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
                        <tr>
                            <td colspan="2" class="w_btn">
                                <input type="hidden" name="category" value="소설" id="cateHidden">
                                <input type="button" value="작성 완료" id="writeBtn">
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