<%@page import="java.net.URLEncoder"%>
<%@page import="member.dto.MyfileDTO"%>
<%@page import="member.dao.MemberDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	MemberDAO dao = new MemberDAO();
	List<MyfileDTO> list = dao.getFileList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fileList.jsp</title>
</head>
<body>
<%@include file="submenu.jsp" %>
<h2>파일목록</h2>
<hr>
Eclipse로 개발 시 image 임시 경로 <br> 
E:\kdigital2307\jsp\jspws\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\javaweb\file-uploads
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

<% for (MyfileDTO dto : list) { %>
	<tr>
            <td><%= dto.getIdx() %></td>
            <td><%= dto.getName() %></td>
            <td><%= dto.getTitle() %></td>
            <td><%= dto.getCate() %></td>
            <td><%= dto.getOfile() %></td>
            <td><%= dto.getSfile() %></td>
            <td><%= dto.getPostdate() %></td>
            <td><a href="fileDownload.jsp?oName=<%= URLEncoder.encode(dto.getOfile(),"UTF-8") %>&sName=<%= URLEncoder.encode(dto.getSfile(),"UTF-8") %>">[다운로드]</a></td>
        </tr>
<% } %>

</table>
</body>
</html>