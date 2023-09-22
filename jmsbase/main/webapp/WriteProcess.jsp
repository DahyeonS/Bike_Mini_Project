<%@page import="miniproject.BoardDAO"%>
<%@page import="miniproject.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="IsLoggedln.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String title=request.getParameter("title");
	String content = request.getParameter("content");
	
	BoardDTO dto=new BoardDTO();
	dto.setTitle(title);
	dto.setContent(content);
	dto.setId(session.getAttribute("id").toString());
	
	BoardDAO dao =new BoardDAO();
	int iResult=dao.insertWrite(dto);

	if(iResult==1){
		response.sendRedirect("List.jsp");
	}else{%>
	<script>
		alert("글쓰기에 실패하였습니다.");
		location.href="Write.jsp";
	</script>
<%}%>