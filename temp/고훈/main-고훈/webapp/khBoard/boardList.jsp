<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
<script src="script/sendAjax.js"></script>
<script>
	let totalCount;
	function getCount () {
	   
		sendAjax('selectCount.json').then( (data) => {
			totalCount =  data['totalCount'];
        	str = '총 ' + data['totalCount'] + ' 개의 게시물';
            $('#totalCount').html(str);
		})
	}
	
	function boardList (page) {
		const params = {posts_per_page: $('#posts_per_page').val(), page: page};
		sendAjax('boardList.json', params).then( (data) => {
			str = '<thead><tr><th style="width: 1.09741550695825%; text-align: center;">번호</th>';
			str += '<th style="width: 40.47713717693837%; text-align: center">제목</th>';
			str += '<th style="width: 3.302186878727635%; text-align: center">닉네임</th>';
			str += '<th style="width: 9.72962226640159%; text-align: center">작성일자</th></tr></thead>';
        	for(item of data) {
        		str += '<tr><td style="width: 1.09741550695825%; text-align: center;">' + item['num'] + '</td>';
        		str += '</td><td class="title" style="width: 40.47713717693837%;">' + '<a class="nav-link" href="#" onclick="aClick(' + item.num + ');">' + item['title'] + '</a>';
        		str += '</td><td class="nickname" style="text-align: center;">' + item['nickname'];
        		str += '</td><td class="postdate" style="text-align: center;">' + item['postdate'] + '</td></tr>';
        	}
        	$('#boardList').html(str);
		})
	}
	
	function searchList (page) {
		
    	const params = {searchWord: $('#searchWord').val(), searchField: $('#searchField').val(), posts_per_page: $('#posts_per_page').val(), page: page};
    	sendAjax('searchList.json', params).then( (data) => {
    		str = '<tr><td class="num">번호</td><td class="title">제목</td><td class="nickname">닉네임</td><td class="postdate">작성 날짜</td></tr>';
        	for(item of data) {
        		str = '<thead><tr><th style="width: 1.09741550695825%; text-align: center;">번호</th>';
    			str += '<th style="width: 40.47713717693837%; text-align: center">제목</th>';
    			str += '<th style="width: 3.302186878727635%; text-align: center">닉네임</th>';
    			str += '<th style="width: 9.72962226640159%; text-align: center">작성일자</th></tr></thead>';
            	for(item of data) {
            		str += '<tr><td style="width: 1.09741550695825%; text-align: center;">' + item['num'] + '</td>';
            		str += '</td><td class="title" style="width: 40.47713717693837%;">' + '<a class="nav-link" href="#" onclick="aClick(' + item.num + ');">' + item['title'] + '</a>';
            		str += '</td><td class="nickname" style="text-align: center;">' + item['nickname'];
            		str += '</td><td class="postdate" style="text-align: center;">' + item['postdate'] + '</td></tr>';
            	}
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
		boardList (1);
		$('#write').hide();
		write ();
	}
	
	$(function name() {  // 실행시 자동으로 실행
		$('#searchBtn').on('click', function() {
			searchList(1);
		});

	});
	
</script>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<%@ include file="../home/topmenu.jsp" %>
<div class="card mb-4">
	<div class="card-header">
		<h3>일반 게시글 목록</h3>
	</div>
	<div class="card-body">
		<div class="datatable-wrapper datatable-loading no-footer sortable searchable fixed-columns">
			<div class="datatable-top row">
	    		<div class="datatable-dropdown col-sm-8">
	            	<label>
	                	<select class="datatable-selector" id="posts_per_page"><option value="5">5</option><option value="10" selected="">10</option><option value="15">15</option><option value="20">20</option><option value="25">25</option></select> 페이지 당 게시물 수
	            	</label>
	       		</div>
	    		<div class="datatable col-sm-4">
	    			<div class="row ">
	                	<div class="col-sm-auto"><select class="datatable-selector" id="searchField"><option value="title">제목</option><option value="nickname">닉네임</option></select></div>
	            		<div class="col"><input class="datatable-input" id="searchWord" placeholder="검색하기" type="search" title="Search within table" aria-controls="datatablesSimple"></div>
	            		<div class="col-sm-auto"><input class="btn btn-secondary" id="searchBtn" type="button" value="검색"></div>
	       			</div>
	       		</div>
			</div>
			<div class="datatable-container d-grid">
				<table id="boardList" class="datatable-table"></table>
			</div>
			<div class="datatable-bottom">
	   			<div class="datatable-info" id="totalCount"></div>
				<div class="" id="write"><input class="btn btn-secondary" id="searchBtn" type="button" value="글쓰기" onclick="location.href ='boardWrite.jsp'"></div>
			</div>
			<div>
	   			<nav class="datatable-pagination ">
	   				<ul class="datatable-pagination-list justify-content-center">
	   					<li class="datatable-pagination-list-item datatable-hidden datatable-disabled"><a data-page="1" class="datatable-pagination-list-item-link">‹</a></li>
	   					<li class="datatable-pagination-list-item"><a data-page="1" class="datatable-pagination-list-item-link" onclick="searchList(1)">1</a></li>
	   					<li class="datatable-pagination-list-item"><a data-page="2" class="datatable-pagination-list-item-link" onclick="searchList(2)">2</a></li>
	   					<li class="datatable-pagination-list-item"><a data-page="3" class="datatable-pagination-list-item-link" onclick="searchList(3)">3</a></li>
	   					<li class="datatable-pagination-list-item"><a data-page="4" class="datatable-pagination-list-item-link" onclick="searchList(4)">4</a></li>
	   					<li class="datatable-pagination-list-item"><a data-page="5" class="datatable-pagination-list-item-link" onclick="searchList(5)">5</a></li>
	   					<li class="datatable-pagination-list-item"><a data-page="6" class="datatable-pagination-list-item-link" onclick="searchList(6)">6</a></li>
	   					<li class="datatable-pagination-list-item"><a data-page="2" class="datatable-pagination-list-item-link">›</a></li>
   					</ul>
				</nav>
			</div>
		</div>
	</div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="script/scripts.js"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
<script src="script/datatables-simple-demo.js"></script>
</body>
</html>