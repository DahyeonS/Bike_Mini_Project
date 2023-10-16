<%@page import="member.dto.PagingDTO"%>
<%@page import="member.dto.MemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	List<MemberDTO> list = (List<MemberDTO>)request.getAttribute("list");
	int totalCount = list.size();
	//paging
	PagingDTO paging = (PagingDTO)request.getAttribute("paging");
	int pageNum = paging.getPageNum();  
	int totalPage = paging.getTotalPage();
	int startPage = paging.getStartPage();
	int endPage = paging.getEndPage();
	boolean isPrev = paging.getIsPrev();
	boolean isNext = paging.getIsNext();
	boolean isBPrev = paging.getIsBPrev();
	boolean isBNext = paging.getIsBNext();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberList.jsp</title>
</head>
<body>
<%@include file="submenu.jsp" %>
<h2>회원목록 : <%=pageNum %>/<%=totalPage %> (<%=totalCount %>)</h2>
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
	<tr>
		<td><%=dto.getIdx() %></td>
		<td><%=dto.getId() %></td>
		<td><%=dto.getPw() %></td>
		<td><%=dto.getName() %></td>
		<td><%=dto.getRole() %></td>
		<td><%=dto.getRegdate() %></td>
	</tr>
<% } %>
<tr>
<td colspan="6">
<%
String url = "memberPagingList.do?page=";
%>
<%if(isBPrev){ %> <a href=<%=url%><%=startPage-1%>>[<<]</a> <%} %>
<%if(isPrev){ %> <a href=<%=url%><%=pageNum-1%>>[<]</a> <%} %>

<%for(int i=startPage; i<=endPage; i++) {%>
	<%if(i == pageNum) {%>
		<span style="color:red;">[<%=i %>]</span>
	<%}else{%>
		<a href=<%=url%><%=i%>>[<%=i %>]</a>
	<%} %>
<%}%>

<%if(isNext){ %> <a href=<%=url%><%=pageNum+1%>>[>]</a> <%} %>
<%if(isBNext){ %> <a href=<%=url%><%=endPage+1%>>[>>]</a> 
<%} %>
</td>
</tr>
</table>
</body>
</html>