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
	        url: 'idCheck.json',
	        data: param,
	        dataType: 'json',
	        success: function(data) {
		        if(data['rs'] === 1) {
	   				$('#success').hide();
	    	        $('#fail').show();
	    	        $('#submit').attr('disabled', 'disabled');
	            } else {
	    			$('#fail').hide();
	            	$('#success').show();
	            	$('#submit').removeAttr("disabled");
	            }
	        },
	        error: function(xhr, status, error) {
	            console.log(xhr, status, error);
	        }
	    });
	};
	
	function join(params) {
		$.ajax({
	        type: 'POST',
	        url: 'join.json',
	        dataType: 'json',
	        data: params,
	        success: function(data) {
	        	if(data['rs'] === 1) {
	        		alert('회원가입을 축하드립니다!');
	        		location.href = 'login.jsp';
	        	} else {
	        		alert('다시 시도해주세요.');
	        	}
	        }, error: function(xhr, status, error) {
	            console.log(xhr, status, error);
	        }
		});
	};
	
	$(document).ready(function() {
	   	$('#success').hide();
	   	$('#fail').hide();
		$('#check').click(function() {
			const id = $('#id').val();
			const param = {id};
			if(id === '') {
				alert('아이디를 입력해주세요.');
				$('#id').focus();
				return;
			}
			idCheck(param);
		});
		
		$('#submit').click(function() {
			const id = $('#id').val();
			if(id === '') {
				alert('아이디를 입력해주세요.');
				$('#id').focus();
				return;
			}
			const pw = $('#pw').val();
			if(pw === '') {
				alert('비밀번호를 입력해주세요.');
				$('#pw').focus();
				return;
			}
			const pw2 = $('#pw2').val();
			if(pw2 === '') {
				alert('비밀번호 확인을 해주세요..');
				$('#pw2').focus();
				return;
			} else if (pw !== pw2) {
				alert('비밀번호가 일치하지 않습니다.');
				$('#pw2').focus();
				return;
			}
			const nickname = $('#nickname').val();
			if(nickname === '') {
				alert('닉네임을 입력해주세요.');
				$('#nickname').focus();
				return;
			}
			const params = {id, pw, nickname};
			join(params);
		});
	});
</script>
</head>
<body>
<%@include file="loginmenu.jsp" %>
<h2>회원가입</h2>
<hr>
<form name="joinForm" method="post">
	<table border="1">
		<tr><th>아이디</th>
		<td>
		<input type="text" name="id" id="id">
		<input id="check" type="button" value="ID 확인">
		</td></tr>
		
		<tr id="success"><td colspan="2">사용가능한 아이디입니다.</td></tr>
		<tr id="fail"><td colspan="2">사용불가능한 아이디입니다.</td></tr>
		<tr><th>비밀번호</th><td><input type="password" name="pw" id="pw"></td></tr>
		<tr><th>비밀번호 확인</th><td><input type="password" name="pw2" id="pw2"></td></tr>
		<tr><th>닉네임</th><td><input type="text" name="name" id="nickname"></td></tr>
		<tr><td colspan="2"><input id="submit" type="button" value="가입하기"></td></tr>
	</table>
</form>
</body>
</html>