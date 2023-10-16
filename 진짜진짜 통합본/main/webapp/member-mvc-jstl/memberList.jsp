<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberList.jsp</title>
</head>
<body>
<jsp:include page="submenu.jsp" />
<h2>회원목록</h2>
<hr>
<table border="1">
<tr>
	<th>Idx</th>
	<th>ID</th>
	<th>PW</th>
	<th>Name</th>
	<th>Role</th>
	<th>Regdate</th>
</tr>

<c:forEach var="dto" items="${list }">
	<tr>
		<td>${dto.idx}</td>
		<td>${dto.id}</td>
		<td>${dto.pw}</td>
		<td>${dto.name}</td>
		<td>${dto.role}</td>
		<td>${dto.regdate}</td>
	</tr>
</c:forEach>
</table>
<h1>
${paging.startPage} / ${paging.isPrev}
</h1>

</body>
</html>