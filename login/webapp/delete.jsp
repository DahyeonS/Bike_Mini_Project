<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="loginCheck.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>delete.jsp</title>
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<script>
	function deleteJson() {
		const pw = $('#pw').val();
		const param = {pw};
		$.ajax({
	        type: 'POST',
	        url: 'delete.json',
	        dataType: 'json',
	        data: param,
	        success: function(data) {
	        	if(data['rs'] === 1) {
	        		alert('회원탈퇴가 완료되었습니다. 그동안 감사했습니다.');
	        		location.href = 'index.do';
	        	} else alert('죄송합니다. 다시 시도해주세요.');
	        }, error: function(xhr, status, error) {
	        	console.log(xhr, status, error);
	        }
		});
	};
	
	$(function() {
		$('#submit').click(function() {
			deleteJson();
		});
	});
</script>
</head>
<body>
<%@include file="loginmenu.jsp" %>
<h2>회원탈퇴</h2>
<hr>
<form action="deleteProc" method="post">
	<table border="1">
		<tr><th>PW</th><td><input type="password" name="pw" id="pw"></td></tr>
		<tr><td colspan="2"><input type="button" value="회원탈퇴" id="submit"></td></tr>
	</table>
</form>
</body>
</html>