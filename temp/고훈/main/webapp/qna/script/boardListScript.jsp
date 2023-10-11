<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
function getQnaBoard() {
	const grade = '<%=session.getAttribute("grade")%>';
	const id = '<%=session.getAttribute("id")%>';
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
                tr += '<tr style="text-align: center;"><td>' + num + '</td><td><a href="../qna/qnaBoardView.do?num=' + num + '" onclick="loginCheck();">'
                + title + '</a></td><td>' + nickname + '</td><td>' + visitCount + '</td><td>' + postdate + '</td>'
                if (id !== 'null' && grade !== 'GENERAL') tr += '<td><a href="#" onclick="deleteBoard(' + num + ');">삭제</td></tr>';
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
	const id = '<%=session.getAttribute("id")%>';
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
                tr += '<tr style="text-align: center;"><td>' + num + '</td><td><a href="../qna/qnaBoardView.do?num=' + num + '" onclick="loginCheck();">'
                + title + '</a></td><td>' + nickname + '</td><td>' + visitCount + '</td><td>' + postdate + '</td>'
                if (id !== 'null' && grade !== 'GENERAL') tr += '<td><a href="#" onclick="deleteBoard(' + num + ');">삭제</td></tr>';
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
	const id = '<%=session.getAttribute("id")%>';
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
                tr += '<tr style="text-align: center;"><td>' + num + '</td><td><a href="../qna/qnaBoardView.do?num=' + num + '" onclick="loginCheck();">'
                + title + '</a></td><td>' + nickname + '</td><td>' + visitCount + '</td><td>' + postdate + '</td>'
                if (id !== 'null' && grade !== 'GENERAL') tr += '<td><a href="#" onclick="deleteBoard(' + num + ');">삭제</td></tr>';
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
	const id = '<%=session.getAttribute("id")%>';
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
                tr += '<tr style="text-align: center;"><td>' + num + '</td><td><a href="../qna/qnaBoardView.do?num=' + num + '" onclick="loginCheck();">'
                + title + '</a></td><td>' + nickname + '</td><td>' + visitCount + '</td><td>' + postdate + '</td>'
                if (id !== 'null' && grade !== 'GENERAL') tr += '<td><a href="#" onclick="deleteBoard(' + num + ');">삭제</td></tr>';
	            else tr += '</tr>';
	        }
	        $('#tbody').html(tr);
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function deleteBoardAdmin(param) {
    $.ajax({
        type: 'POST',
        url: 'qnaDeleteBoard.json',
        dataType: 'json',
        data: param,
        success: function(data) {
            if(data['rs'] === 1) {
                alert('게시글이 삭제되었습니다.');
                location.href = '../qna/qnaBoardList.do';
            } else alert('죄송합니다. 다시 시도해주세요.');
        }, error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function loginCheck() {
	if (<%=session.getAttribute("id")%> === null) {
		alert('회원만 볼 수 있는 게시글입니다.')
		$('a').attr('href', '../member/login.do');
	}
};

function deleteBoard(num) {
	const input = confirm('해당 게시글을 삭제합니까?');
	if (input) {
		const param = {num};
		deleteBoardAdmin(param);
	} else return;
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
	$('#write').click(function() {
		if ('<%=session.getAttribute("id")%>' === 'null') {
			alert('회원만 작성할 수 있습니다.')
			location.href = '../member/login.do';
		} else location.href = '../qna/qnaWrite.do';
	});
});
</script>