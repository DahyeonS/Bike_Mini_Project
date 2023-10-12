<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 	<link rel="stylesheet" type="text/css" href="./css/view.css">
  <script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
 <script>
 
 <% String id = (String)session.getAttribute("id"); %>
	function ViewJson() {
		<%String num2 = request.getParameter("num");
		int num = Integer.parseInt(num2);
		%>
		const num = "<%=num%>";
		$.ajax({
	        type: 'POST',
	        url: '../novel/viewJson.json',
	        dataType: 'text',
	        data: {num:num},
	        success: function(r) {
	        	const result = JSON.parse(r);
	        	const nickname = result.nickname;
	        	const title = result.title;
	        	const context = result.context;
	        	const postdate = result.postdate;
	        	const count = result.visitCount;
	        	 
        			$('#title').html(title);
        			$('.date').html(postdate);
        			$('#m_id').html(nickname);
        			$('#context').html(context);
	        		$('.count').html(count);
        			
	        }, error: function(xhr, status, error) {
	        	console.log(xhr, status, error);
	        }
		});
	};
	function deleteJson() {
		<%String n = request.getParameter("num2");
		int numCh = Integer.parseInt(n);
		%>
		const num_2 = "<%=numCh%>";
		console.log("nuk : "+ num_2);
		$.ajax({
	        type: 'POST',
	        url: '../novel/deleteJson.json',
	        dataType: 'json',
	        data: {num:num_2},
	        success: function(data) {
	        	console.log("data : " + data);
	        	console.log("data['rs'] : " + data['rs']);
	        	if (data['rs'] === 1) {
	        		location.href = 'board.do';
	        		alert("삭제 됬습니다아아~");
	        	}
				else {
					alert("삐빠");
					/* location.href = 'login.do' */
				};        			
	        }, error: function(xhr, status, error) {
	        	console.log(xhr, status, error);
	        }
		});
	};
	$(function() {
		ViewJson();
		<% String idCh2 = request.getParameter("id"); %>
			const id = "<%=id%>";
			console.log("id : " + id);
			
		setTimeout(function(){
			const idCh = $('#m_id').text();
			console.log("idCh : " + idCh);
		},100);
		
		const idCh2 = "<%=idCh2%>";
		console.log("idCh2 : " + idCh2);
		
		if (id !== idCh2) {
	        $('.modify_btn, .delete_btn').click(function(event) {
	            event.preventDefault(); // 클릭 이벤트의 기본 동작을 막음
	            alert("작성하신 글이 아니시므로 삭제하거나 수정할 수 없습니다");
	        });
	    } else {
	    	$('.delete_btn').click(function(){
	    		 const num = "<%=num%>"; // 여기서 num을 가져옴
	             deleteJson(num);
			})
			$('.modify_btn').click(function(){
				<%String n3 = request.getParameter("num3");
				int nCh = Integer.parseInt(n3);
				%>
				const num_3 = "<%=nCh%>";
			    const newURL = '../novel/updateBoard.jsp?num='+num_3+'&num2='+num_3 ; // 새로운 파라미터 추가
			    /* alert("newURL: " + newURL); */
			    location.href = newURL; // 새로운 URL로 이동
			})
	    }
	});
	function count() {
		<%String n6 = request.getParameter("num6");
		int nCh6 = Integer.parseInt(n6);
		%>
		const num_6 = "<%=nCh6%>";
		console.log("nuk : "+ num_6);
		$.ajax({
	        type: 'POST',
	        url: '../novel/count.json',
	        dataType: 'text',
	        data: {num:num_6},
	        success: function(r) {
	        	console.log("r : "+ r);
	        	
	        	if(typeof r != "undefined") {
	        		console.log("웅웅");
	        	}else {
	        		alert("잘못되셨습니다");
	        	}
	        }, error: function(xhr, status, error) {
	        	console.log(xhr, status, error);
	        }
		});
	};
	function prevJson() {
		<%String n4 = request.getParameter("num4");
		int nCh4 = Integer.parseInt(n4);
		%>
		const num_4 = "<%=nCh4%>";
		console.log("nuk : "+ num_4);
		$.ajax({
	        type: 'POST',
	        url: '../nevel/prevJson.json',
	        dataType: 'text',
	        data: {num:num_4},
	        success: function(r) {
	        	const result = JSON.parse(r);
	        	const id = result.id;
	        	const num = result.num;
	        	
	        	if (num != num_4) {
    				location.href = 'view.jsp?num='+num+'&id='+id+'&num2='+num+'&num3='+num+'&num4='+num+'&num5='+num+'&num6='+ num +'';
    				/* alert("location : "+ 'view.jsp?num='+num+'&id='+id+'&num2='+num+'&num3='+num+'&num4='+num+'&num5='+num+'&num6='+ num +''); */
	        	}
				else if(num == num_4) {
					alert("더이상 넘어가실 수 없습니다. 첫번째 게시글입니다");
				};        			
	        }, error: function(xhr, status, error) {
	        	console.log(xhr, status, error);
	        }
		});
	};
	function nextJson() {
		<%String n5 = request.getParameter("num5");
		int nCh5 = Integer.parseInt(n5);
		%>
		const num_5 = "<%=nCh5%>";
		console.log("nuk : "+ num_5);
		$.ajax({
	        type: 'POST',
	        url: '../novel/nextJson.json',
	        dataType: 'text',
	        data: {num:num_5},
	        success: function(r) {
	        	const result = JSON.parse(r);
	        	const id = result.id;
	        	const num2 = result.num;
	        	console.log("num 다음페이지 :" + num2);
	        	
	        	if (num2 != num_5 && num2 !== 0) {
    				location.href = 'view.jsp?num='+num2+'&id='+id+'&num2='+num2+'&num3='+num2+'&num4='+num2+'&num5='+num2+'&num6='+ num2 +'';
    				/* alert("location : "+ 'view.jsp?num='+num2+'&id='+id+'&num2='+num2+'&num3='+num2+'&num4='+num2+'&num5='+num2+'&num6='+ num2 +''); */
	        	}
				else if(num2 === 0) {
					alert("더이상 넘어가실 수 없습니다. 마지막 게시글입니다");
				};        			
	        }, error: function(xhr, status, error) {
	        	console.log(xhr, status, error);
	        }
		});
	};
	
	$(function(){
		$('#prev').click(function(){
			prevJson();
		})
		$('#next').click(function(){
			nextJson();
		})
		count();
		
		
		<%String search = request.getParameter("search");%>
		const agree = "<%=search%>";
		console.log("agree : "+ agree);
		if(agree == "t") {
			$('.pe_neBtn_box').hide();
		}
		
		/* $('#m_id').click(function(){
			const getNick = $('#m_id').text();
			console.log("getNick : "+ getNick);
		}) */
	})
 </script>
 
<title>view</title>
</head>
<%@include file="../home/topmenu.jsp" %>
<body>
	 <div class="wrap" id="wrap">
	 	<form action="write"> 
	        <div class="title_box">
	            <h2 class="title" id="title"></h2>
	            <div class="date_box">
	                <div class="date"></div>
	                <div class="member">
	                    <div id="m_id"></div>
	                	<div class="count_box">조회수 : <div class="count"></div></div>
                   </div>
	            </div>
	        </div>
	        <div class="main">
	            <div class="text_box" id="context"></div>
	        </div>
	        <div class="footer_box">
	            <div class="pe_neBtn_box">
	                <div class="nextBtn btn">
	                    <a href="#" id="next">◀ NEXT</a>
	                </div>
	                <div class="prevBtn btn">
	                    <a href="#" id="prev">PREV ▶</a>
	                </div>
	            </div>
	            <div class="list_box">
	               <div class="listBtn btn">
	                   <a href="../novel/board.do">목록</a>
	               </div>
                  <input type="button" value="수정하기" class="modify_btn btn">
                  <input type="button" value="삭제하기" class="delete_btn btn">
	           </div>
	        </div>
	    </form> 
	 </div>
</body>
</html>