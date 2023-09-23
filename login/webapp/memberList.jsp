<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="loginCheck.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberListJson.jsp</title>
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<script>
	function getJson(param) {
	    $.ajax({
	        type: 'POST',
	        url: 'memberList.json',
	        dataType: 'json',
	        success: function(data) {
	            // for (item of data) console.log(item);
		        let tr = '';
	            for (item of data) {
		            const {idx, id, pw, nickname, grade, regdate} = item;
		            tr += '<tr style="text-align: center;"><td>' + idx + '</td><td>' + id + '</td><td>' + pw
		            + '</td><td>' + nickname + '</td><td>' + grade + '</td><td>' + regdate + '</td></tr>';
	            }
	            $('#tbody').html(tr);
	        },
	        error: function(xhr, status, error) {
	            console.log(xhr, status, error);
	        }
	    });
	};
	
	function memberSearch() {
		const name = $('#name').val();
		const param = {name};
		console.log(param);
		$.ajax({
	        type: 'Post',
	        url: 'getMemberNameJson.do',
	        dataType: 'json',
	        data: param,
	        success: function(data) {
	        	let tr = '';
	        	for (item of data) {
		            const {idx, id, pw, name, age, regdate} = item;
		            tr += '<tr style="text-align: center;"><td>' + idx + '</td><td>' + id + '</td><td>' + pw + '</td><td>' + name + '</td><td>' + age + '</td><td>' + regdate + '</td></tr>';
	            }
	            $('#tbody').html(tr);
	        }, error: function(xhr, status, error) {
	        	console.log(xhr, status, error);
	        }
		});
	};
	
	$(function() {
    	getJson();
    	
    	$('#search').click(function() {
    		memberSearch();
    	});
    });
</script>
</head>
<body>
<%@include file="loginmenu.jsp" %>
<h2>회원목록</h2>
<hr>
<table border="1">

<thead>
<tr>
	<th>일련번호</th>
	<th>아이디</th>
	<th>비밀번호</th>
	<th>닉네임</th>
	<th>등급</th>
	<th>가입날짜</th>
</tr>
</thead>

<tbody id="tbody">
</tbody>

</table>
<br>
<a href="updateAdmin.do">회원관리</a>
</body>
</html>