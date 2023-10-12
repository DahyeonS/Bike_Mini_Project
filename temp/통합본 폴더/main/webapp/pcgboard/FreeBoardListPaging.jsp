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
	<%@include file="../home/topmenu.jsp"%>

	<h2>글 목록 : ${PagingDTO.pageNum}/${PagingDTO.totalPage}
		(${PagingDTO.totalCount}) 시작 : ${PagingDTO.startPage} 끝 :
		${PagingDTO.endPage}</h2>
	<hr>
	<table border="1">
		<tr>
			<td colspan="6" style="text-align: center; font-size: 20px;">
					<form action="FreeBoardListPaging.do" method="get">
						<!-- 검색 카테고리 값 -->
						<div style="border: 1px; float: left;">
							<select id="categorySelect" name="categorySelect">
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
						<div style="border: 1px; float: left;">
							<select id="SelectSearch" name="Selecttext">
								<!-- 선택 목록 -->
								<option value="title_value">제목</option>
								<option value="context_value">내용</option>
								<option value="nickname_value">닉네임</option>
							</select> 
							<input type="text" name=textInputValue id="textInputValue"
								placeholder="텍스트 입력" style="width: 50%;"> <input
								type="submit" value="검색">
						</div>
					</form>
					<!-- 검색 폼 종료 -->
					<form action="FreeBoardListPaging.do" method="get"> 
					  <button type="submit" >전체목록</button>
					</form>
					
			</td>
		</tr>
		<tr>
			<td><h4>num</h4></td>
			<td width="50%"><h4>title</h4></td>
			<td><h4>nickname</h4></td>
			<td><h4>CATEGORY</h4></td>
			<td width="10%"><h4>visitCount</h4></td>
			<td><h4>postdate</h4></td>
		</tr>
		<!-- 게시판 리스트 출력 -->
		<!-- boardList를 이용한 게시판 목록 출력 -->
		<c:forEach items="${list}" var="PcgBoardDTO">
			<tr>
				<td>${PcgBoardDTO.num}</td>
				<td><a href=PcgView.do?num=${PcgBoardDTO.num}>${PcgBoardDTO.title}
				</a></td>
				<td>${PcgBoardDTO.nickname}</td>
				<td>${PcgBoardDTO.category}</td>
				<td>${PcgBoardDTO.visitCount}</td>
				<td>${PcgBoardDTO.postdate}</td>

				<!-- 다른 필드들도 필요에 따라 출력 -->
			</tr>
		</c:forEach>

		<tr>
			<td colspan="6" style="text-align: center; font-size: 20px;">
				<!-- 페이징 버튼 생성 -->
				<div class="pagination">
					<c:if test="${PagingDTO.isPrev eq true }">
						<a
							href="FreeBoardListPaging.do?pageNum=${PagingDTO.pageNum - 1}&categorySelect=${categorySelect}&textInputValue=${textInputValue}&Selecttext=${Selecttext}">&lt;</a>
					</c:if>

					<c:forEach begin="${PagingDTO.startPage}"
						end="${PagingDTO.endPage}" var="pageNumber">
						<c:choose>
							<c:when test="${pageNumber eq PagingDTO.pageNum}">
								<span class="current">${pageNumber}</span>
							</c:when>
							<c:otherwise>
								<a
									href="FreeBoardListPaging.do?pageNum=${pageNumber}&categorySelect=${categorySelect}&textInputValue=${textInputValue}&Selecttext=${Selecttext}">${pageNumber}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${PagingDTO.isNext}">
						<a
							href="FreeBoardListPaging.do?pageNum=${PagingDTO.pageNum + 1}&categorySelect=${categorySelect}&textInputValue=${textInputValue}&Selecttext=${Selecttext}">&gt;</a>
					</c:if>

				</div>
			</td>
		</tr>
	</table>