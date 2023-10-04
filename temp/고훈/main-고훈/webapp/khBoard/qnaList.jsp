<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList.jsp</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
<script src="./script/sendAjax.js"></script>
<script>


	function qGetCount () {
		
		sendAjax('qSelectCount.json').then( (data) => {
   			str = '<h3>총 질문 게시물 수 : ' + data['totalCount'] + '</h3>'
            $('#qTotalCount').html(str);
		})
	}
	
	function qBoardList () {
		
		sendAjax('qBoardList.json').then( (data) => {
			str = '<tr><td class="num">번호</td><td class="title">제목</td><td class="nickname">닉네임</td><td class="postdate">작성 날짜</td></tr>';
        	for(item of data) {
        		str += '<tr><td class="num">' + item['num'];
        		str += '</td><td class="title">' + '<a href = "#" onclick="aClick(' + item.num + ');">' + item['title'] + '</a>';
        		str += '</td><td class="nickname">' + item['nickname'];
        		str += '</td><td class="postdate">' + item['postdate'] + '</td></tr>';
        	}
        	$('#qBoardList').html(str);
		})
	}
	  
	function qSearchList () {
    	const params = {searchWord: $('#searchWord').val(), searchField: $('#searchField').val()};
    	
    	sendAjax('qSearchList.json', params).then( (data) => {
    		str = '<tr><td class="num">번호</td><td class="title">제목</td><td class="nickname">닉네임</td><td class="postdate">작성 날짜</td></tr>';
        	for(item of data) {
        		str += '<tr><td class="num">' + item['num'];
        		str += '</td><td class="title">' + '<a href = "#" onclick="aClick(' + item.num + ');">' + item['title'] + '</a>';
        		str += '</td><td class="nickname">' + item['nickname'];
        		str += '</td><td class="postdate">' + item['postdate'] + '</td></tr>';
        	}
        	$('#qBoardList').html(str);
		})
	}
	   
	function aClick (num) {
		str = '${id}';
		if(str == '') {
			alert('회원만 게시물을 확인할 수 있습니다');
			location.href = "../khBoard/qnaList.do";
		}
		else {
			location.href = "../khBoard/qnaUpdate.do?num=" + num;		
		}
	}
	
	function qnaWrite() {  
		str = '${id}';
		console.log(str);
		if(str != '') {
			$('#qWrite').show();
		}
	}
	
	$(function name() {  // 실행시 자동으로 실행
		$('#searchBtn').on('click', function() {
			qSearchList();
		});

	});
	
	window.onload = function() {
		qGetCount ();
		qBoardList ();
		$('#qWrite').hide();
		qnaWrite ();
	}
	
	
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
<h1>질문 목록 보기(List)</h1>
<div id="qTotalCount"></div>
<div>
	<table border="1" width="70%">
		<tbody id="qBoardList">
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
	<div id="qWrite">
		<input type="button" id="writeBtn" value="글쓰기" onclick="location.href ='qWrite.jsp'"/>
	</div>
</form>
</div>
</body>
</html>