<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String subPath = request.getContextPath() + "/member-jsp-dao-servlet";
%>    
<script>
	function deleteConfirm() {
		const input = confirm("회원을 탈퇴할까요?");
		alert(input);
		if (input) location.href = "delete.jsp";
		else return;
	};
	
</script>
<%@include file="../topmenu.jsp" %>
<%@include file="../subject.jsp" %>
<h2>
<a href="<%=subPath %>/main.jsp">Home</a> |
<a href="<%=subPath %>/memberList.jsp">회원목록</a> |

<% if (session.getAttribute("id") == null) { %>
	<a href="<%=subPath %>/join.jsp">회원가입</a> |
	<a href="<%=subPath %>/login.jsp">로그인</a> |
	
<% } else { %>	
	<a href="<%=subPath %>/update.jsp">정보수정</a> |
	<a href="#" onclick="deleteConfirm();">회원탈퇴</a> |
	<a href="<%=subPath %>/logout.jsp">로그아웃</a> | <br>
	<%=session.getAttribute("name") %>(<%=session.getAttribute("id") %>) 로그인 중
<% } %>
</h2>
<hr>