<%@page import="member.dao.MemberDAO"%>
<%@page import="member.dto.MemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberNameSearchList.jsp</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
	function getMemberListAjax(page) {
		const name = $("#name").val();
		const params = {page,name};
	    $.ajax({
	        type: 'POST',
	        url: 'getMemberSearchNameListJson.jsp',
	        data: params,
	        dataType: 'json',
	        success: function(data) {
	        	console.log(data);
	        	const rs = data['rs'];
		        
	        	if(data['rs'] === '0') {	        		
	            	$('#resultView').text(' : 0명');
	            	return;
	            } else {
	            	$('#resultView').text(` : ${'${rs.length}'}명`);
	            	makeTr(rs);
	            }
	        },
	        error: function(xhr, status, error) {
	            console.log(xhr, status, error);
	        }
	    });
	};
	
	function makeTr(rs){
		let tr = ``;
		for(item of rs){
    		const idx = item['idx'];
    		const id = item['id'];
    		const pw = item['pw'];
    		const name = item['name'];
    		const role = item['role'];
    		const regdate = item['regdate'];
    		tr += `
    		<tr>
    		<td>${ '${idx}' }</td>
    		<td>${ '${id}' }</td>
    		<td>${ '${pw}' }</td>
    		<td>${ '${name}' }</td>
    		<td>${ '${role}' }</td>
    		<td>${ '${regdate}' }</td>
    		</tr>`;    		
    	}
		$('tbody').html(tr);
	}
	
	$(function() {		
		getMemberListAjax();
		$('#submitBtn').on('click',function() {
			getMemberListAjax();
		});
	});
</script>
</head>
<body>
<%@include file="submenu.jsp" %>
<h2>회원목록<span id="resultView" style="color:red;'"></span></h2>
<hr>
<table border="1">
<thead>
<tr>
<th>Search</th>
<td colspan="6">
<input type="text" name="name" id="name">
<input type="button" value="Submit" id="submitBtn">
</td>
</tr>
<tr>
	<th>Idx</th>
	<th>ID</th>
	<th>PW</th>
	<th>Name</th>
	<th>Role</th>
	<th>Regdate</th>
</tr>
</thead>
<tbody>
</tbody>
</table>
</body>
</html>