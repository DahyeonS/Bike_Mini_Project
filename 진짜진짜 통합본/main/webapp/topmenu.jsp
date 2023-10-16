<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String contextPath = request.getContextPath();
%>
<h1>Java Web Application </h1>  
<h2>
<a href="<%=contextPath %>">Home</a> |
<a href="<%=contextPath %>/basic/main.jsp">Basic</a> |
<a href="<%=contextPath %>/member-jsp/main.jsp">v.JSP</a> |
<a href="<%=contextPath %>/member-jsp-dao/main.jsp">v.JSP-DAO</a> |
<a href="<%=contextPath %>/member-jsp-dao-servlet/main.jsp">v.JSP-DAO-Servlet</a> |
<a href="<%=contextPath %>/member-jsp-dao-ajax/main.jsp">v.AJAX</a> |
<a href="<%=contextPath %>/member-jsp-dao-paging/main.jsp">v.Paging</a> |
<a href="<%=contextPath %>/member-mvc/main.do">v.MVC</a> |
<a href="<%=contextPath %>/member-mvc-jstl/main.go">v.MVC-JSTL</a> |
<a href="<%=contextPath %>/member-mvc-mybatis-xml/main.mx">v.MVC-Mybatis-XML</a> |
<a href="<%=contextPath %>/member-mvc-mybatis-interface/main.mi">v.MVC-Mybatis-Interface</a> |

</h2>
<hr>