<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문 게시판</title>
<style>
	form, h2 {text-align: center;}
	table, th, td, input, select {
		margin: 0 auto;
		border-collapse: collapse;
		font-size: 14pt;
	}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<script>
function getQBoard() {
    $.ajax({
        type: 'POST',
        url: 'qBoardList.json',
        dataType: 'json',
        success: function(data) {
            let tr = '';
            for (item of data) {
                const {num, title, nickname, visitCount, postdate} = item;
                tr += '<tr style="text-align: center;"><td>' + num + '</td><td><a href="boardView.do">' + title + '</a></td><td>' + nickname
                + '</td><td>' + visitCount + '</td><td>' + postdate + '</td></tr>';
                
            }
            $('#tbody').html(tr);
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

$(function() {
	getQBoard();
});
</script>
<%-- <script src="./script/memberlist.js"></script> --%>
</head>
<body>
<%@include file="../home/topmenu.jsp" %>
<h2>질문 게시판</h2>
<hr>
	<form>
		<div>
			<div>
				<div>
					<select>
						<option>제목</option>
						<option>내용</option>
						<option>작성자</option>
					</select>
					<input type="text">
					<input type="button" value="검색하기">
				</div>
			</div>
			<table border="1">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>조회수</th>
						<th>작성일</th>
					</tr>
				</thead>
					<tbody id="tbody">
				</tbody>
			</table>
		</div>
	<div><input type="button" value="글쓰기"></div>
	</form>
</body>
</html>