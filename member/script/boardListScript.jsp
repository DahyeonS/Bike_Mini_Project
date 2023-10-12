<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
function pagingBoard(param) {
	$.ajax({
        type: 'POST',
        url: 'memberPagingBoard.json',
        dataType: 'json',
        data: param,
        success: function(data) {
        	const {blockNum, endPage, isBNext, isBPrev, isNext, isPrev, listNum, pageNum, startPage, totalCount, totalPage} = data;
        	let tr = '<tr><td colspan="6">';
			if(isPrev) tr += '<a href="#" onclick="getBoard('+ (pageNum - 1) + ');">[<]</a>';
            if(isBPrev) tr += '<a href="#" onclick="getBoard('+ (startPage - 1) + ');">[<<]</a>';
			for(let i=startPage; i<=endPage; i++) {
				if(i === pageNum) tr += '<span style="color:red;">['+ i + ']</span>';
				else tr += '<a href="#" onclick="getBoard(' + i + ');">['+ i +']</a>';
			};
			if(isNext) tr += '<a href="#" onclick="getBoard(' + (pageNum + 1) + ');">[>]</a>';
			if(isBNext) tr += '<a href="#" onclick="getBoard(' + (endPage + 1) + ');">[>>]</a></td></tr>';
            $('#paging').html(tr);
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function getBoard(page) {
	const id = '<%=session.getAttribute("id")%>';
	
	let title, context, category;
	if ($('#select').val() === 'title') {
		title = $('#context').val();
	} else if ($('#select').val() === 'context') {
		context = $('#context').val();
	}
	
	if ($('#category').val() === 'normal') {
		category = 'normal';
	} else if ($('#category').val() === 'question') {
		category = 'question';
	} else if ($('#category').val() === 'answer') {
		category = 'answer';
	} else if ($('#category').val() === 'reply') {
		category = 'reply';
	} else if ($('#category').val() === 'novel') {
		category = 'novel';
	} else if ($('#category').val() === 'free') {
		category = 'free';
	} else if ($('#category').val() === 'photo') {
		category = 'photo';
	}
	
	let search = false;
	if (title === '' && context === undefined && category === undefined) search = true;
	
	const param = {id, page, title, context, category};
	$.ajax({
        type: 'POST',
        url: 'memberBoardList.json',
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
                const {num, title, category, visitCount, postdate} = item;
                tr += '<tr style="text-align: center;"><td>' + num + '</td><td><a href="#" onclick="loginCheck();">'
                	+ title + '</a></td><td>' + category + '</td><td>' + visitCount + '</td><td>' + postdate + '</td>'
                	+ '<td><a href="#" onclick="deleteBoard(' + num + ');">삭제</td></tr>';
            }
            $('#tbody').html(tr);
            pagingBoard(param);
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function deleteMemberBoard(param) {
    $.ajax({
        type: 'POST',
        url: 'memberDeleteBoard.json',
        dataType: 'json',
        data: param,
        success: function(data) {
            if(data['rs'] === 1) {
                alert('게시글이 삭제되었습니다.');
                location.href = '../member/boardList.do';
            } else alert('죄송합니다. 다시 시도해주세요.');
        }, error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function loginCheck() {
	if (<%=session.getAttribute("id")%> === null) {
		alert('세션이 만료되었습니다.')
		$('a').attr('href', '../member/login.do');
	}
};

function deleteBoard(num) {
	const input = confirm('해당 게시글을 삭제합니까?');
	if (input) {
		const param = {num};
		deleteMemberBoard(param);
	} else return;
};

$(function() {
	$('#board').hide();
	const sPage = '<%=request.getParameter("page")%>'
	let page = 1;
	if (sPage !== 'null') page = sPage;
	getBoard(page);
	$('#search').click(function() {
		const context = $('#context').val();
		if (context === '') {
			alert('검색어를 입력해주세요.');
		} else getBoard(page);
	});
	$('#context').keydown(function(event) {
    	if (event.keyCode === 13) {
    		location.href = '#';
    		const context = $('#context').val();
    		if (context === '') {
    			alert('검색어를 입력해주세요.');
    		} else getBoard(page);
    		return;
    	}
    });
	$('#category').on('change', function() {
		getBoard(page);
	});
});
</script>