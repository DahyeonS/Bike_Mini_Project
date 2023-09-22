<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>join.jsp</title>
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<script>
	function idCheck(param) {
	    $.ajax({
	        type: 'POST',
	        url: 'getMemberJson.json',
	        data: {id:param},
	        dataType: 'json',
	        success: function(data) {
	        	console.log(data);
		        let td = '';
		        if(data['rs'] === '1') {
	   				$('#success').hide();
	    	        $('#fail').show();
	            	td = '<td colspan="2">사용불가능한 아이디입니다.</td>';
	            	$('#fail').html(td);
	            } else {
	    			$('#fail').hide();
	            	$('#success').show();
	            	td = '<td colspan="2">사용가능한 아이디입니다.</td>';
	            	$('#success').html(td);
	            }
	        },
	        error: function(xhr, status, error) {
	            console.log(xhr, status, error);
	        }
	    });
	};
	function join(id,pw,name) {
		const user={id:id,pw:pw,name:name}
	    $.ajax({
	        type: 'POST',
	        url: 'joinProc.json',
	        data: user,
	        dataType: 'json',
	        success: function(data) {
	        	console.log(data);
		        if(data['rs']===1){
		        	alert("회원가입을 축하드립니다.");
		        	location.href="login.do";
		        }
	        },
	        error: function(xhr, status, error) {
	            console.log(xhr, status, error);
	        }
	    });
	};
	
	$(document).ready(function() {
		$('#check').on("click",function() {
			const idInput = $('#id').val();
			if(idInput === '') {
				alert('id는 필수값입니다.');
				$('#id').focus();
				return;
			}
			idCheck(idInput);
		});
		$('#join').on("click",function() {
			const idInput = $('#id').val();
			const pwInput = $('#pw').val();
			const nameInput = $('#name').val();
			
			join(idInput,pwInput,nameInput);
		});
	});
</script>
</head>
<body>
<%@include file="topmenu.jsp" %>
<h2>회원가입</h2>
<hr>
<form name="joinForm" action="joinProc.do" method="post">
	<table border="1">
		<tr><th>ID</th>
		<td>
		<input type="text" name="id" id="id">
		<input id="check" type="button" value="ID Check">
		</td></tr>
		
		<tr id="success"></tr>
		<tr id="fail"></tr>
		<tr><th>PW</th><td><input type="password" id="pw"></td></tr>
		<tr><th>PW2</th><td><input type="password" id="pw2"></td></tr>
		<tr><th>Name</th><td><input type="text" id="name"></td></tr>
		<tr><td colspan="2"><input type="button" value="회원가입" id="join"></td></tr>
	</table>
</form>
</body>
</html>