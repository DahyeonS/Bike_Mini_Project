<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String subPath = request.getContextPath() + "/member-mvc";
%>    
<script>
	function deleteConfirm() {
		const input = confirm("회원을 탈퇴할까요?");
		alert(input);
		if (input) location.href = "delete.do";
		else return;
	};
	
</script>
<%@include file="../topmenu.jsp" %>
<%@include file="../subject.jsp" %>
<h2>
<a href="<%=subPath %>/main.do">Home</a> |
<a href="<%=subPath %>/memberList.do">회원목록</a> |
<a href="<%=subPath %>/memberPagingList.do">회원목록-Paging</a> |

<% if (session.getAttribute("id") == null) { %>
	<a href="<%=subPath %>/join.do">회원가입</a> |
	<a href="<%=subPath %>/login.do">로그인</a> |
	
<% } else { %>	
	<a href="<%=subPath %>/update.do">정보수정</a> |
	<a href="#" onclick="deleteConfirm();">회원탈퇴</a> |
	<a href="<%=subPath %>/logout.do">로그아웃</a> | <br>
	<%=session.getAttribute("name") %>(<%=session.getAttribute("id") %>) 로그인 중
<% } %>
</h2>
<hr>