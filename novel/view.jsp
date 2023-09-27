<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="stylesheet" type="text/css" href="../css/view.css">
  <script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
 <script>
 <% String id = (String)session.getAttribute("id"); %>

 function modifyBtn() {
	 	const id = "<%=id%>";
		const param = {id:id};
		$.ajax({
	        type: 'POST',
	        url: 'viewJson.json',
	        dataType: 'json',
	        data: param,
	        success: function(data) {
	        	console.log("id : " + id);
	        	console.log("data : " + data);
	        	console.log("data['rs'] : " + data['rs']);
	        	if (data['rs'] === 1) {
	        		location.href = 'write.do';
	        	}
				else {
					alert("게시글을 수정하려면 로그인을 먼저 하셔야됩니다");
					location.href = 'login.do'
				};
	        }, error: function(xhr, status, error) {
	        	console.log(xhr, status, error);
	        }
		});
	};
	
	
	function ViewJson() {
		<%String num2 = request.getParameter("num");
		int num = Integer.parseInt(num2);
		%>
		const num = "<%=num%>";
		$.ajax({
	        type: 'POST',
	        url: 'viewJson.json',
	        dataType: 'json',
	        data: {num:num},
	        success: function(data) {
	        	 console.log("data : " + JSON.stringify(data));
	        	 
        			$('#title').html(data['title']);
        			$('.date').html(data['postdate']);
        			$('#m_id').html(data['nickname']);
        			$('#context').html(data['context']);
        			
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
	        url: 'deleteJson.json',
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
	            alert("작성하신 글이 아니시므로 삭제할 수 없습니다");
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
	function prevJson() {
		<%String n4 = request.getParameter("num4");
		int nCh4 = Integer.parseInt(n4);
		%>
		const num_4 = "<%=nCh4%>";
		console.log("nuk : "+ num_4);
		$.ajax({
	        type: 'POST',
	        url: 'prevJson.json',
	        dataType: 'json',
	        data: {num:num_4},
	        success: function(data) {
	        	console.log("data : " + data);
	        	console.log("data['rs'] : " + data['rs']);
	        	if (data['rs'] === 1) {
	        		alert("전꺼로 이도옹");
	        	}
				else {
					alert("야잇");
					/* location.href = 'login.do' */
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
	        url: 'nextJson.json',
	        dataType: 'json',
	        data: {num:num_5},
	        success: function(data) {
	        	console.log("data : " + data);
	        	console.log("data['rs'] : " + data['rs']);
	        	if (data['rs'] === 1) {
	        		alert("다음꺼로 이도옹");
	        	}
				else {
					alert("야잇");
					/* location.href = 'login.do' */
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
	                    <a href="#" id="m_id"></a>
	                   </div>
	            </div>
	        </div>
	        <div class="main">
	            <div class="text_box" id="context"></div>
	        </div>
	        <div class="footer_box">
	            <div class="pe_neBtn_box">
	                <div class="prevBtn btn">
	                    <a href="#" id="prev">◀ PREV</a>
	                </div>
	                <div class="nextBtn btn">
	                    <a href="#" id="next">NEXT ▶</a>
	                </div>
	            </div>
	            <div class="list_box">
	               <div class="listBtn btn">
	                   <a href="./board.jsp">목록</a>
	               </div>
                  <input type="button" value="수정하기" class="modify_btn btn">
                  <input type="button" value="삭제하기" class="delete_btn btn">
	           </div>
	        </div>
	    </form> 
	 </div>
</body>
</html>