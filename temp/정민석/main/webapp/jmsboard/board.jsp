<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="stylesheet" type="text/css" href="../css/board_css.css">
 <!-- <link rel="stylesheet" type="text/css" href="../css/reset.css"> -->
<title>board</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- 이건 write 작성할때 로그인 되어있는지 확인 -->

<script>

function serch(serchWord,serchField) {
    $.ajax({
        type: 'POST',
        url: 'serch.json',
        data:{serchWord:serchWord,serchField:serchField},
        dataType: 'json',
        success: function(data) {
        	console.log(data);
        	let boardLists=data['boardLists'];
        	let pageNum=data['pageNum'];
        	let pageSize=data['pageSize'];
        	let totalCount=data['totalCount'];
        	let totalPage=data['totalPage'];
        	let blockPage=data['blockPage'];
        	let uri=data['uri'];
        	let td="목록 보기(List) - 현재 페이지 : "+pageNum+" (전체 : "+totalPage+")";
        	$('#h2').html(td);
        	let tr="";
        	if(boardLists.length===0){
        		tr+="<td colspan=\"5\" align=\"center\">등록된 게시물이 없습니다.</td>";
        	}else{
        		console.log(boardLists);
        		let virtualNum=0;
        	 	let countNum =0;
        	 	$.each(boardLists,function(index,dto){
        	 		virtualNum = totalCount-(((pageNum-1)*pageSize)+countNum++);
        	 		tr+="<tr><td>"+virtualNum +"</td><td align=\"left\">";
        	 		tr+="<a href=\"View.jsp?num="+dto['num']+"\">"+dto['title']+"</a>";
        	 		tr+="</td><td align=\"center\">"+dto['id']+ "</td>";
        	 		tr+="</td><td align=\"center\">"+dto['visitCount']+ "</td>";
        	 		tr+="</td><td align=\"center\">"+dto['postdate']+ "</td></tr>";
        	 	})
        	 		
         	}
	       $('#boardLists').html(tr);
        	page(totalCount,pageSize,blockPage,pageNum,uri);
		},
        	error: function(xhr, status, error) {
            	console.log(xhr, status, error);
      	 }
    });
};
 function writeBtn() {
		$.ajax({
	        type: 'POST',
	        url: 'writeJson.json',
	        dataType: 'json',
	        success: function(data) {
	        	console.log("id : " + id);
	        	console.log("data : " + data);
	        	console.log("data['rs'] : " + data['rs']);
	        	if (data['rs'] === 1) {
	        		location.href = 'write.jsp';
	        	}
				else {
					alert("게시글을 작성하려면 로그인을 먼저 하셔야됩니다");
					location.href = 'login.jsp'
				};
	        }, error: function(xhr, status, error) {
	        	console.log(xhr, status, error);
	        }
		});
	};
	function page(totalCount, pageSize, blockPage, pageNum,uri) {
		const param={totalCount:totalCount,pageSize:pageSize,blockPage:blockPage
				,pageNum:pageNum,uri:uri};
		$.ajax({
		      type: 'POST',
		      url: 'page.json',
		      dataType: 'json',
		      data: param,
		      success: function(data) {
		      		let tr="";
		      		if(data['pagingStr']===""){
		      			tr="";
		      		}else{		      			
		      		    console.log(data['pagingStr']);
		      			tr+=data['pagingStr'];
		      		}
		      		$('#bp').html(tr);
		        }, error: function(xhr, status, error) {
		        	console.log(xhr, status, error);
		        }
			});
		};
	$(function() {
		serch();
		$('#serch').on("click",function() {		
		const serchWord=$('#serchWord').val();
		const serchField =$('#serchField').val();
		console.log(serchField);
		serch(serchWord,serchField);
		});
		$('#b_writeBtn').click(function() {
			writeBtn();
		});
	});
	
</script>
</head>
<%@include file="../home/topmenu.jsp" %>
<body>
	<h1>OO 게시판</h1>
	<form action="write">
		<div class="board_box">
			<div>
				<div>
					<select  id="serchField">
						<option value="title">제목</option>
						<option value="context">내용</option>
						<option value="nickname">작성자</option>
					</select>
					<input type="text"  id="serchWord">
					<input type="button" value="검색하기" id="serch">
				</div>
			</div>
		
			<table class="table_ul" border="1">
	         	<thead>
	                <tr class="tul_th">
	                    <td class="th_span th_num">번호</td>
	                    <td class="th_span">제목</td>
	                    <td class="th_span">작성자</td>
	                    <td class="th_span">조회수</td>
	                    <td class="th_span">작성일</td>
	                </tr>
	             </thead>
	            <tbody id="boardLists"></tbody>
	        </table>
		 <table>
 	<tr align="center">
 		<td id="bp"></td>
 		<td>
 			<button type="button" onclick="location.href='write.do'">글쓰기</button>
 		</td>
 	</tr>
 </table>
	
	</form>
</body>
</html>







