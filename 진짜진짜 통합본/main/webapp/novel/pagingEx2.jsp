<%@page import="novel.PagingDTO"%>
<%@page import="novel.PagingDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
int totalCount = 200;
int pageNum = 1;
int listNum = 5;
int blockNum = 5;
PagingDTO paging = new PagingDTO(totalCount, pageNum, listNum, blockNum);
paging.setPaging();

int totalPage = paging.getTotalPage();
int startPage = paging.getStartPage();
int endPage = paging.getEndPage();
boolean isPrev = paging.isPrev();
boolean isNext = paging.isNext();
boolean isBPrev = paging.isBPrev();
boolean isBNext = paging.isBNext();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberList.jsp</title>
</head>
<body>
<%@include file="../home/topmenu.jsp" %>
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