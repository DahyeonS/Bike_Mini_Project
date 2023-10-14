<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
<style>
	textarea {
	width:600px;
	height:50px;
	text-align: initial;
	}
	#rcontext {text-align: left;}
	#rpostdate {
		font-size: 12pt;
		text-align: right;
		font-style: italic;
	}
	#rdelete {
		font-size: 12pt;
		text-align: right;
	}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<script>
function deleteProcess() {
const num=${dto.num};
	$.ajax({
        type: 'POST',
        url: 'DeleteProcess.json',
        dataType: 'json',
        data: {num:num},
        success: function(data) {
        	if(data['delResult']===0){
        		alert("삭제에 실패했습니다");
        		location.href="View.do?num="+num;
        	}else{
        		alert("삭제되었습니다");
        		location.href="board.do";
        	}
        }, error: function(xhr, status, error) {
        	console.log(xhr, status, error);
        }
	});
};
function deletePost(){
	const confirmed=confirm("정말로 삭제하겠습니까?");
	if(confirmed){
		deleteProcess();
	}
}

function getReplyView(num) {
	const param = {num};
    $.ajax({
        type: 'POST',
        url: 'ReplyView.json',
        dataType: 'json',
        data: param,
        success: function(data) {
        	if (data['list'][0]['num'] !== 0) {
	        	let string = '';
	        	for (item of data['list']) {
	        		string += '<tr><td id="rnickname">' + item['nickname'] + '님&nbsp&nbsp&nbsp</td><td id="rcontext">' + item['context'] + '</td></tr><tr><td id="rpostdate">' + item['postdate'] + '</td>';
	        		if (data['nickname'] === item['nickname']) string += '<td id="rdelete"><a href="#" onclick="deleteReply(' + item['num'] + ');">삭제</td></tr><tr><td>&nbsp</td></tr>';
	        		else string += '</tr>';
	        	}
	        	$('#replylist' + num).html(string);
	        	$('#replies').show();
        	}
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function writeReply(num) {

	const context = $('#reply' + num).val();
	
	if (context === '') alert('내용을 입력해주세요.');
	else {
		const params = {num, context};
		console.log(params);
	    $.ajax({
	        type: 'POST',
	        url: 'WriteReply.json',
	        dataType: 'json',
	        data: params,
	        success: function(data) {
	        	if(data['rs']===0){
	        		alert('로그인이 필요합니다');
	        		location.href='../member/login.do';
	        	}else if(data['rs'] !== 0) {
	                alert('댓글이 작성되었습니다.');
	                location.href = '../jmsboard/View.do?num=' + ${dto.num}+'&index='+${index};
	            }
	        },
	        error: function(xhr, status, error) {
	            console.log(xhr, status, error);
	        }
	    });
	}
};

function deleteReply(num) {
    $.ajax({
        type: 'POST',
        url: 'DeleteReply.json',
        dataType: 'json',
        data: {num:num},
        success: function(data) {
            if(data['rs'] === 1) {
                alert('게시글이 삭제되었습니다.');
                location.href = '../jmsboard/View.do?num=' + ${dto.num}+'&index='+${index};
            } else alert('죄송합니다. 다시 시도해주세요.');
        }, error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

		$(function() {
			$('#replies').hide();
			const num=${dto.num};
			getReplyView(num);
		});

</script>
</head>
<body>

<%@include file="../home/topmenu.jsp" %>
<h2>회원제 게시판 - 상세 보기</h2>
<form name="writeFrm">
	<table border="1" width="90%">
		<tr>
			<td>번호</td>
			<td>${index }</td>
			<td>작성자</td>
			<td>${dto.nickname }</td>
		</tr>
		<tr>
			<td>작성일</td>
			<td>${dto.postdate }</td>
			<td>조회수</td>
			<td>${dto.visitCount }</td>
		</tr>
		<tr>
			<td>제목</td>
			<td colspan="3">${dto.title }</td>
		</tr>
		<tr>
			<td>내용</td>
			<td colspan="3" height="100">
			${dto.context }
			</td>
		</tr>
	<c:if test="${not empty dto.fileName }">
		<tr>
			<td>파일</td>
			<td colspan="2">${dto.fileName }</td>
			<td><a href="download.do?sfile=${dto.fileName }">[다운로드]</a></td>
		</tr>
	</c:if>
	<c:choose>
		<c:when test="${id eq dto.id or admin eq OK and not empty id}">	
		
			<tr>
			<td colspan="4" align="center">
					<button type="button" onclick="location.href='Edit.do?num=${dto.num}&index=${index }';">
						수정하기
					</button>
					<button type="button" onclick="deletePost();">
						삭제하기
					</button>
					<button type="button" onclick="location.href='board.do';">
						목록보기
					</button>
			</td>
			</tr>
		
		</c:when>	
		<c:otherwise>
			<tr>			
			<td colspan="4" align="center"><button type="button" onclick="location.href='board.do';">
						목록보기
			</button></td>
			</tr>
		</c:otherwise>	
	</c:choose>
	</table>
<div id="replies">
	<table id="replylist${dto.num}">
	</table>
		<br><br><br>
</div>
	<table>
		<tr>
			<td>${dto.nickname}님</td>
			<td>&nbsp&nbsp<textarea id="reply${dto.num}"></textarea>&nbsp&nbsp</td>
			<td><input type="button" value="댓글 작성" onclick="writeReply(${dto.num});"></td>
		<tr>
	</table>
</form>
</body>
</html>