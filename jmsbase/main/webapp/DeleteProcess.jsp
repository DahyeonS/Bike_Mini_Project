<%@page import="miniproject.BoardDAO"%>
<%@page import="miniproject.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="IsLoggedln.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String num=request.getParameter("num");
	
	BoardDTO dto=new BoardDTO();
	
	BoardDAO dao =new BoardDAO();
	dto=dao.selectView(num);
	String sessionId=session.getAttribute("id").toString();
	int delResult=0;
	if(sessionId.equals(dto.getId())){
		dto.setNum(num);
		delResult=dao.deletePost(dto);
		if(delResult==1){
%>		
		<script>
		alert("삭제되었습니다");
		location.href="List.jsp";
		</script>
	<%	}else{%>
		<script>
		alert("삭제에 실패했습니다");
		location.href="View.jsp";
		</script>
	<%} %>
<%}else{%>
	<script>
		alert("본인만 삭제할 수 있습니다.");
		location.href="View.jsp";
	</script>
<%}%>