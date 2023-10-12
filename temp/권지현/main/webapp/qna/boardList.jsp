<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 게시판</title>

<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<script>
function getQnaBoard() {
	const grade = '<%=session.getAttribute("grade")%>';
    $.ajax({
        type: 'POST',
        url: 'qnaBoardList.json',
        dataType: 'json',
        success: function(data) {
            let tr = '';
            for (item of data) {
            	if (item['num'] === 0) {
	        		alert('조회되는 게시글이 없습니다.');
	        		location.href = 'index.do';
	        	}
            	$('#board').show();
                const {num, title, nickname, visitCount, postdate} = item;
                tr += '<tr style="text-align: center;"><td>' + num + '</td><td><a href="qnaBoardView.do?num=' + num + '" onclick="loginCheck();">'
                + title + '</a></td><td>' + nickname + '</td><td>' + visitCount + '</td><td>' + postdate + '</td>'
                if (grade !== 'GENERAL') tr += '<td id="delete"><a href="deleteBoard.do?num=' + num + '" onclick="deleteBoard();">삭제</td></tr>';
	            else tr += '</tr>';
            }
            $('#tbody').html(tr);
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function getQnaBoardTitle(param) {
	const grade = '<%=session.getAttribute("grade")%>';
    $.ajax({
        type: 'POST',
        url: 'qnaBoardListTitle.json',
        dataType: 'json',
        data: param,
        success: function(data) {
	    	let tr = '';
	        for (item of data) {
	        	if (item['num'] === 0) {
	        		alert('조회되는 게시글이 없습니다.');
	        		return;
	        	}
	        	const {num, title, nickname, visitCount, postdate} = item;
                tr += '<tr style="text-align: center;"><td>' + num + '</td><td><a href="qnaBoardView.do?num=' + num + '" onclick="loginCheck();">'
                + title + '</a></td><td>' + nickname + '</td><td>' + visitCount + '</td><td>' + postdate + '</td>'
                if (grade !== 'GENERAL') tr += '<td id="delete"><a href="deleteBoard.do?num=' + num + '" onclick="deleteBoard();">삭제</td></tr>';
	            else tr += '</tr>';
	        }
	        $('#tbody').html(tr);
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function getQnaBoardContext(param) {
	const grade = '<%=session.getAttribute("grade")%>';
    $.ajax({
        type: 'POST',
        url: 'qnaBoardListContext.json',
        dataType: 'json',
        data: param,
        success: function(data) {
	    	let tr = '';
	        for (item of data) {
	        	if (item['num'] === 0) {
	        		alert('조회되는 게시글이 없습니다.');
	        		return;
	        	}
	        	const {num, title, nickname, visitCount, postdate} = item;
                tr += '<tr style="text-align: center;"><td>' + num + '</td><td><a href="qnaBoardView.do?num=' + num + '" onclick="loginCheck();">'
                + title + '</a></td><td>' + nickname + '</td><td>' + visitCount + '</td><td>' + postdate + '</td>'
                if (grade !== 'GENERAL') tr += '<td id="delete"><a href="deleteBoard.do?num=' + num + '" onclick="deleteBoard();">삭제</td></tr>';
	            else tr += '</tr>';
	        }
	        $('#tbody').html(tr);
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function getQnaBoardNickname(param) {
	const grade = '<%=session.getAttribute("grade")%>';
    $.ajax({
        type: 'POST',
        url: 'qnaBoardListNickname.json',
        dataType: 'json',
        data: param,
        success: function(data) {
	    	let tr = '';
	        for (item of data) {
	        	if (item['num'] === 0) {
	        		alert('조회되는 게시글이 없습니다.');
	        		return;
	        	}
	        	const {num, title, nickname, visitCount, postdate} = item;
                tr += '<tr style="text-align: center;"><td>' + num + '</td><td><a href="qnaBoardView.do?num=' + num + '" onclick="loginCheck();">'
                + title + '</a></td><td>' + nickname + '</td><td>' + visitCount + '</td><td>' + postdate + '</td>'
                if (grade !== 'GENERAL') tr += '<td id="delete"><a href="deleteBoard.do?num=' + num + '" onclick="deleteBoard();">삭제</td></tr>';
	            else tr += '</tr>';
	        }
	        $('#tbody').html(tr);
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function loginCheck() {
	if (<%=session.getAttribute("id")%> === null) {
		alert('회원만 볼 수 있는 게시글입니다.')
		$('a').attr('href', 'login.do');
	}
};

function deleteBoard() {
	const input = confirm('해당 게시물을 삭제합니까?');
	if (!(input)) location.replace('qnaBoardList.do');
};

$(function() {
	$('#board').hide();
	getQnaBoard();
	$('#search').click(function() {
		const context = $('#context').val();
		if (context === '') {
			alert('검색어를 입력해주세요.');
			return;
		}
		else if ($('#select').val() === 'title') {
			const param = {title : context};
			getQnaBoardTitle(param);
		} else if ($('#select').val() === 'context') {
			const param = {context};
			getQnaBoardContext(param);
		} else if ($('#select').val() === 'nickname') {
			const param = {nickname : context};
			getQnaBoardNickname(param);
		}
	});
});
</script>
<%-- <script src="./script/memberlist.js"></script> --%>
</head>
<body>
<%@include file="../home/topmenu.jsp" %>
<h2>Q&A 게시판</h2>
<hr>
	<form id="board">
		<div>
			<div>
				<div>
					<select id="select">
						<option value="title">제목</option>
						<option value="context">내용</option>
						<option value="nickname">작성자</option>
					</select>
					<input type="text" id="context">
					<input type="button" value="검색하기" id="search">
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
						<c:if test="${grade != 'GENERAL'}">
						<th>&nbsp</th>
						</c:if>
					</tr>
				</thead>
				<tbody id="tbody">
						
				</tbody>
			</table>
		</div>
	<div style="float: right;"><input type="button" value="글쓰기" id="write"></div>
	</form>
</body>
</html>