<%@page import="member.dao.MemberDAO"%>
<%@page import="member.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = "";

	boolean isId = false;
	boolean isPw = false;
	
	MemberDTO dto = new MemberDTO();
	dto.setId(id);
	
	MemberDAO dao = new MemberDAO();
	dto = dao.getMember(dto);
	
	if (dto != null) {
		isId = true;
		if (dto.getPw().equals(pw)) {
			isPw = true;
			name = dto.getName();
		}
	}
%>
<% if (isId & isPw) { 
	session.setAttribute("id", id);
	session.setAttribute("name", name);
	response.sendRedirect("main.jsp");
} else { %>
<script>
	alert('ID나 PW를 다시 확인해주세요!!');
	history.go(-1);
</script>
<% } %>