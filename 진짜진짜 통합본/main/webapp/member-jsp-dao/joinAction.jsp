<%@page import="member.dao.MemberDAO"%>
<%@page import="member.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String role = request.getParameter("role");
	MemberDTO dto = new MemberDTO(id, pw, name, role);
%>
<%	
	MemberDAO dao = new MemberDAO();
	int rs = dao.insert(dto);
%>
<script>
<% if (rs == 1) { %>
	alert('회원가입을 축하드립니다!');
	location.href = 'main.jsp';
<% } else { %>
	alert('죄송합니다. 잠시 후에 다시 해주세요.');
	history.back();
<% } %>
</script>