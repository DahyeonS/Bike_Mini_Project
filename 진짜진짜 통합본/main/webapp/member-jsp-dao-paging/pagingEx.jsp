<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
// paging 계산
int totalCount = 158;
int listNum = 10;
int blockNum = 10;

int startPage = 0;
int endPage = 0;
boolean isPrev = false;
boolean isNext = false;
boolean isBPrev = false;
boolean isBNext = false;

int pageNum = 1;
if(request.getParameter("page") != null){
	pageNum = Integer.parseInt(request.getParameter("page")); 
}
		
// 전체 페이지
int totalPage = (totalCount-1) / listNum + 1;
//totalPage = (int)Math.ceil(((totalCount*0.1)/listNum)*10);

// 시작, 끝 페이지 
// 1 ~ 10 => 1, 11 ~ 20 => 11, 21 ~ 30 => 21
startPage = ((pageNum-1) / blockNum) * blockNum + 1;
endPage = startPage + blockNum -1;
if(endPage > totalPage) endPage = totalPage;

// isBPrev, isBNext
isBPrev = startPage > 1;
isBNext = totalPage > endPage; 

//isPrev, isNext
isPrev = pageNum > 1;
isNext = pageNum < totalPage; 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberList.jsp</title>
</head>
<body>
<%@include file="submenu.jsp" %>
<h2>페이징</h2>
<hr>
<h2>
totalCount : <%=totalCount %><br>
totalPage : <%=totalPage %><br>
pageNum : <%=pageNum %><br>
startPage : <%=startPage %><br>
endPage : <%=endPage %><br>
isBPrev : <%=isPrev %><br>
isBNext : <%=isNext %><br>
isPrev : <%=isPrev %><br>
isNext : <%=isNext %><br>
</h2>
<h1>
<table border="1">
<tr>
<%if(isBPrev){ %>
<td><a href="pagingEx.jsp?page=<%=startPage-1%>">[<<]</a> </td>
<%} %>
<%if(isPrev){ %>
<td><a href="pagingEx.jsp?page=<%=pageNum-1%>">[<]</a> </td>
<%} %>
<td>
<%for(int i=startPage; i<=endPage; i++) {%>
	<%if(i == pageNum) {%>
		<span style="color:red;">[<%=i %>]</span>
	<%}else{%>
		<a href="pagingEx.jsp?page=<%=i%>">[<%=i %>]</a>
	<%} %>
<%}%>
</td>
<%if(isNext){ %>
<td><a href="pagingEx.jsp?page=<%=pageNum+1%>">[>]</a> </td>
<%} %>
<%if(isBNext){ %>
<td><a href="pagingEx.jsp?page=<%=endPage+1%>">[>>]</a> </td>
<%} %>
</tr>
</table>
</h1>
</body>
</html>