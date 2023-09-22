<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("id")==null){
%>
	<script>
		alert("로그인 후 이용해 주십시오.")
		location.href="login.do";
	</script>
<%}%>