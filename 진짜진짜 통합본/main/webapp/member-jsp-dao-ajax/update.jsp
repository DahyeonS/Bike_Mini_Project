<%@page import="member.dao.MemberDAO"%>
<%@page import="member.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("id");

MemberDTO dto = new MemberDTO();
dto.setId(id);

MemberDAO dao = new MemberDAO();
dto = dao.getMember(dto);
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update.jsp</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
	function updateAjax() {
		const pw = $("#pw").val();
		const name = $("#name").val();
		const role = $(":input:radio[name=role]:checked").val();
		const params = {pw, name, role}
		console.log(params);
		
	    $.ajax({
	        type: 'POST',
	        url: 'updateActionJson.jsp',
	        data: params,
	        dataType: 'json',
	        success: function(data) {
	        	console.log(data);
	        	const rs = data['rs'];
		        
	        	if(data['rs'] === '1') {
	        		$('#resultView').text(" : 성공했습니다.")
	            } else {
	        		$('#resultView').text(" : 실패했습니다.")
	            	return;
	            }
	        },
	        error: function(xhr, status, error) {
	            console.log(xhr, status, error);
	        }
	    });
	};
	
	$(function() {	
		$('#failView').hide();
		$('#submitBtn').on('click',function() {
			updateAjax();
		});
	});
</script>
</head>
<body>
<%@include file="submenu.jsp" %>
<h2>회원정보수정<span id="resultView" style="color:red;"></span></h2>
<hr>
<form action="<%=contextPath %>/updateProc" method="post">
	<table border="1">
		<tr><th>ID</th><td><%=dto.getId()%></td></tr>
		<tr><th>PW</th><td><input type="text" name="pw" id="pw" value="<%=dto.getPw()%>"></td></tr>
		<tr><th>Name</th><td><input type="text" name="name" id="name" value="<%=dto.getName()%>"></td></tr>
		<tr><th>Role</th><td>
		<%if(dto.getRole().equals("1")){%>	
		<input type="radio" name="role" value="1" checked="checked">Member
		<input type="radio" name="role" value="0">Admin
		<%} %>
		<%if(dto.getRole().equals("0")) {%>
		<input type="radio" name="role" value="1">Member
		<input type="radio" name="role" value="0" checked="checked">Admin
		<%}%>
		</td></tr>
		<tr><td colspan="2"><input type="button" value="Submit" id="submitBtn"></td></tr>
	</table>
</form>
</body>
</html>