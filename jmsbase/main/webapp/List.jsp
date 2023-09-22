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
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<script>
function serch(serchWord,serchField) {
    $.ajax({
        type: 'POST',
        url: 'serch.json',
        data:{serchWord:serchWord,serchField:serchField},
        dataType: 'json',
        success: function(data) {
        	console.log(data);
        	let boardLists=data['boardLists'];
        	let pageNum=data['pageNum'];
        	let pageSize=data['pageSize'];
        	let totalCount=data['totalCount'];
        	let totalPage=data['totalPage'];
        	let td="목록 보기(List) - 현재 페이지 : "+pageNum+" (전체 : "+totalPage+")";
        	$('#h2').html(td);
        	let tr="";
        	if(boardLists.length===0){
        		tr+="<td colspan=\"5\" align=\"center\">등록된 게시물이 없습니다.</td>";
        	}else{
        		console.log(boardLists);
        		let virtualNum=0;
        	 	let countNum =0;
        	 	$.each(boardLists,function(index,dto){
        	 		virtualNum = totalCount-(((pageNum-1)*pageSize)+countNum++);
        	 		tr+="<tr><td>"+virtualNum +"</td><td align=\"left\">";
        	 		tr+="<a href=\"View.jsp?num="+dto['num']+"\">"+dto['title']+"</a>";
        	 		tr+="</td><td align=\"center\">"+dto['id']+ "</td>";
        	 		tr+="</td><td align=\"center\">"+dto['visitcount']+ "</td>";
        	 		tr+="</td><td align=\"center\">"+dto['postdate']+ "</td></tr>";
        	 	})
        	 		
         	}
	       $('#boardLists').html(tr);
		},
        	error: function(xhr, status, error) {
            	console.log(xhr, status, error);
      	 }
    });
};

$(document).ready(function() {
	serch();
	$('#serch').on("click",function() {		
	const serchWord=$('#serchWord').val();
	const serchField =$('#serchField').val();
	serch(serchWord,serchField);
	});
});
</script>
</head>
<body>
<%@include file="topmenu.jsp" %>
 <h2 id="h2"></h2>
 <form>
 <table border="1" width ="90%">
 <tr>
 <td align="center">
	<select id="serchField">
		<option value="title">제목</option>
		<option value="content">내용</option>
	</select> 
	<input type="text"  id="serchWord">
	<input type="button" value="검색하기" id="serch">
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
	<tbody id="boardLists" align="center"></tbody>
 	

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