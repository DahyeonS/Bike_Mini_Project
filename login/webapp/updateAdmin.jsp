<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="loginCheck.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update.jsp</title>
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<script>
	function memberShow() {
		const context = $('#context').val();
		const param = {context};
	    $.ajax({
	        type: 'POST',
	        url: 'memberShow.json',
	        data: param,
	        dataType: 'json',
	        success: function(data) {
	        	if (data['pw'] === null) alert('회원이 존재하지 않습니다.');
	        	else if (data['id'] === 'admin') alert('관리자는 수정할 수 없습니다.');
	        	else {
	        		$('#id').attr('value', data['id']);
	        		$('#nickname').attr('value', data['nickname']);
					$('#member').show();
	        	}
	        },
	        error: function(xhr, status, error) {
	            console.log(xhr, status, error);
	        }
	    });
	};

	function updateAdminJson() {
		const id = $('#id').val();
		const nickname = $('#nickname').val();
		const grade = $('#grade').val();
		const params = {id, nickname, grade};
		$.ajax({
	        type: 'POST',
	        url: 'updateAdmin.json',
	        dataType: 'json',
	        data: params,
	        success: function(data) {
	        	if(data['rs'] === 1) {
	        		alert('회원정보가 수정되었습니다.');
	        		location.href = "updateAdmin.do";
	        	} else {
	        		alert('죄송합니다. 다시 시도해주세요.');
	        	}
	        }, error: function(xhr, status, error) {
	        	console.log(xhr, status, error);
	        }
		});
	};
	
	function memberDeleteConfirm() {
	       const input = confirm("해당회원을 탈퇴시킬까요?");
	       if (input) {
	    	   alert("회원을 탈퇴시켰습니다.");
	       }
	       else return;
	 };
	
	$(function() {
		$('#member').hide();
		$('#search').click(function() {
			memberShow();
		});
		$('#submit').click(function() {
			updateAdminJson();
		});
	});
</script>
</head>
<body>
<%@include file="loginmenu.jsp"%>
<h2>회원정보 수정</h2>
<hr>
<form>
	<h3>조회할 회원의 아이디나 닉네임을 입력하세요.</h3>
	<table>
	<tr><td><input type="text" name="context" id="context"></td>
	<td><input type="button" value="검색" id="search"></tr>
	</table>
</form>
<br>
<form id="member">
	<table border="1">
		<tr><th>아이디</th><td><input type="text" name="id" id="id" readonly="readonly"></td></tr>
		<tr><th>닉네임</th><td><input type="text" name="nickname" id="nickname"></td></tr>
		<tr><td colspan="2"><select name="grade" id="grade">
			<option value="ASSOCIATE">부매니저</option>
			<option value="STAFF">스태프</option>
			<option value="GENERAL" selected="selected">일반회원</option>
		</select></td></tr>
		<tr><td><input type="button" value="수정하기" id="submit"></td><td><input type="button" value="회원탈퇴" id="delete" onclick="memberDeleteConfirm();"></td></tr>
	</table>
</form>
</body>
</html>