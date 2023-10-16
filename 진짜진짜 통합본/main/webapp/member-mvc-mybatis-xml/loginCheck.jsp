<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>       

<c:if test="${id eq null }">
	<script>
	alert('session이 끊겼습니다.!!');
	location.href = 'login.do';
	</script>
</c:if>
