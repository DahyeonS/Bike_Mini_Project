<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
function getQnaWriteView(param) {
    $.ajax({
        type: 'POST',
        url: 'qnaWriteView.json',
        dataType: 'json',
        data: param,
        success: function(data) {
        	$('#qtitle').html(data['title']);
        	$('#qcontext').html(data['context']);
        	$('#nickname').html(data['nickname']);
        	$('#postdate').html("작성일자: " + data['postdate']);
        	if (data['updateDate'] !== '0') $('#updatedate').html("수정일자: " + data['updateDate']);
        	$('.question').show();
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function qnaWrite(num) {
	const id = '<%=session.getAttribute("id")%>';
	const nickname = '<%=session.getAttribute("nickname")%>';
	const title = $('#title').val();
	const context = $('#context').val();
	const params = {num, id, nickname, title, context};
    $.ajax({
        type: 'POST',
        url: 'qnaWrite.json',
        dataType: 'json',
        data: params,
        success: function(data) {
        	if(data['rs'] !== 0) {
                alert('게시글이 작성되었습니다.');
                location.href = '../qna/qnaBoardView.do?num=' + data['rs'];
            } else alert('다시 시도해주세요.');
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function getQnaUpdateView(param) {
    $.ajax({
        type: 'POST',
        url: 'qnaUpdateView.json',
        dataType: 'json',
        data: param,
        success: function(data) {
        	$('#title').attr('value', data['title']);
        	$('#context').html(data['context']);
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function qnaUpdate(update, num) {
	const title = $('#title').val();
	const context = $('#context').val();
	const params = {update, num, title, context};
	console.log(params);
    $.ajax({
        type: 'POST',
        url: 'qnaUpdate.json',
        dataType: 'json',
        data: params,
        success: function(data) {
        	if(data['rs'] !== 0) {
                alert('게시글이 수정되었습니다.');
                location.href = '../qna/qnaBoardView.do?num=' + data['rs'];
            } else alert('다시 시도해주세요.');
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

$(function() {
	$('.question').hide();
	let num = <%=request.getParameter("num")%>
	let update = <%=request.getParameter("update")%>
	if (num !== null) {
		$('title').html('답변 작성');
		const param = {num};
		getQnaWriteView(param);
	}
	if (update !== null) {
		$('title').html('게시글 수정');
		const param = {update};
		getQnaUpdateView(param);
	}
	$('#cancel').click(function() {
		const input = confirm('작성을 취소합니까?');
		if (input) history.back();
		else return;
	});
	$('#submit').click(function() {
		if ($('#title').val() === '') alert('제목을 입력하세요');
		else if ($('#context').val() === '') alert('내용을 입력하세요');
		else {
			if (num == null) num = 0;
			qnaWrite(num);
		}
	});
	$('#update').click(function() {
		if ($('#title').val() === '') alert('제목을 입력하세요');
		else if ($('#context').val() === '') alert('내용을 입력하세요');
		else {
			if (num == null) num = 0;
			qnaUpdate(update, num);
		}
	});
});
</script>