<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>join.jsp</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
	function idCheck() {
		const id = $("#id").val();
		console.log(id);
	    $.ajax({
	        type: 'GET',
	        url: 'getMemberJson.jsp',
	        data: {id},
	        dataType: 'json',
	        success: function(data) {
	        	console.log(data);
	        	const rs = data['rs'];
		        let td = '';
		        
		        $('#idCheckRs').show();
		        if(data['rs'] === '0') {
	            	td = '<td colspan="2" style="color:blue">사용 가능한 아이디입니다.</td>';
	            	$('#idCheckRs').html(td);
	            } else {
	            	td = '<td colspan="2" style="color:red">사용 불가능한 아이디입니다.</td>';
	            	$('#idCheckRs').html(td);
	            }
	        },
	        error: function(xhr, status, error) {
	            console.log(xhr, status, error);
	        }
	    });
	};
	
	function joinAjax() {
		const id = $("#id").val();
		const pw = $("#pw").val();
		const name = $("#name").val();
		const role = $(":input:radio[name=role]:checked").val();
		const params = {id:id, pw, name, role}
		console.log(params);
		$.ajax({           
            type:'POST',
            url:'joinActionJson.jsp',
            dataType:'json',
            data: params,
            success: function (data) {
            	console.log('data=',data)
                if(data['rs'] === '1'){
                	alert('회원가입을 축하드립니다.!!!');
                	location.href = 'login.jsp';
                }else{
                	$('#failView').show();
	            	return;              	
                }     
            },
            error: function (request, status, error) {
                console.log(request, status,error);
            }
        });
	}
	
	
	$(function() {	
		$('#idCheckRs').hide();
		
		$('#idCheckBtn').on('click',function() {			
			idCheck();
		});
		
		$('#submitBtn').on('click',function() {
			joinAjax();
		});
	});
</script>
</head>
<body>
<%@include file="submenu.jsp" %>
<h2>회원가입<span id="failView" style="color:red;'"> : 실패 했습니다.</span></h2>
<hr>
<form>
	<table border="1">
		<tr><th>ID</th><td>
		<input type="text" name="id" id="id">
		<input id="idCheckBtn" type="button" value="ID Check">
		</td></tr>
		<tr id="idCheckRs"></tr>
		<tr><th>PW</th><td><input type="text" name="pw" id="pw"></td></tr>
		<tr><th>PW2</th><td><input type="text" name="pw2" id="pw2"></td></tr>
		<tr><th>Name</th><td><input type="text" name="name" id="name"></td></tr>
		<tr><th>Role</th><td>
		<input type="radio" name="role" value="1" checked="checked">Member
		<input type="radio" name="role" value="0">Admin
		</td></tr>
		<tr><td colspan="2"><input type="button" value="Submit" id="submitBtn"></td></tr>
	</table>
</form>
</body>
</html>