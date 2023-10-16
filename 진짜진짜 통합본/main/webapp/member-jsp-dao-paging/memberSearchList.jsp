<%@page import="member.dto.PagingDTO"%>
<%@page import="member.dto.MemberDTO"%>
<%@page import="member.dao.MemberDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String searchSelect = "id";	
	String searchText = request.getParameter("searchText");	
	Map<String,String> search = new HashMap<>();
	if(searchText == null){
		searchText = "";				
	}else{
		searchSelect = request.getParameter("searchSelect");		
	}
	search.put("searchSelect", searchSelect);
	search.put("searchText", searchText);
	
	int listNum = 10;
	int blockNum = 10;
	int pageNum = 1;
	if(request.getParameter("page") != null){
		pageNum = Integer.parseInt(request.getParameter("page"));
	};	
	MemberDAO dao = new MemberDAO();
	List<MemberDTO> list = dao.getMemberListPaging(pageNum, listNum, search);
	int totalCount = dao.getMemberCount(search);
%>
<%	
	//paging
	PagingDTO paging = new PagingDTO(totalCount, pageNum, listNum, blockNum);
	paging.setPaging();	
	
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
searchSelect : <%=searchSelect %> / searchText : <%=searchText %>
<hr>
<form method="get">
<select name="searchSelect">
<option value="id" <%if(searchSelect.equals("id")) {%> selected <%} %>>id</option>
<option value="name" <%if(searchSelect.equals("name")) {%> selected <%} %>>name</option>
<option value="role" <%if(searchSelect.equals("role")) {%> selected <%} %>>role</option>
</select>
<input type="text" name="searchText" value="<%=searchText%>">
<input type="submit" value="Search">

</form>
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
String s = "";
if(searchText.length() != 0)
	s = "&searchSelect="+searchSelect+"&searchText="+searchText;
String url = "memberSearchList.jsp?page=";
%>
<%if(isBPrev){ %> <a href="<%=url%><%=startPage-1%><%=s %>>">[<<]</a> <%} %>
<%if(isPrev){ %> <a href="<%=url%><%=pageNum-1%><%=s %>">[<]</a> <%} %>

<%for(int i=startPage; i<=endPage; i++) {%>
	<%if(i == pageNum) {%>
		<span style="color:red;">[<%=i %>]</span>
	<%}else{%>
		<a href="<%=url%><%=i%><%=s %>">[<%=i %>]</a>
	<%} %>
<%}%>

<%if(isNext){ %> <a href="<%=url%><%=pageNum+1%><%=s %>">[>]</a> <%} %>
<%if(isBNext){ %> <a href="<%=url%><%=endPage+1%><%=s %>">[>>]</a> 
<%} %>
</td>
</tr>
</table>
</body>
</html>