<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// loginCheck.jsp
if(session.getAttribute("id") == null){
	response.sendRedirect("login.jsp");
}
%> 