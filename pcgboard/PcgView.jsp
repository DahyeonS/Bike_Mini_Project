<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./css/style.css">
<script>
	function deleteProcess() {
		const num = $
		{
			dto.num
		}
		;
		$.ajax({
			type : 'POST',
			url : 'pcgDeleteboard.json',
			dataType : 'json',
			data : {
				num : num
			},
			success : function(data) {
				if (data['rs'] === 0) {
					alert("삭제에 실패했습니다");
					location.href = "View.do?num=" + num;
				} else {
					alert("삭제되었습니다");
					location.href = "board.do";
				}
			},
			error : function(xhr, status, error) {
				console.log(xhr, status, error);
			}
		});
	};
	function deletePost() {
		const confirmed = confirm("정말로 삭제하겠습니까?");
		if (confirmed) {
			deleteProcess();
		}
	}
</script>
</head>
<body>

	<%@include file="../home/topmenu.jsp"%>
	<form name="writeFrm">
		<table border="1" class="container">
		<tr>
		<th colspan="4	">
			<h1>회원제 게시판 - 상세 보기</h1>
		</th>
		</tr>
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
				<td colspan="3" height="100">${dto.context }</td>
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
					<!-- 로그인 했을때 -->
					<tr>
						<td colspan="4" align="center"><input type="button"
							value="&lt;" id="prevBtn">
							<button type="button" class="custom-btn btn-3"
								onclick="location.href='PcgEdit.do?num=${dto.num}';">
								수정하기</button>
							<button type="button" class="custom-btn btn-3" onclick="location.href='FreeBoardListPaging.do';">목록보기</button>
							<button type="button" class="custom-btn btn-3" onclick="deletePost();">삭제하기</button> <input
							type="button" value="&gt;" id="nextBtn"></td>
					</tr>


					<!-- 로그인 필요할 때 -->
				</c:when>
				<c:otherwise>
				<tr>
					<td colspan="4" align="center">
							<button type="button" value="&lt;" id="prevBtn" class="custom-btn btn-3"></button>
							<button type="button" class="custom-btn btn-3" onclick="location.href='FreeBoardListPaging.do';">
								목록보기</button>
							<button type="button" value="&gt;" id="nextBtn" class="custom-btn btn-3"></button>
				</tr>
						</c:otherwise>
			</c:choose>
		</table>
	</form>
	<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
			crossorigin="anonymous"></script>
		<script
			src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
			integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
			crossorigin="anonymous"></script>
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js"
			integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa"
			crossorigin="anonymous"></script>
</body>
</html>