<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.invalidate();
%>
<script>
	alert('가실려구요? 또 오세요. 감사합니다!!');
	location.href = 'List.do';
</script>