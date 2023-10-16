<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>        
<script>
	function deleteConfirm() {
		const input = confirm("회원을 탈퇴할까요?");
		alert(input);
		if (input) location.href = "delete.mi";
		else return;
	};
	
</script>

<jsp:include page="../topmenu.jsp" />
<jsp:include page="../subject.jsp" />
<c:set var="subPath" value="${pageContext.request.contextPath}/member-mvc-mybatis-interface" />   

<h1>Member Service v.MVC-JSTL</h1>
<h2>
<a href="${subPath}/main.mi">Home</a> |
<a href="${subPath}/memberList.mi">회원목록</a> |

<c:if test="${id == null }">
	<a href="${subPath}/join.mi">회원가입</a> |
	<a href="${subPath}/login.mi">로그인</a> |
	
</c:if>
<c:if test="${id != null }">
	<a href="${subPath}/update.mi">정보수정</a> |
	<a href="#" onclick="deleteConfirm();">회원탈퇴</a> |
	<a href="${subPath}/logout.mi">로그아웃</a> | <br>
	${name}(${id}) 로그인 중
</c:if>
</h2>
<hr>