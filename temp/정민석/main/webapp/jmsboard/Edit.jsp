<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDAOimpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
 <link rel="stylesheet" type="text/css" href="../css/write.css">
  <script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<%
	String num=request.getParameter("num");
	BoardDAO dao=new BoardDAOimpl();
	BoardDTO dto=dao.selectView(num);
	String sessionId = (String)session.getAttribute("id");
	if(!sessionId.equals(dto.getId())){
%>
<script>
	alert("작성자 본인만 수정할 수 있습니다");
	location.href="board.jsp";
</script>
<%}%>
 <script>
 function EditProcess(title,context) {
		const num=<%=num%>
		console.log(title);
		$.ajax({
	        type: 'POST',
	        url: 'EditProcess.do',
	        dataType: 'json',
	        data: {num:num,title:title,context:context},
	        success: function(data) {
	        	console.log(data['rs']);
	        	if(data['rs']===1){
	        		alert("수정 완료하였습니다");
	        		location.href="View.jsp?num="+num;
	        	}else{
	        		alert("수정 실패하였습니다");
	        		location.href="Edit.jsp?num="+num;
	        	}
	        }, error: function(xhr, status, error) {
	        	console.log(xhr, status, error);
	        }
		});
	};
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
			const wCheck = confirm("게시글 수정 안하실건가요?");
			if(!(wCheck == false)) {
				location.href = 'board.jsp';				
			}
		});
	});
	$(function() {
		$('#writeBtn').click(function() {
			const title=$('#wTitle').val();
			const context=$('#wContext').val();
			EditProcess(title,context);
		});
	});
</script>

</head>
<body>
	 <div class="wrap">
        <h1>회원제 게시판 - 수정하기</h1>
        <form name="writeFrm" >
            <div class="main">
               <table border="1">
                <tbody>
        		<tr>
              	 <td class="w_name">제목</td>
              	 <td><input type="text" name="wTitle" id="wTitle" value="<%=dto.getTitle()%>"></td>
            	</tr>
           		<tr>
              	 <td class="w_name">내용</td>
              	 <td><input type="text" name="wContext" id="wContext" value="<%=dto.getContext()%>"></td>
            	</tr>
            <tr>
               <td colspan="2" class="w_btn">
                               <input type="hidden" name="category" value="일반">
                               <input type="button" value="작성 완료" id="writeBtn">
                               <input type="button" value="다시 입력" id="resetBtn">
                               <input type="button" value="목록 보기" id="listBtn">
               </td>
            </tr>
               
                    </tbody>
                </table>
            </div>
        </form>
        
    </div>
</body>
</html>