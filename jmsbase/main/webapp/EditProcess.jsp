<%@page import="miniproject.BoardDAO"%>
<%@page import="miniproject.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="IsLoggedln.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String num=request.getParameter("num");
	String title=request.getParameter("title");
	String content = request.getParameter("content");
	
	BoardDTO dto=new BoardDTO();
	dto.setNum(num);
	dto.setTitle(title);
	dto.setContent(content);
	
	BoardDAO dao =new BoardDAO();
	int affected=dao.updateEdit(dto);
	
	if(affected==1){
		response.sendRedirect("View.jsp?num="+dto.getNum());
	}else{%>
	<script>
		alert("수정하기에 실패하였습니다.");
		location.href="Edit.jsp";
	</script>
<%}%>