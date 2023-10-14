<%@page import="pcgpkg.PagingDTO"%>
<%@page import="pcgpkg.PcgBoardDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Paging Example</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./css/style.css">

<script>
	// select 요소가 변경될 때 실행할 함수를 정의합니다.
	$(document).ready(function() {
		$("#categorySelect").change(function() {
			// 선택된 값을 가져와서 출력합니다.
			var selectedValue = $(this).val();
			$("#selectedValue").text("선택된 값: " + selectedValue);
		});
	});
</script>
</head>
<body>
	<header>
		<%@include file="../home/topmenu.jsp"%>
	</header>
	<main>
		<hr>
		 <!--시작 : ${PagingDTO.startPage} 끝 :
						${PagingDTO.endPage} -->
		<table id="boardTable" border="1" class="container">

			<tr>
				<th colspan="6"  style="text-align: center; font-size: 13px;">
					<h1>List count : ${PagingDTO.pageNum}/${PagingDTO.totalPage}
						(${PagingDTO.totalCount}) </h1>
						
				</th>
			</tr>
			
			<tr>

				<th colspan="6" style="text-align: center; font-size: 13px;">
					<form action="FreeBoardListPaging.do" method="get">
						<button class="custom-btn btn-3" type="submit">
							<span><img src="./css/list.svg" />전체 목록 보기 <img
								src="./css/list.svg" /> </span>
						</button>
					</form>
					<!-- 검색 카테고리 값 -->
					<form action="FreeBoardListPaging.do" method="get">
							<div style="border: 1px; float: right; white-space: nowrap;"
							class="grid text-center">
							<select id="listNum" name="listNum"
								class="form-select" aria-label="Default select example">
								<!-- 선택 목록 -->
								<option value="5">5</option>
								<option value="10" selected>10</option>
								<option value="20" >20</option>
							</select>
						</div>
						<div style="border: 1px; float: right; white-space: nowrap;"
							class="grid text-center">
							<select id="SelectSearch" name="Selecttext"
								aria-label="Default select example" class="form-select"
								aria-label="Default select example">
								<!-- 선택 목록 -->
								<option value="title_value">제목</option>
								<option value="context_value">내용</option>
								<option value="nickname_value">닉네임</option>
							</select>
						</div>

						<div style="border: 1px; float: right; white-space: nowrap;"
							class="grid text-center">
							<select id="categorySelect" name="categorySelect"
								class="form-select" aria-label="Default select example">
								<!-- 선택 목록 -->
								<option value="">전체</option>
								<option value="자유">자유</option>
								<c:forEach items="${categorylist}" var="cgl">
									<c:choose>
										<c:when test="${cgl eq '자유'}">
										</c:when>
										<c:otherwise>
											<option value="${cgl}">${cgl}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						</div>
						<div class="input-group mb-3">
							<input type="text" name=textInputValue id="textInputValue"
								class="form-control" placeholder=""
								aria-label="Recipient's username"
								aria-describedby="button-addon2" placeholder="검색어 입력">
							<button class="btn btn-outline-secondary btn-3" type="submit">
								<span><img src="./css/search.svg" /></span>
							</button>
						</div>

					</form> <!-- 검색 폼 종료 -->



				</th>
				<!-- 테이블 헤드  -->
			</tr>
			<tr>
				<th><h1>num</h1></th>
				<th><h1>title</h1></th>
				<th><h1>nickname</h1></th>
				<th><h1>CATEGORY</h1></th>
				<th><h1>visitCount</h1></th>
				<th><h1>postdate</h1></th>
			</tr>
			<!-- 게시판 리스트 출력 -->
			<!-- boardList를 이용한 게시판 목록 출력 -->
			<c:forEach items="${list}" var="PcgBoardDTO">
				<tr>
					<td>${PcgBoardDTO.num}</td>
					<td id="boardTitle"><a href=PcgView.do?num=${PcgBoardDTO.num}>${PcgBoardDTO.title}</a></td>

					<td>${PcgBoardDTO.nickname}</td>
					<td>${PcgBoardDTO.category}</td>
					<td>${PcgBoardDTO.visitCount}</td>
					<td>${PcgBoardDTO.postdate}</td>

					<!-- 다른 필드들도 필요에 따라 출력 -->
				</tr>
			</c:forEach>
		</table>
		<!-- 페이징 버튼 생성 -->
		<div id="pagination" class="pagination">
			<c:if test="${PagingDTO.isPrev eq true }">
				<a
					href="FreeBoardListPaging.do?pageNum=${PagingDTO.pageNum - 1}&categorySelect=${categorySelect}&textInputValue=${textInputValue}&Selecttext=${Selecttext}&listNum=${listNum}">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
						fill="currentColor" class="bi bi-arrow-left-circle-fill"
						viewBox="0 0 16 16">
  <path
							d="M8 0a8 8 0 1 0 0 16A8 8 0 0 0 8 0zm3.5 7.5a.5.5 0 0 1 0 1H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H11.5z" />
</svg>
				</a>
			</c:if>

			<c:forEach begin="${PagingDTO.startPage}" end="${PagingDTO.endPage}"
				var="pageNumber">
				<c:choose>
					<c:when test="${pageNumber eq PagingDTO.pageNum}">
						<span class="current"><a>${pageNumber}</a></span>
					</c:when>
					<c:otherwise>
						<a
							href="FreeBoardListPaging.do?pageNum=${pageNumber}&categorySelect=${categorySelect}&textInputValue=${textInputValue}&Selecttext=${Selecttext}&listNum=${listNum}">${pageNumber}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${PagingDTO.isNext}">
				<a
					href="FreeBoardListPaging.do?pageNum=${PagingDTO.pageNum + 1}&categorySelect=${categorySelect}&textInputValue=${textInputValue}&Selecttext=${Selecttext}&listNum=${listNum}">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
						fill="currentColor" class="bi bi-arrow-right-circle-fill"
						viewBox="0 0 16 16">
  <path
							d="M8 0a8 8 0 1 1 0 16A8 8 0 0 1 8 0zM4.5 7.5a.5.5 0 0 0 0 1h5.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H4.5z" />
</svg>
				</a>
			</c:if>

		</div>
	</main>
	<footer> </footer>

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



