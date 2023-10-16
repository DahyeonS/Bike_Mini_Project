<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<jsp:include page="loginCheck.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update.jsp</title>
</head>
<body>
<jsp:include page="submenu.jsp" />
<h2>회원정보수정 : id = <%=session.getAttribute("id") %></h2>
<hr>
<c:if test="${id != null }">
<form action="updateAction.do" method="post">
	<table border="1">
		<tr><th>ID</th><td>${dto.id}</td></tr>
		<tr><th>PW</th><td><input type="text" name="pw" value="${dto.pw}"></td></tr>
		<tr><th>Name</th><td><input type="text" name="name" value="${dto.name}"></td></tr>
		<tr><th>Role</th><td>
		<c:if test="${dto.role == '1' }">
		<input type="radio" name="role" value="1" checked="checked">Member
		<input type="radio" name="role" value="0">Admin
		</c:if>
		<c:if test="${dto.role == '0' }">
		<input type="radio" name="role" value="1">Member
		<input type="radio" name="role" value="0" checked="checked">Admin
		</c:if>
		</td></tr>
		<tr><td colspan="2"><input type="submit" value="Submit"></td></tr>
	</table>
</form>
</c:if> 
</body>
</html>