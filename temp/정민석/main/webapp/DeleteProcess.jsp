<%@page import="member.BoardDAO"%>
<%@page import="member.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="IsLoggedln.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String sNum=request.getParameter("num");
	int num=Integer.parseInt(sNum);
	BoardDTO dto=new BoardDTO();
	
	BoardDAO dao =new BoardDAO();
	dto=dao.selectView(sNum);
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