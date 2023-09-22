<%@page import="miniproject.BoardDTO"%>
<%@page import="miniproject.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String num=request.getParameter("num");

	BoardDAO dao=new BoardDAO();
	dao.updateVisitCount(num);
	BoardDTO dto=dao.selectView(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
<script>
function deletePost(){
	const confirmed=confirm("정말로 삭제하겠습니까?");
	if(confirmed){
		const form=document.writeFrm;
		form.method="post";
		form.action="DeleteProcess.jsp";
		form.submit();
	}
}
</script>
</head>
<body>
<%@include file="topmenu.jsp" %>
<h2>회원제 게시판 - 상세 보기</h2>
<form name="writeFrm">
	<input type="hidden" name="num" value="<%=num %>">
	<table border="1" width="90%">
		<tr>
			<td>번호</td>
			<td><%=dto.getNum() %></td>
			<td>작성자</td>
			<td><%=dto.getName() %></td>
		</tr>
		<tr>
			<td>작성일</td>
			<td><%=dto.getPostdate() %></td>
			<td>조회수</td>
			<td><%=dto.getVisitcount() %></td>
		</tr>
		<tr>
			<td>제목</td>
			<td colspan="3"><%=dto.getTitle() %></td>
		</tr>
		<tr>
			<td>내용</td>
			<td colspan="3" height="100">
			<%=dto.getContent().replace("\r\n", "<br/>") %>
			</td>
		</tr>
		<tr>
				<%
					if(session.getAttribute("id")!=null && session.getAttribute("id").toString().equals(dto.getId())){
				%>
			<td colspan="4" align="center">
					<button type="button" onclick="location.href='Edit.jsp?num=<%=dto.getNum()%>';">
						수정하기
					</button>
					<button type="button" onclick="deletePost();">
						삭제하기
					</button>
					<button type="button" onclick="location.href='List.jsp';">
						목록보기
					</button>
			</td>
					<%}%>
		</tr>
	</table>
</form>
</body>
</html>