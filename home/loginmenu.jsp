<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	#service {text-align: center; font-size: 18pt;}
</style>
<%@include file="./member/script/deleteConfrim.jsp" %>
<h2 id="service">
<a href="index.do">Home</a>

<% if (session.getAttribute("id") == null) { %>
	 | <a href="join.do" class ="menu">회원가입</a> |
	<a href="login.do">로그인</a>
<% } else { %>
	 | <a href="update.do">정보수정</a> |
	<a href="#" onclick="deleteConfirm();">회원탈퇴</a> |
	<a href="logout.do">로그아웃</a>
<% 		String seGrade = (String)session.getAttribute("grade");
		if (!(seGrade.equals("GENERAL"))) { %>
	 | <a href="memberList.do">회원목록</a>
<% 		} %>
<%		String grade = "";
		if (seGrade.equals("MANAGER")) grade = "매니저";
		else if (seGrade.equals("ASSOCIATE")) grade = "부매니저";
		else if (seGrade.equals("STAFF")) grade = "스태프";
		else grade = "일반회원";
%>
	<br><%=grade%> <%=session.getAttribute("nickname") %>(<%=session.getAttribute("id") %>)님 로그인 중 <br>
<% } %>
</h2>
<hr>