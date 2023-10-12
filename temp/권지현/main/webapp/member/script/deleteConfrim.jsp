<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	function deleteConfirm() {
	    <% if (session.getAttribute("id") != null && session.getAttribute("id").equals("admin")) { %>
	       alert("관리자는 탈퇴할 수 없습니다.");
	    <% } else { %>
	       const input = confirm("회원을 탈퇴할까요?");
	       if (input) location.href = "delete.do";
	       else return;
	    <% } %>
	 };
</script>