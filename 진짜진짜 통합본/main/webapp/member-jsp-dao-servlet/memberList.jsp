<%@page import="member.dao.MemberDAO"%>
<%@page import="member.dto.MemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	MemberDAO dao = new MemberDAO();
	List<MemberDTO> list = dao.getMemberList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberList.jsp</title>
</head>
<body>
<%@include file="submenu.jsp" %>
<h2>회원목록</h2>
<hr>
<table border="1">
<tr>
	<th>Idx</th>
	<th>ID</th>
	<th>PW</th>
	<th>Name</th>
	<th>Role</th>
	<th>Regdate</th>
</tr>

<% for (MemberDTO dto : list) { %>
	<tr style="text-align: center;">
		<td><%=dto.getIdx() %></td>
		<td><%=dto.getId() %></td>
		<td><%=dto.getPw() %></td>
		<td><%=dto.getName() %></td>
		<td><%=dto.getRole() %></td>
		<td><%=dto.getRegdate() %></td>
	</tr>
<% } %>

</table>
</body>
</html>