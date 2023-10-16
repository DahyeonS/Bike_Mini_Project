<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login.jsp</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
	function loginAjax() {
		const id = $("#id").val();
		const pw = $("#pw").val();
		const params = {id, pw};
	    $.ajax({
	        type: 'POST',
	        url: 'loginActionJson.jsp',
	        data: params,
	        dataType: 'json',
	        success: function(data) {
	        	console.log(data);
	        	const rs = data['rs'];
		        
	        	if(data['rs'] === '1') {
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
			loginAjax();
		});
	});
</script>
</head>
<body>
<%@include file="submenu.jsp" %>
<h2>로그인<span id="resultView" style="color:red;'"></span></h2>
<hr>
<form>
	<table border="1">
		<tr><th>ID</th><td><input type="text" name="id" id="id"></td></tr>
		<tr><th>PW</th><td><input type="text" name="pw" id="pw"></td></tr>
		<tr><td colspan="2"><input type="button" value="Submit" id="submitBtn"></td></tr>
	</table>	
</form>
</body>
</html>