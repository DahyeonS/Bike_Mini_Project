<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	function deleteConfirm() {
		const input = confirm("회원을 탈퇴할까요?");
		if (input) location.href = "delete.do";
		else return;
	};
	
</script>
<h1>Member Service</h1>
<h2>
<a href="List.do">Home</a> |

<% if (session.getAttribute("id") == null) { %>
	<a href="join.do">회원가입</a> |
	<a href="login.do">로그인</a> |
	
<% } else { %>
	<a href="update.do">정보수정</a> |
	<a href="#" onclick="deleteConfirm();">회원탈퇴</a> |
	<a href="logout.do">로그아웃</a> | <br>
	<%=session.getAttribute("name") %>(<%=session.getAttribute("id") %>) 로그인 중
<% } %>
</h2>
<hr>