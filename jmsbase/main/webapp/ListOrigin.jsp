<%@page import="miniproject.BoardPage"%>
<%@page import="miniproject.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="miniproject.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	BoardPage bp=new BoardPage();
	BoardDAO dao = new BoardDAO();
	Map<String, Object> param = new HashMap<String, Object>();
	String serchField = request.getParameter("serchField");
	String serchWord = request.getParameter("serchWord");
	if(serchWord!=null){
		param.put("serchField", serchField);
		param.put("serchWord", serchWord);
	}
	int totalCount = dao.selectCount(param);
	int pageSize=Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
	int blockPage=Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
	int totalPage=(int)Math.ceil((double)totalCount/pageSize);
	
	int pageNum=1;
	String pageTemp=request.getParameter("pageNum");
	if(pageTemp!=null && !pageTemp.equals("")){
		pageNum=Integer.parseInt(pageTemp);
	}
	int start = (pageNum -1)*pageSize +1;
	int end=pageNum*pageSize;
	param.put("start",start);
	param.put("end",end);
	List<BoardDTO> boardLists = dao.selectListPage(param);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
</head>
<body>
<%@include file="topmenu.jsp" %>
 <h2>목록 보기(List) - 현재 페이지 : <%=pageNum %> (전체 : <%=totalPage %>)</h2>
 <form method="get">
 <table border="1" width ="90%">
 <tr>
 <td align="center">
	<select name="serchField">
		<option value="title">제목</option>
		<option value="content">내용</option>
	</select> 
	<input type="text" name="serchWord">
	<input type="submit" value="검색하기">
 </td>
 </tr> 
 </table>
 </form>
 <table border="1" width="90%">
 	<tr>
 		<th width="10%">번호</th>
 		<th width="50%">제목</th>
 		<th width="15%">작성자</th>
 		<th width="10%">조회수</th>
 		<th width="15%">작성일</th>
 	</tr>
 <%
 	if(boardLists.isEmpty()){
 %>
 	<tr>
 		<td colspan="5" align="center">
 			등록된 게시물이 없습니다.
 		</td>
 	</tr>
 <%}else{ 
 	int virtualNum=0;
 	int countNum =0;
 	for(BoardDTO dto : boardLists){
 		virtualNum = totalCount-(((pageNum-1)*pageSize)+countNum++);
 	
 %>
 	<tr align="center">
 		<td><%=virtualNum %></td>
 		<td align="left">
 			<a href="View.jsp?num=<%=dto.getNum()%>"><%=dto.getTitle() %></a>
 		</td>
 		<td align="center"><%=dto.getId() %></td>
 		<td align="center"><%=dto.getVisitcount() %></td>
 		<td align="center"><%=dto.getPostdate() %></td>
 	</tr>
 <%
 	}
 }
 %>
 </table>
 <table>
 	<tr align="center">
 		<td>
 		<%=bp.PagingStr(totalCount, pageSize, blockPage, pageNum, request.getRequestURI())%>
 		</td>
 		<td>
 			<button type="button" onclick="location.href='Write.jsp'">글쓰기</button>
 		</td>
 	</tr>
 </table>
</body>
</html>