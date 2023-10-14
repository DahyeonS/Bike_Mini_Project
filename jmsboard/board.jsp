<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="stylesheet" type="text/css" href="./css/board_css.css">
 <!-- <link rel="stylesheet" type="text/css" href="../css/reset.css"> -->
<title>board</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>

<script>
 function writeBtn() {
		$.ajax({
	        type: 'POST',
	        url: 'writeJson.json',
	        dataType: 'json',
	        success: function(data) {
	        	console.log(data);
	        	if (data['rs'] === 1) {
	        		location.href = 'write.do';
	        	}
				else {
					alert("게시글을 작성하려면 로그인을 먼저 하셔야됩니다");
					location.href = '../member/login.do'
				};
	        }, error: function(xhr, status, error) {
	        	console.log(xhr, status, error);
	        }
		});
	};

	$(function() {
		$('#b_writeBtn').click(function() {
			writeBtn();
		});
	});
	
</script>
</head>
<%@include file="../home/topmenu.jsp" %>
<body>
	<h1>전체 게시판</h1>
	<form method="get">
		<div class="board_box">
			<div>
				<div>
					<select  name="serchField">
						<option value="title">제목</option>
						<option value="context">내용</option>
						<option value="nickname">작성자</option>
					</select>
					<input type="text"  name="serchWord" value="${map.serchWord }">
					<input type="submit" value="검색하기">
				</div>
			</div>
		
			<table class="table_ul" border="1">
	         	<thead>
	                <tr class="tul_th">
	                    <td class="th_span th_num">번호</td>
	                    <td class="th_span" width="30%">제목</td>
	                    <td class="th_span">작성자</td>
	                    <td class="th_span">조회수</td>
	                    <td class="th_span">작성일</td>
	                </tr>
	             </thead>
	          <tbody>
	           <c:choose>
	           	<c:when test="${empty boardLists }">
					<tr>
						<td colspan="5" align="center">등록된 게시물이 없습니다.</td>
					</tr>	           	
	           	</c:when>
	           	<c:otherwise>
					<c:forEach items="${boardLists }" var="row" varStatus="loop">
						<tr>
							<td>${map.totalCount - (((map.pageNum-1)*map.pageSize)+loop.index)}</td>
							<td align="left">
								<a href="View.do?num=${row.num }&index=${map.totalCount - (((map.pageNum-1)*map.pageSize)+loop.index)}">
									${row.title }
								</a>
							</td>
							<td align="center">${row.nickname }</td>
							<td align="center">${row.visitCount }</td>
							<td align="center">${row.postdate }</td>
						</tr>
					</c:forEach>	           	
	           	</c:otherwise>
	           </c:choose>
	          </tbody>
	        </table>
	<table width="90%"  border='1'>
 		<tr align="center">
 			<td width="80%">${map.pagingStr }</td>
 			<td >
 				<button type="button" id="b_writeBtn">글쓰기</button>
 			</td>
 		</tr>
 	</table>
	</div>
	</form>
</body>
</html>







