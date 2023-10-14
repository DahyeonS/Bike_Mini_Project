<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
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
		const params = {searchWord: $('#searchWord').val(), searchField: $('#searchField').val()};
		sendAjax('selectCount.json', params).then( (data) => {
			totalCount =  data['totalCount'];
        	str = '총 ' + data['totalCount'] + ' 개의 게시물';
            $('#totalCount').html(str);
            
		})
	}

	function searchList (pageNum) {
		
    	const params = {searchWord: $('#searchWord').val(), searchField: $('#searchField').val(), listNum: $('#listNum').val(), pageNum: pageNum};
    	sendAjax('searchList.json', params).then( (data) => {
    		str = '<tr><td class="num">번호</td><td class="title">제목</td><td class="nickname">닉네임</td><td class="postdate">작성 날짜</td></tr>';
        	for(item of data) {
        		console.log(data);
        		str = '<thead><tr><th style="width: 2%; text-align: center;">번호</th>';
    			str += '<th style="width: 40%; text-align: center">제목</th>';
    			str += '<th style="width: 3%; text-align: center">닉네임</th>';
    			str += '<th style="width: 9%; text-align: center">작성일자</th>';
    			str += '<th style="width: 3%; text-align: center">조회수</th></tr></thead>';
            	for(item of data) {
            		str += '<tr><td style="width: 2%; text-align: center;">' + item['num'] + '</td>';
            		str += '</td><td class="title" style="width: 40%;">' + '<a class="nav-link" href="#" onclick="aClick(' + item.num + ');">' + item['title'] + '</a>';
            		str += '</td><td class="nickname" style="text-align: center;">' + item['nickname'];
            		str += '</td><td class="postdate" style="text-align: center;">' + item['postdate'];
            		str += '</td><td class="postdate" style="text-align: center;">' + item['visit_count'] + '</td></tr>';
            	}
            	$('#boardList').html(str);
       
        	}
        	pagingBtns(pageNum, $('#searchWord').val(), $('#searchField').val());
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
		$('#write').hide();
		str = '${id}';
		console.log(str);
		if(str != '') {
			$('#write').show();
		}
	}
	function pagingBtns(pageNum, searchWord, searchField) {
		if(pageNum == null) pageNum = 1;
		const params = {listNum : $('#listNum').val(), pageNum : pageNum, searchWord : searchWord, searchField : searchField};
		sendAjax('pagingBtns.json', params).then( (data) => {
			console.log(data);
			let str;
        	str = '총 ' + data['totalCount'] + ' 개의 게시물';
            $('#totalCount').html(str);
            
			str = '<ul class="pagination justify-content-center" >';
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
			$('#pageBtns').html(str);
		})

	}

	window.onload = function() {
		getCount ();
		searchList (1);
		write ();
	}
	
	$(function name() {  // 실행시 자동으로 실행
		$('#searchBtn').on('click', function() {
			searchList(1);
			getCount ();
		});

	});
	

	
</script>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<%@ include file="../home/topmenu.jsp" %>
	<div class="container text-center">
		<div class="row justify-content-md-center">
			<div class="col col-lg-2"></div>
			<div class="card mb-4 border-light">
				<div class="card-header ">
					<h3>일반 게시판</h3>
				</div>
				<div class="card-body">
					<div class="datatable-wrapper datatable-loading no-footer sortable searchable fixed-columns">
						<div class="datatable-top row">
							<div class="datatable-dropdown-end col-sm-8">
								<div style="float:left;">
								<label> 
									<select class="datatable-selector" id="listNum" onchange="searchList(1)">
										<option value="5">5</option>
										<option value="10" selected>10</option>
										<option value="15">15</option>
										<option value="20">20</option>
										<option value="25">25</option></select>   페이지 당 게시물 수
								</label>
								</div>
							
							</div>
							<div class="datatable col-sm-4">
								<div class="row " id="pagingBtns">
									<div class="col-sm-auto">
										<select class="datatable-selector" id="searchField">
											<option value="title">제목</option>
											<option value="nickname">닉네임</option>
										</select>
									</div>
									<div class="col">
										<input class="datatable-input" id="searchWord"
											placeholder="검색하기" type="search" title="Search within table"
											aria-controls="datatablesSimple">
									</div>
									<div class="col-sm-auto">
										<input class="btn btn-secondary" id="searchBtn" type="button"
											value="검색">
									</div>
								</div>
							</div>
						</div>
						<div class="datatable-container d-grid">
							<table id="boardList" class="datatable-table"></table>
						</div>
						<div class="datatable-bottom">
							<div class="datatable-info" id="totalCount"></div>
							<div class="" id="write">
								<input class="btn btn-secondary" id="searchBtn" type="button"
									value="글쓰기" onclick="location.href ='boardWrite.jsp'">
							</div>
						</div>
						<div>
							<nav aria-label="Page navigation example" id="pageBtns"></nav>
						</div>
					</div>
				</div>
			</div>
			<div class="col col-lg-2"></div>
		</div>
	</div>


	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
</body>
</html>