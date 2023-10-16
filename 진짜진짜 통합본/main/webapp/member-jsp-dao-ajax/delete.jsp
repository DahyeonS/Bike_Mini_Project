<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="loginCheck.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>delete.jsp</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
	function deleteAjax() {
		const pw = $("#pw").val();
		const params = {pw};
	    $.ajax({
	        type: 'POST',
	        url: 'deleteActionJson.jsp',
	        data: params,
	        dataType: 'json',
	        success: function(data) {
	        	console.log(data);
	        	const rs = data['rs'];
		        
	        	if(data['rs'] === '1') {
	        		alert('회원탈퇴 성공 했습니다.');
	        		location.href="main.jsp";
	            } else {
	            	$('#resultView').text(' : 실패 했습니다.');
	            	return;
	            }
	        },
	        error: function(xhr, status, error) {
	            console.log(xhr, status, error);
	        }
	    });
	};
	
	$(function() {	
		$('#submitBtn').on('click',function() {
			deleteAjax();
		});
	});
</script>
</head>
<body>
<%@include file="submenu.jsp" %>
<h2>회원탈퇴<span id="resultView" style="color:red;"></span></h2>
<hr>
<form>
	<table border="1">
		<tr><th>PW</th><td><input type="password" name="pw" id="pw"></td></tr>
		<tr><td colspan="2"><input type="button" value="회원탈퇴" id="submitBtn"></td></tr>
	</table>
</form>
</body>
</html>