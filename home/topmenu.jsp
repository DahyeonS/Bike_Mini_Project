<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	#service {text-align: center;}
</style>
<script>
	function deleteConfirm() {
		const input = confirm("회원을 탈퇴할까요?");
		alert(input);
		if (input) location.href = "delete.do";
		else return;
	};
</script>
<h2 id="service">
<a href="index.do">Home</a> |

<% if (session.getAttribute("id") == null) { %>
	<a href="join.do" class ="menu">회원가입</a> |
	<a href="login.do">로그인</a> |
<% } else { %>
	<a href="update.do">정보수정</a> |
	<a href="#" onclick="deleteConfirm();">회원탈퇴</a> |
	<a href="logout.do">로그아웃</a> | <br>
	<%=session.getAttribute("name") %>(<%=session.getAttribute("id") %>) 로그인 중
<% } %>

<% if (!(session.getAttribute("grade").equals("GENERAL"))) { %>
	<a href="memberList.do">회원목록</a> |
<% } %>
</h2>
<hr>