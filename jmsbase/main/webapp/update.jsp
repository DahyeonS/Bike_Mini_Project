<%@page import="miniproject.MemberDAO"%>
<%@page import="miniproject.MemberDTO"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update.jsp</title>
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<script>
function getDto(param) {
    $.ajax({
        type: 'POST',
        url: 'getDto.json',
        dataType: 'json',
        success: function(data) {
        	console.log(data);
        	
        	let tr="<tr><th>ID</th><td>"+data['id']+"</td></tr>";
        	tr+="<tr><th>PW</th><td><input type=\"text\" name=\"pw\" value="+data['pass']+"></td></tr>";
        	tr+="<tr><th>NAME</th><td><input type=\"text\" name=\"name\" value="+data['name']+"></td></tr>";
 			tr+="<tr><td colspan=\"2\"><input type=\"submit\" value=\"수정하기\"></td></tr>";
 			$('#table').html(tr);
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};
$(document).ready(function() {
	getDto();
});
</script>
</head>
<body>
<%@include file="topmenu.jsp" %>
<h2>회원정보 수정</h2>
<hr>
<form action="updateProc.do" method="post">
	<table border="1" id="table"></table>
</form>
</body>
</html>