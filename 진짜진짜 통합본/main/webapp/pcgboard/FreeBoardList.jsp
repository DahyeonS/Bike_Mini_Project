<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="stylesheet" type="text/css" href="./css/board_css.css">
<title>pcg 게시판 목록</title>
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<script >

function getJson(){
    $.ajax({
      //contentType: 'application/json',
      type: 'POST',
      url: 'boardListData.json',
      dataType: 'json',
      success: function(data) {
    	console.log(data); 
        innerHtml(data);
      },
      error: function(xhr, status, error) {
        console.log(xhr, status, error);
      }
    });
}

function innerHtml(data){
let tr = ''; 
	for(item of data){
		const {num,id,nickname,title,category,fileID,fileName,postdate,visitCount} = item;
			
		tr += '<tr><td><h4>' + num + '</h4></td>'
		tr += '<td width="50%"><h4><a href=PcgView.do?num=' + num + '>' + title + '</a></h4></td>'
		tr += '<td><h4>' + nickname + '</h4></td>'
		tr += '<td width="10%"><h4>' + visitCount + '</h4></td>'
		tr += '<td><h4>'+postdate+'</h4></td></tr>'

    }	
	console.log(tr);
    $('tbody').html(tr);
}

function searchJson(param){
	
	const title = $("#title").val();
     //console.log(jname); 
    $.ajax({
      //contentType: 'application/json',
      type: 'post',
      url: 'boardListSearchData.json',
      dataType: 'json',
      data: {title}, 
      success: function(data) {
      	console.log(data);
        innerHtml(data);
    	  
      },
      error: function(xhr, status, error) {
        console.log(xhr, status, error);
      }
    });
}
	

</script>
</head>
<body>
<%@include file="../home/topmenu.jsp" %>

<h1>pcg 테스트 링크 페이지 입니다.</h1>

<form action="">
<table border="2">
<thead>
<tr><td colspan="6" ><center><h1> 게시판 목록 </h1></center></td></tr>
<tr>
<th colspan="1" >제목 :</th>
<td><input type="text" name="title" id="title" style="width : 90%;" ></td>
<td colspan="1"><input type="button" value="검색"  onclick ='searchJson()' ></td>
<td colspan="1"><input type="button" value="전체목록"  onclick ='getJson()' ></td>
<td colspan="1" ><input type="button" value="글 쓰기"  onclick="location.href='../pcgboard/PcgWrite.do';" ></td>
</tr>

<tr>
<td ><h3> 게시글 번호 </h3></td>
<td ><h3> 게시글명 </h3></td>
<td><h3> 작성자 닉네임 </h3></td>
<td><h3> 방문자 수</h3></td>
<td><h3> 작성일자 </h3></td>
</tr>
</thead>

<tbody>
<!-- 
<tr>
<td><input type="button" value="이전페이지" id="checkbutton" onclick ="getjson(-1)"></td>
<td colspan =4><input type="button" value="전체목록" id="checkbutton" onclick ="getJson()"></td>
<td><input type="button" value="다음페이지" id="checkbutton" onclick ="getjson(+1)"></td>
</tr>
 -->
</tbody>

</table>
</form>


</body>
</html>