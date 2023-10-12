<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
<script>
function deleteProcess() {
const num=${dto.num};
	$.ajax({
        type: 'POST',
        url: 'pcgDeleteboard.json',
        dataType: 'json',
        data: {num:num},
        success: function(data) {
        	if(data['rs']===0){
        		alert("삭제에 실패했습니다");
        		location.href="View.do?num="+num;
        	}else{
        		alert("삭제되었습니다");
        		location.href="board.do";
        	}
        }, error: function(xhr, status, error) {
        	console.log(xhr, status, error);
        }
	});
};
function deletePost(){
	const confirmed=confirm("정말로 삭제하겠습니까?");
	if(confirmed){
		deleteProcess();
	}
}

</script>
</head>
<body>

<%@include file="../home/topmenu.jsp" %>
<h2>회원제 게시판 - 상세 보기</h2>
<form name="writeFrm">
	<table border="1" width="90%">
		<tr>
			<td>번호</td>
			<td>${dto.num }</td>
			<td>작성자</td>
			<td>${dto.nickname }</td>
		</tr>
		<tr>
			<td>작성일</td>
			<td>${dto.postdate }</td>
			<td>조회수</td>
			<td>${dto.visitCount }</td>
		</tr>
		<tr>
			<td>제목</td>
			<td colspan="3">${dto.title }</td>
		</tr>
		<tr>
			<td>내용</td>
			<td colspan="3" height="100">
			${dto.context }
			</td>
		</tr>
	<c:if test="${not empty dto.fileName }">
		<tr>
			<td>파일</td>
			<td colspan="2">${dto.fileName }</td>
			<td><a href="download.do?sfile=${dto.fileName }">[다운로드]</a></td>
		</tr>
	</c:if>
	<c:choose>
		<c:when test="${id eq dto.id or admin eq OK and not empty id}">	
		
			<tr>
			<td colspan="4" align="center">
					<button type="button" onclick="location.href='PcgEdit.do?num=${dto.num}';">	수정하기</button>
					<button type="button" onclick="location.href='FreeBoardList.do';">목록보기</button>
					<button type="button" onclick="deletePost();">삭제하기	</button>
			</td>
			</tr>
		
		</c:when>	
		<c:otherwise>
			<tr>			
			<td colspan="4" align="center"><button type="button" onclick="location.href='FreeBoardList.do';">
						목록보기
			</button></td>
			</tr>
		</c:otherwise>	
	</c:choose>
		     <tr>
		        
            <td> <input type="button" value="&lt;" id="prevBtn"></td>
               	<td><input type="button" value="&gt;" id="nextBtn"></td>
           </tr	> 
	</table>
</form>
</body>
</html>