<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<meta charset="UTF-8">
<title>boardList.jsp</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
<script src="./script/sendAjax.js"></script>
<script>

	function getCount () {
	   
		sendAjax('selectCount.json').then( (data) => {
	        	str = '<h4>총 게시물 수 : ' + data['totalCount'] + '</h4>';
	            $('#totalCount').html(str);
		})
	}
	
	function boardList () {
		
		sendAjax('boardList.json').then( (data) => {
			str = '<tr><td class="num">번호</td><td class="title">제목</td><td class="nickname">닉네임</td><td class="postdate">작성 날짜</td></tr>';
        	for(item of data) {
        		str += '<tr><td class="num">' + item['num'];
        		str += '</td><td class="title">' + '<a href = "#" onclick="aClick(' + item.num + ');">' + item['title'] + '</a>';
        		str += '</td><td class="nickname">' + item['nickname'];
        		str += '</td><td class="postdate">' + item['postdate'] + '</td></tr>';
        	}
        	$('#boardList').html(str);
		})
	}
	
	function searchList () {
		
    	const params = {searchWord: $('#searchWord').val(), searchField: $('#searchField').val()};
    	sendAjax('searchList.json', params).then( (data) => {
    		str = '<tr><td class="num">번호</td><td class="title">제목</td><td class="nickname">닉네임</td><td class="postdate">작성 날짜</td></tr>';
        	for(item of data) {
        		str += '<tr><td class="num">' + item['num'];
        		str += '</td><td class="title">' + '<a href = "#" onclick="aClick(' + item.num + ');">' + item['title'] + '</a>';
        		str += '</td><td class="nickname">' + item['nickname'];
        		str += '</td><td class="postdate">' + item['postdate'] + '</td></tr>';
        	}
        	$('#boardList').html(str);
		})
	}
	
	function aClick (num) {
		str = '${id}';
		if(str == '') {
			alert('회원만 게시물을 확인할 수 있습니다');
			location.href = "../khBoard/boardList.do";
		}
		else {
			location.href = "../khBoard/boardUpdate.do?num=" + num;		
		}
	}
	
	function write() {  
		str = '${id}';
		console.log(str);
		if(str != '') {
			$('#write').show();
		}
	}

	window.onload = function() {
		getCount ();
		boardList ();
		$('#write').hide();
		write ();
	}
	
	$(function name() {  // 실행시 자동으로 실행
		$('#searchBtn').on('click', function() {
			searchList();
		});

	});
	
	
</script>
<style>
	.num {width: 4%; text-align: center;}
	.title {width: 50%;}
	.nickname {width: 10%; text-align: center;}
	.postdate {width: 10%; text-align: center;}
	a { text-decoration-line: none; color:black;}
	a:visited { color:black;}

</style>

</head>
<body>
<%@ include file="../home/topmenu.jsp" %>
<h2>일반 게시글 목록</h2><br>
<div id="totalCount"></div>
<div>
	<table border="1" width="70%">
		<tbody id="boardList">
		</tbody>
	</table>
</div>
<div>
<form id="select">
	<select form="select" id ="searchField">
		<option value="title">제목</option>
		<option value="nickname">닉네임</option>
	</select>
	<input type="text" name="searchWord" id="searchWord">
	<input type="button" id="searchBtn" value="검색하기">
	<table border="1">
		<tbody id="searchList">
		</tbody>
	</table>
	<div id="write">
		<input type="button" id="writeBtn" value="글쓰기" onclick="location.href ='boardWrite.jsp'"/>
	</div>
</form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
</body>
</html>