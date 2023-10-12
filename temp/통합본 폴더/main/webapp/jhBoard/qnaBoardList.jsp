<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>qnaBoardList.jsp</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Caveat&family=Nanum+Pen+Script&display=swap');
</style>
<style>
	body {
		background-image: url('jhImages8.png');
		background-size: 100%;
		background-repeat: no-repeat;
		background-attachment: fixed;
		background-position: 0px, 50%;
	}
	
	* {
		font-family: 'Caveat', cursive;
		font-family: 'Nanum Pen Script', cursive;		
	}
	
	.border {
		border: 20px
	}
	
	.head {
		font-weight: bold;
	}
	
	table {
		margin : auto;
   		width : 80%;
   		background-color: white;
	}
	
</style>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
<script>

function getCount () {
	const params = {searchWord: $('#searchWord').val(), searchField: $('#searchField').val()};
	$.ajax({	        
		type: 'post',
        url: '../jhBoard/QSelectCount.json',
        data: params,
        dataType: 'json',
        success: function(data) {
        	str = '<h8 class="head"> &nbsp; &nbsp; 총 Q&A 게시물 수 : ' + data['totalCount'] + '</h8>'
            $('#totalCount').html(str);
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
}
					
function searchList(pageNum) {
	if(pageNum == null) {
		pageNum = 1;
	}
	const params = {searchWord: $('#searchWord').val(), searchField: $('#searchField').val(), listNum: $('#listNum').val(), pageNum: pageNum};
    $.ajax({
        type: 'post',
        url: '../jhBoard/QSearch.json',
        data: params,
        dataType: 'json',
        success: function(data) {
        	str ='';
        	for(item of data) {
        		str += '<tr align="center"><td width ="10%">' + item['num'] + '</td><td width ="10%">' + item['postdate'] + '</td><td width ="10%">' + item['nickname'] + '</td><td width ="*">' + '<a href="../jhBoard/qView.do?num=' + item.num +'">' + item['title'] + '</a>' + '</td><td width ="10%">' + item['visitCount'] +'</td></tr>';      	
        	}
        	$('#boardList').html(str);
        	getCount();
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
    page(pageNum, $('#searchWord').val(), $('#searchField').val());
}

function page(pageNum, searchWord, searchField) {	
	if(pageNum == null) {
		pageNum = 1;
	}
	const params = {listNum : $('#listNum').val(), pageNum : pageNum, searchWord : searchWord, searchField : searchField};
	$.ajax({
	    type: 'post',
	    url: '../jhBoard/Qpage.json', 
	    data: params,
	    dataType: 'json',
	    success: function(data) {
	    	str = '<ul class="pagination justify-content-center">';
	    	if(data['isBPrev']) {
				let prevBPage = data['endPage'] - data['blockNum'];
				str += '<li class="page-item"><a class="page-link" href="#" onclick="searchList(' + prevBPage + ')">‹‹</a></li>';
			}
	    	if(data['isPrev']) {
				let prevPage = data['pageNum'] - 1;
				str += '<li class="page-item"><a class="page-link" href="#" onclick="searchList(' + prevPage + ')">‹</a></li>';
			}
	        for(i= data['startPage']; i<=data['endPage']; i++) {
	        	if(i == data['pageNum']) str += '<li class="page-item"><a class="page-link active" href="#" ';
	        	else str += '<li class="page-item"><a class="page-link" href="#" ';
				str += 'onclick="searchList(' + i + ')">' + i + '</a></li>';
	        }
	        if(data['isNext']) {
	        	let nextPage = data['pageNum'] + 1;
				str += '<li class="page-item"><a class="page-link" href="#" onclick="searchList(' + nextPage + ')">›</a></li>';
			}
			if(data['isBNext']) {
	        	let nextBPage = data['startPage'] + data['blockNum'];
	        	str += '<li class="page-item"><a class="page-link" href="#" onclick="searchList(' + nextBPage + ')">››</a></li>';
			}
			
			$('#pageList').html(str);
		  	
	    },
	    error: function(xhr, status, error) {
	        console.log(xhr, status, error);
	    }
	});
}

function write() {  
	str = '${id}';
	if(str != '') {
		$('#writeTable').show();
	}
}
	
window.onload = function () {
	getCount();
	searchList(1);	
	$('#writeTable').hide();
	write();
}

$(function() {  
	$('#searchBtn').on('click', function() {
		searchList();
	});	
});
</script>
</head>
<body>
<%@ include file="../home/topmenu.jsp" %>
<h5 class="head">&nbsp; Q&A 게시판 - 목록</h5>
<div id="totalCount"></div>
	&nbsp; <table border="1" width="90%">
	<tr align="center" >
		<th width="10%">번호</th>
		<th width="10%">날짜</th>
		<th width="10%">이름</th>
		<th width="*">제목</th>
		<th width="10%">조회수</th>
	</tr>
		<tbody id="boardList"></tbody>
	</table>
	<div>
		&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
		&nbsp; &nbsp; &nbsp; <select id="listNum" class="border"
			onclick="searchList()">
			<option value="10">10개씩보기</option>
			<option value="15">15개씩보기</option>
			<option value="20">20개씩보기</option>
		</select>
	</div>
	<nav aria-label="..." id="pageList" class="border"></nav>
	<table>	
<tr align="center">
	<td>
		<input type="button" value="글쓰기" class="border" id="writeTable" onclick="location.href='qWrite.do'">
	</td>
</tr>
</table>	
<table border ="1" width="90%" class="table table-striped" class="table-info">
	<tr class="table-info">
		<td align ="center" class="table-danger">
			<select id="searchField" class="table-danger">
				<option value ="title">제목</option>
				<option value ="nickname">닉네임</option>
			</select>
			<input type ="text" id="searchWord" class="table-danger">
			<input type ="button" value="검색하기" id="searchBtn" class="table-info">		
		</td>
	</tr>
	</table>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
</body>
</html>