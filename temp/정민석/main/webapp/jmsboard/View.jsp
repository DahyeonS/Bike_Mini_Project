<%@page import="java.net.URLEncoder"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAOimpl"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String num=request.getParameter("num");

	BoardDAO dao=new BoardDAOimpl();
	dao.updateVisitCount(num);
	BoardDTO dto=dao.selectView(num);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
<script>
function deleteProcess() {
	const num=<%=num%>
	$.ajax({
        type: 'POST',
        url: 'DeleteProcess.do',
        dataType: 'json',
        data: {num:num},
        success: function(data) {
        	if(data['idCorrect']===0){
        		alert("본인만 삭제할 수 있습니다.");
        		location.href="board.jsp";
        	}else if(data['delResult']===0){
        		alert("삭제에 실패했습니다");
        		location.href="board.jsp";
        	}else{
        		alert("삭제되었습니다");
        		location.href="board.jsp";
        	}
        }, error: function(xhr, status, error) {
        	console.log(xhr, status, error);
        }
	});
};
function deletePost(){
	const confirmed=confirm("정말로 삭제하겠습니까?");
	if(confirmed){
		deleteProcess();
	}
}

</script>
</head>
<body>

<%@include file="../home/topmenu.jsp" %>
<h2>회원제 게시판 - 상세 보기</h2>
<form name="writeFrm">
	<input type="hidden" name="num" value="<%=num %>">
	<table border="1" width="90%">
		<tr>
			<td>번호</td>
			<td><%=dto.getNum() %></td>
			<td>작성자</td>
			<td><%=dto.getNickname()%></td>
		</tr>
		<tr>
			<td>작성일</td>
			<td><%=dto.getPostdate() %></td>
			<td>조회수</td>
			<td><%=dto.getVisitCount() %></td>
		</tr>
		<tr>
			<td>제목</td>
			<td colspan="3"><%=dto.getTitle() %></td>
		</tr>
		<tr>
			<td>내용</td>
			<td colspan="3" height="100">
			<%=dto.getContext().replace("\r\n", "<br/>") %>
			</td>
		</tr>
		<tr>
			<%
			if(dto.getFileName()!=null){ 
			%>
			<td>파일</td>
			<td colspan="2"><%=dto.getFileName() %></td>
			<td><a href="download.jsp?sName=<%=URLEncoder.encode(dto.getFileName(), "UTF-8") %>">[다운로드]</a></td>
			<%} %>
		</tr>
		<tr>
				<%
					if(session.getAttribute("id")!=null){
				%>
			<td colspan="4" align="center">
					<button type="button" onclick="location.href='Edit.jsp?num=<%=dto.getNum()%>';">
						수정하기
					</button>
					<button type="button" onclick="deletePost();">
						삭제하기
					</button>
					<button type="button" onclick="location.href='board.do';">
						목록보기
					</button>
			</td>
					<%}else{%>
					<td colspan="4" align="center"><button type="button" onclick="location.href='board.do';">
						목록보기
					</button></td>
					<%} %>
		</tr>
		            <tr>
		        
            <td> <input type="button" value="&lt;" id="prevBtn"></td>
               	<td><input type="button" value="&gt;" id="nextBtn"></td>
           </tr	> 
	</table>
</form>
</body>
</html>