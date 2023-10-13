<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
function getQnaBoardView() {
	const num = '<%=request.getParameter("num")%>';
	const param = {num};
    $.ajax({
        type: 'POST',
        url: 'qnaBoardView.json',
        dataType: 'json',
        data: param,
        success: function(data) {
        	$('title').html(data['title']);
        	$('#title').html(data['title']);
        	$('#context').html(data['context']);
        	$('#nickname').html("작성자 " + data['nickname']);
        	$('#postdate').html("작성일자 " + data['postdate']);
        	if (data['updateDate'] !== "0") $('#updatedate').html("수정일자 " + data['updateDate']);
        	$('#visitcount').html("조회수 " + data['visitCount']);
        	let string = '';
        	if (('<%=session.getAttribute("nickname")%>' === data['nickname'] || '<%=session.getAttribute("grade")%>' !== 'GENERAL') && data['nickname'] !== '관리자') string += '<input type="button" value="삭제하기" onclick="deleteBoard(' + data['num'] + ');" style="float: right;">';
    		if ('<%=session.getAttribute("nickname")%>' === data['nickname']) string += '<input type="button" value="수정하기" onclick="updateBoard(' + data['num'] + ');" style="float: right;">';
    		$('.control').html(string);
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function getQnaAnswerView() {
	const num = '<%=request.getParameter("num")%>';
	const param = {num};
    $.ajax({
        type: 'POST',
        url: 'qnaAnswerView.json',
        dataType: 'json',
        data: param,
        success: function(data) {
        	if (data[0]['num'] !== 0) {
	        	let string = '';
	        		for (item of data) {
		        		string += '<br><br><h2>' + item['title'] + '</h2><hr><h4 id="anickname">작성자 ' + item['nickname'] + '</h4><h4 id="apostdate">작성일자 ' + item['postdate'] + '</h4>';
		        		if (item['updateDate'] !== "0") string += '<h4 id="aupdatedate">수정일자 ' + item['updateDate'] + '</h4>';
		        		string += '<h3 id="acontext">' + item['context'] + '</h3>';
		        		if (('<%=session.getAttribute("nickname")%>' === data['nickname'] || '<%=session.getAttribute("grade")%>' !== 'GENERAL') && item['nickname'] !== '관리자') string += '<input type="button" value="삭제하기" onclick="deleteAnswer(' + item['num'] + ');" style="float: right;">';
		        		if ('<%=session.getAttribute("nickname")%>' === item['nickname']) string += '<input type="button" value="수정하기" onclick="updateBoard(' + item['num'] + ');" style="float: right;">';
		        		getQnaReplyView(item['num']);
		        		string += '<br><br><br><br><div class="replies"><table id="replylist' + item['num'] + '"></table>'
		        		string += '<br><br><br><table><tr><td>${nickname}님</td><td>&nbsp&nbsp<textarea id="reply' + item['num'] + '"></textarea>&nbsp&nbsp</td><td><input type="button" value="댓글 작성" onclick="writeReply(' + item['num'] + ');"></td><tr></table>';
	        		}
				$('.answerlist').html(string);
				$('.answer').show();
				getQnaReplyView(item['num']);
        	}
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function qnaDeleteBoard(param) {
    $.ajax({
        type: 'POST',
        url: 'qnaDeleteBoard.json',
        dataType: 'json',
        data: param,
        success: function(data) {
            if(data['rs'] !== 0) {
                alert('게시글이 삭제되었습니다.');
                location.href = '../qna/qnaBoardList.do';
            } else alert('죄송합니다. 다시 시도해주세요.');
        }, error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function qnaDeleteAnswer(param) {
	const num = '<%=request.getParameter("num")%>';
    $.ajax({
        type: 'POST',
        url: 'qnaDeleteBoard.json',
        dataType: 'json',
        data: param,
        success: function(data) {
            if(data['rs'] === 1) {
                alert('게시글이 삭제되었습니다.');
                location.href = '../qna/qnaBoardView.do?num=' + num;
            } else alert('죄송합니다. 다시 시도해주세요.');
        }, error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function writeReply(num) {
	const id = '<%=session.getAttribute("id")%>';
	const nickname = '<%=session.getAttribute("nickname")%>';
	const context = $('#reply' + num).val();
	
	if (context === '') alert('내용을 입력해주세요.');
	else {
		const params = {id, num, nickname, context};
		console.log(params);
	    $.ajax({
	        type: 'POST',
	        url: 'qnaWriteReply.json',
	        dataType: 'json',
	        data: params,
	        success: function(data) {
	        	if(data['rs'] !== 0) {
	                alert('댓글이 작성되었습니다.');
	                location.href = '../qna/qnaBoardView.do?num=' + ${param.num};
	            } else alert('다시 시도해주세요.');
	        },
	        error: function(xhr, status, error) {
	            console.log(xhr, status, error);
	        }
	    });
	}
};

function getQnaReplyView(num) {
	const param = {num};
    $.ajax({
        type: 'POST',
        url: 'qnaReplyView.json',
        dataType: 'json',
        data: param,
        success: function(data) {
        	if (data[0]['num'] !== 0) {
	        	let string = '';
	        	for (item of data) {
	        		string += '<tr><td id="rnickname">' + item['nickname'] + '님&nbsp&nbsp&nbsp</td><td id="rcontext">' + item['context'] + '</td></tr><tr><td id="rpostdate">' + item['postdate'] + '</td>';
	        		if ('<%=session.getAttribute("nickname")%>' === item['nickname']) string += '<td id="rdelete"><a href="#" onclick="deleteReply(' + item['num'] + ')">삭제</td></tr><tr><td>&nbsp</td></tr>';
	        		else string += '</tr>';
	        	}
	        	$('#replylist' + num).html(string);
	        	$('.replies').show();
        	}
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function qnaDeleteReply(param) {
	const num = '<%=request.getParameter("num")%>';
    $.ajax({
        type: 'POST',
        url: 'qnaDeleteReply.json',
        dataType: 'json',
        data: param,
        success: function(data) {
            if(data['rs'] === 1) {
                alert('게시글이 삭제되었습니다.');
                location.href = '../qna/qnaBoardView.do?num=' + num;
            } else alert('죄송합니다. 다시 시도해주세요.');
        }, error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function updateBoard(update) {
	const num = '<%=request.getParameter("num")%>';
	if (num == update) location.href = '../qna/qnaWrite.do?update=' + update;
	else location.href = '../qna/qnaWrite.do?update=' + update + '&num=' + num;
};

function deleteBoard(num) {
	const input = confirm('해당 게시글을 삭제합니까?');
	if (input) {
		const param = {num};
		qnaDeleteBoard(param);
	} else return;
};

function deleteAnswer(num) {
	const input = confirm('해당 게시글을 삭제합니까?');
	if (input) {
		const param = {num};
		qnaDeleteAnswer(param);
	} else return;
};

function deleteReply(num) {
	const input = confirm('해당 댓글을 삭제합니까?');
	if (input) {
		const param = {num};
		qnaDeleteReply(param);
	} else return;
};

$(function() {
	$('.answer').hide();
	getQnaBoardView();
	getQnaAnswerView();
	
	$('.replies').hide();
	const num = '<%=request.getParameter("num")%>';
	getQnaReplyView(num);
	
	$('#list').click(function() {
		location.href = '../qna/qnaBoardList.do';
	});
	$('#write').click(function() {
		location.href = '../qna/qnaWrite.do';
	});
	$('#answer').click(function() {
		location.href = '../qna/qnaWrite.do?num=<%=request.getParameter("num")%>';
	});
});
</script>