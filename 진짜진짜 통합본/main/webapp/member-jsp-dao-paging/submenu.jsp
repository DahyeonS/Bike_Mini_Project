<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	function deleteConfirm() {
		const input = confirm("회원을 탈퇴할까요?");
		alert(input);
		if (input) location.href = "deleteProc.jsp";
		else return;
	};
	
</script>
<%@include file="../topmenu.jsp" %>
<%@include file="../subject.jsp" %>
<h2>
<a href="">Main</a> |
<a href="pagingEx.jsp">Paging JSP</a> |
<a href="pagingEx2.jsp">Paging Class</a> |
<a href="memberList.jsp">회원목록 - Paging</a> |
<a href="memberSearchList.jsp">회원목록+검색 - Paging</a> |

</h2>
<hr>