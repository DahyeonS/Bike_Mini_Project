<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
function pagingQnaBoard(param) {
	$.ajax({
        type: 'POST',
        url: 'qnaBoardPaging.json',
        dataType: 'json',
        data: param,
        success: function(data) {
        	const {blockNum, endPage, isBNext, isBPrev, isNext, isPrev, listNum, pageNum, startPage, totalCount, totalPage} = data;
        	let tr = '<tr><td colspan="6" class="paging">';
			if(isPrev) tr += '<a href="#" onclick="getQnaBoard('+ (pageNum - 1) + ');">[<]</a>';
            if(isBPrev) tr += '<a href="#" onclick="getQnaBoard('+ (startPage - 1) + ');">[<<]</a>';
			for(let i=startPage; i<=endPage; i++) {
				if(i === pageNum) tr += '<span style="color:rgb(255, 170, 120);;">['+ i + ']</span>';
				else tr += '<a href="#" onclick="getQnaBoard(' + i + ');">['+ i +']</a>';
			};
			if(isNext) tr += '<a href="#" onclick="getQnaBoard(' + (pageNum + 1) + ');">[>]</a>';
			if(isBNext) tr += '<a href="#" onclick="getQnaBoard(' + (endPage + 1) + ');">[>>]</a></td></tr>';
            $('#paging').html(tr);
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function getQnaBoard(page) {
	const grade = '<%=session.getAttribute("grade")%>';
	const id = '<%=session.getAttribute("id")%>';
	
	let title, context, nickname;
	if ($('.select').val() === 'title') {
		title = $('#context').val();
	} else if ($('.select').val() === 'context') {
		context = $('#context').val();
	} else if ($('.select').val() === 'nickname') {
		nickname = $('#context').val();
	}
	let search = false;
	if (title === '' && context === undefined && nickname === undefined) search = true;
	
	const param = {page, title, context, nickname};
	console.log(param);
    $.ajax({
        type: 'POST',
        url: 'qnaBoardList.json',
        dataType: 'json',
        data: param,
        success: function(data) {
            let tr = '';
            for (item of data) {
            	if (item['num'] === 0) {
	        		alert('조회되는 게시글이 없습니다.');
	        		if (search) location.href = 'index.do';
	        		else return;
	        	}
            	$('#board').show();
                const {num, title, nickname, visitCount, postdate} = item;
                tr += '<tr style="text-align: center;"><td class="num">' + num + '</td><td class="title"><a href="../qna/qnaBoardView.do?num=' + num;
                if (param['title'] !== '' && param['title'] !== undefined) tr += '&title=' + param['title'];
                else if (param['context'] !== undefined) tr += '&context=' + param['context'];
                else if (param['nickname'] !== undefined) tr += '&nickname=' + param['nickname'];
                tr += '" onclick="loginCheck();">' + title + '</a></td><td class="nickname">' + nickname + '</td><td class="count">' + visitCount + '</td><td class="date">' + postdate + '</td>'
                if ((id !== 'null' && grade !== 'GENERAL' && item['nickname'] !== '관리자') || grade === 'MANAGER') tr += '<td class="control"><a href="#" onclick="deleteBoard(' + num + ');" id="delete">삭제</td></tr>';
                else if (id !== 'null' && grade !== 'GENERAL') tr += '<td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td></tr>';
	            else tr += '</tr>';
            }
            $('#tbody').html(tr);
            pagingQnaBoard(param);
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
	const sPage = '<%=request.getParameter("page")%>'
	let page = 1;
	if (sPage !== 'null') page = sPage;
	getQnaBoard(page);
	$('#search').click(function() {
		const context = $('#context').val();
		if (context === '') {
			alert('검색어를 입력해주세요.');
		} else getQnaBoard(page);
	});
	$('#context').keydown(function(event) {
    	if (event.keyCode === 13) {
    		event.preventDefault();
    		const context = $('#context').val();
    		if (context === '') {
    			alert('검색어를 입력해주세요.');
    			return;
    		} else getQnaBoard(page);
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