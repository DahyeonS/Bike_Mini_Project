<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=request.getRequestURI() %></title>
</head>
<body>
<%@include file="submenu.jsp" %>
<h2 style="color:red;">크롬에서 확인!!</h2>
<h2><%=request.getRequestURI() %></h2>
</body>
</html>