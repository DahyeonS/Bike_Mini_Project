<%@page import="novel.NovelDAOImpl"%>
<%@page import="novel.NovelDTO"%>
<%@page import="java.util.List"%>
<%@page import="novel.PagingDTO"%>
<%@page import="novel.NovelDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="stylesheet" type="text/css" href="./css/board_css.css?after">
<title>board</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- 이건 write 작성할때 로그인 되어있는지 확인 -->

<script>
function getBoardJson() {
	<%
	request.setCharacterEncoding("utf-8");

	int listNum = 5;
	int blockNum = 5;
	int pageNum = 1;
	if(request.getParameter("page") != null){
		pageNum = Integer.parseInt(request.getParameter("page"));
	};	
	
	NovelDAO dao = new NovelDAOImpl();
	List<NovelDTO> list = dao.getPostList(pageNum, listNum);
	int totalCount = dao.getMemberCount();
%>
<%	
	//paging
	PagingDTO paging = new PagingDTO(totalCount, pageNum, listNum, blockNum);
	paging.setPaging();	
	
	int totalPage = paging.getTotalPage();
	int startPage = paging.getStartPage();
	int endPage = paging.getEndPage();
	boolean isPrev = paging.isPrev();
	boolean isNext = paging.isNext();
	boolean isBPrev = paging.isBPrev();
	boolean isBNext = paging.isBNext();
%>
	
	const pageNum = <%=pageNum%>;
	const listNum = <%=listNum%>;
	const option = $("#search_select option:selected").val();
 	const text = $('#b_search').val();
	const param = {option:option, text:text, pageNum:pageNum, listNum:listNum};
	$.ajax({
        type: 'GET',
        url: '../novel/board.json',
        dataType: 'json',
        data: param,
        success: function(data) {
            let tr = '';
            for (item of data) {
                const {id, num, nickname, title, postdate, visit_count} = item;
				console.log("item : "+ item);
               tr += '<tr style="text-align: center;" class="tr">' +
               	'<td class="tul_span"><a href="view.jsp?num='+ num +'&id='+ id +'&num2='+ num +'&num3='+ num +'&num4='+ num +'&num5='+ num +'&num6='+ num +'">' + num + '</a></td>' +
                   '<td class="tul_span"><a href="view.jsp?num='+ num +'&id='+ id +'&num2='+ num +'&num3='+ num +'&num4='+ num +'&num5='+ num +'&num6='+ num +'">' + title + '</a></td>' +
                   '<td class="tul_span"><a href="view.jsp?num='+ num +'&id='+ id +'&num2='+ num +'&num3='+ num +'&num4='+ num +'&num5='+ num +'&num6='+ num +'">' + nickname + '</a></td>' +
                   '<td class="tul_span"><a href="view.jsp?num='+ num +'&id='+ id +'&num2='+ num +'&num3='+ num +'&num4='+ num +'&num5='+ num +'&num6='+ num +'">' + postdate + '</a></td></tr>';
            }
            $('#tbody').html(tr); // 이 줄을 사용하여 데이터를 추가합니다.
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

$(function() {
    getBoardJson();
    
});
</script>

<script>
<% String id = (String)session.getAttribute("id"); %>

 function writeBtn() {
	 	const id = "<%=id%>";
		const param = {id:id};
		$.ajax({
	        type: 'POST',
	        url: '../member/idCheck.json',
	        dataType: 'json',
	        data: param,
	        success: function(data) {
	        	console.log("id : " + id);
	        	console.log("data : " + data);
	        	console.log("data['rs'] : " + data['rs']);
	        	if (data['rs'] === 1) {
	        		location.href = '../novel/write.jsp';
	        	}else {
        		 	alert("게시글을 작성하려면 로그인을 먼저 하셔야됩니다");
	 	            location.href = '../member/login.do';
	        	}
	        }, error: function(xhr, status, error) {
	        	console.log(xhr, status, error);
	        }
		});
	};
	
	function searchBtn() {
	
		const pageNum = 1;
		const listNum = <%=listNum%>;
	 	const option = $("#search_select option:selected").val();
	 	const text = $('#b_search').val();
		const param = {option:option, text:text, pageNum:pageNum, listNum:listNum};
		
		$.ajax({
	        type: 'GET',
	        url: '../novel/searchBtn.json',
	        dataType: 'json',
	        data: param,
	        success: function(r) {
	        	let tr = '';
	        	$('#tbody').empty();
	            for (item of r) {
	                const {id, num, nickname, title, postdate, visit_count} = item;
					console.log("item : "+ item);
	               tr += '<div style="text-align: center;">' +
	               	'<div class="tul_span"><a href="view.jsp?num='+ num +'&id='+ id +'&num2='+ num +'&num3='+ num +'&num4='+ num +'&num5='+ num +'&num6='+ num +'&search=t">' + num + '</a></div>' +
	                   '<div class="tul_span"><a href="view.jsp?num='+ num +'&id='+ id +'&num2='+ num +'&num3='+ num +'&num4='+ num +'&num5='+ num +'&num6='+ num +'&search=t">' + title + '</a></div>' +
	                   '<div class="tul_span"><a href="view.jsp?num='+ num +'&id='+ id +'&num2='+ num +'&num3='+ num +'&num4='+ num +'&num5='+ num +'&num6='+ num +'&search=t">' + nickname + '</a></div>' +
	                   '<div class="tul_span"><a href="view.jsp?num='+ num +'&id='+ id +'&num2='+ num +'&num3='+ num +'&num4='+ num +'&num5='+ num +'&num6='+ num +'&search=t">' + postdate + '</a></div></div>';
	            }
	            $('#tbody').html(tr); // 이 줄을 사용하여 데이터를 추가합니다.
	        	
	        	
	        }, error: function(xhr, status, error) {
	        	console.log(xhr, status, error);
	        }
		});
	}; 
	function searchCount() {
		
		const pageNum = <%=pageNum%>;
		const listNum = <%=listNum%>;
	 	const option = $("#search_select option:selected").val();
	 	const text = $('#b_search').val();
		const param = {option:option, text:text, pageNum:pageNum, listNum:listNum};
		
		console.log("pageNum : "+ pageNum);
		console.log("listNum : "+ listNum);
		
		$.ajax({
	        type: 'GET',
	        url: '../novel/searchCount.json',
	        dataType: 'json',
	        data: param,
	        success: function(r) {
	        	let {totalCount,totalPage, startPage, endPage, isPrev, isNext, isBPrev, isBNext,text,option} = r;
	        	console.log("r  : "+ r);
	        	let div = '';
	        	
        		if(isBPrev) div += '<a href="../novel/board.jsp?page=' + (startPage-1)+'">&nbsp;<<&nbsp;</a>';
				if(isPrev)div+='<a href="../novel/board.jsp?page='+ (pageNum -1) +'">&nbsp;<&nbsp;</a>';
				
				for(let i=startPage; i<=endPage; i++) {
					if(i == pageNum) {
						div+='<span style="color:red;">&nbsp;'+i+'&nbsp;</span>';
					}else{
						div+='<a href="../novel/board.jsp?page='+i+'">&nbsp;'+i+'&nbsp;</a>';
					}
				}
				
				if(isNext)div+='<a href="../novel/board.jsp?page='+(pageNum+1)+'">&nbsp;>&nbsp;</a> ';
				if(isBNext)div+='<a href="../novel/board.jsp?page='+(endPage+1)+'">&nbsp;>>&nbsp;</a>';
				
				$('.pageBtn2').html(div);
				
				
	        	
	        }, error: function(xhr, status, error) {
	        	console.log(xhr, status, error);
	        }
		});
	};  
	
	
	$(function() {
		$('#b_writeBtn').click(function() {
			writeBtn();
			const id = "<%=id%>";
			console.log("id : " + id);
			
			if (id === null || id.trim() === '') {
	            alert("게시글을 작성하려면 로그인을 먼저 하셔야됩니다");
	            location.href = 'login.do';
	        }
			
		});
		
		$("#b_search").keypress(function(e){
			//검색어 입력 후 엔터키 입력하면 조회버튼 클릭
			if(e.keyCode && e.keyCode == 13){
				$("#b_searchBtn").trigger("click");
				return false;
			}
			//엔터키 막기
			if(e.keyCode && e.keyCode == 13){
				  e.preventDefault();	
			}
		});
		
		$('#b_searchBtn').on("click",function(){
			$('.pageBtn').hide();
			searchBtn();
			searchCount();
		})
		<%-- $('.pageBtn').click(function(){
			<%
				int pageN = Integer.parseInt(request.getParameter("page"));
				String opt = request.getParameter("opt");
				String input = request.getParameter("text");
			%>
				const clickedPage = <%=pageN%>;
			    const opt = "<%=opt%>";
			    const text = "<%=input%>";
			    console.log("opt : "+ opt);
			    console.log("text : "+ text);

			    $('#search_select option:selected').val(opt);
			    $('#b_search').val(text);

			    searchBtn();
			    searchCount();
		}) --%>
			});
	
	window.onpageshow = function(event) {
	    if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) {
	    	setTimeout(function(){
		        $('.b_searchBtn').trigger("click");
			    searchBtn();
	    	},100);
	    }
	}
	
</script>
</head>
<%@include file="../home/topmenu.jsp" %>
<body>
	<h1>
		<a href="../novel/board.jsp">소설 게시판</a>
		<span class="sub">게시글 : <%=pageNum%> / <%=totalPage %> (<%=totalCount %>)</span>
	</h1>
	<form action="write">
		<div class="board_box">
			<div>
				<div>
					<select id="search_select">
						<option value="nu">기본</option>
						<option value="title">제목</option>
						<option value="context">내용</option>
						<option value="user">작성자</option>
					</select>
					<input type="text" name="b_search" value="" id="b_search">
					<input type="button" value="검색하기" id="b_searchBtn" onclick="searchBtn()">
				</div>
			</div>
		
			<div class="table">
				<div class="thead">
			        <div class="tul_th">
			            <div class="th_span th_num">번호</div>
			            <div class="th_span">제목</div>
			            <div class="th_span">작성자</div>
			            <div class="th_span">작성일</div>
			        </div>
			    </div>
	            <div id="tbody">
	               <!--  <tr>
	                    <td class="tul_span"><a href="view.jsp">0</a></td>
	                    <td class="tul_span"><a href="view.jsp">게시글 한번 써보고 싶었어요 ㅎㅎ</a></td>
	                    <td class="tul_span"><a href="view.jsp">test1</a></td>
	                    <td class="tul_span"><a href="view.jsp">1</a></td>
	                    <td class="tul_span"><a href="view.jsp">2023-04-03</a></td> 
	                </tr> -->
	                
	            </div>
	        </div>
		
		 
			<div class="pageBtn">
				<%if(isBPrev){ %> <a href="../novel/board.jsp?page=<%=startPage-1%>&text=<c:out value="${text}"/>&opt=<c:out value="${option}"/>">&nbsp;<<&nbsp;</a> <%} %>
				<%if(isPrev){ %> <a href="../novel/board.jsp?page=<%=pageNum-1%>&text=<c:out value="${text}"/>&opt=<c:out value="${option}"/>">&nbsp;<&nbsp;</a> <%} %>
				
				<%for(int i=startPage; i<=endPage; i++) {%>
					<%if(i == pageNum) {%>
						<span style="color:red;">&nbsp;<%=i %>&nbsp;</span>
					<%}else{%>
						<a href="../novel/board.jsp?page=<%=i%>&text=<c:out value="${text}"/>&opt=<c:out value="${option}"/>">&nbsp;<%=i %>&nbsp;</a>
					<%} %>
				<%}%>
				
				<%if(isNext){ %> <a href="../novel/board.jsp?page=<%=pageNum+1%>&text=<c:out value="${text}"/>&opt=<c:out value="${option}"/>">&nbsp;>&nbsp;</a> <%} %>
				<%if(isBNext){ %> <a href="../novel/board.jsp?page=<%=endPage+1%>&text=<c:out value="${text}"/>&opt=<c:out value="${option}"/>">&nbsp;>>&nbsp;</a> 
				<%}%>
			</div>
			<div class="pageBtn2"></div>
			<div><input type="button" value="글쓰기" id="b_writeBtn"></div>
		</div>
	</form>
</body>
</html>







