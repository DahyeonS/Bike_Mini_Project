<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>        
<script>
	function deleteConfirm() {
		const input = confirm("회원을 탈퇴할까요?");
		alert(input);
		if (input) location.href = "delete.mx";
		else return;
	};
	
</script>

<jsp:include page="../topmenu.jsp" />
<jsp:include page="../subject.jsp" />
<c:set var="subPath" value="${pageContext.request.contextPath}/member-mvc-mybatis-xml" />   

<h1>Member Service v.MVC-JSTL</h1>
<h2>
<a href="${subPath}/main.mx">Home</a> |
<a href="${subPath}/memberList.mx">회원목록</a> |

<c:if test="${id == null }">
	<a href="${subPath}/join.mx">회원가입</a> |
	<a href="${subPath}/login.mx">로그인</a> |
	
</c:if>
<c:if test="${id != null }">
	<a href="${subPath}/update.mx">정보수정</a> |
	<a href="#" onclick="deleteConfirm();">회원탈퇴</a> |
	<a href="${subPath}/logout.mx">로그아웃</a> | <br>
	${name}(${id}) 로그인 중
</c:if>
</h2>
<hr>