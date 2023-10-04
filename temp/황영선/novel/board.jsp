<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="stylesheet" type="text/css" href="../css/board_css.css">
 <!-- <link rel="stylesheet" type="text/css" href="../css/reset.css"> -->
<title>board</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- 이건 write 작성할때 로그인 되어있는지 확인 -->

<script>
function getBoardJson() {
	$.ajax({
        type: 'GET',
        url: 'board.json',
        dataType: 'json',
        success: function(data) {
            let tr = '';
            for (item of data) {
                const {id, num, nickname, title, postdate, visit_count} = item;
				console.log("item : "+ item);
                tr += '<tr style="text-align: center;">' +
                	'<td class="tul_span"><a href="view.jsp?num='+ num +'&id='+ id +'&num2='+ num +'&num3='+ num +'&num4='+ num +'&num5='+ num +'">' + num + '</a></td>' +
                    '<td class="tul_span"><a href="view.jsp?num='+ num +'&id='+ id +'&num2='+ num +'&num3='+ num +'&num4='+ num +'&num5='+ num +'">' + title + '</a></td>' +
                    '<td class="tul_span"><a href="view.jsp?num='+ num +'&id='+ id +'&num2='+ num +'&num3='+ num +'&num4='+ num +'&num5='+ num +'">' + nickname + '</a></td>' +
                    '<td class="tul_span"><a href="view.jsp?num='+ num +'&id='+ id +'&num2='+ num +'&num3='+ num +'&num4='+ num +'&num5='+ num +'">' + visit_count + '</td>' +
                    '<td class="tul_span"><a href="view.jsp?num='+ num +'&id='+ id +'&num2='+ num +'&num3='+ num +'&num4='+ num +'&num5='+ num +'">' + postdate + '</a></td></tr>';
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
	        url: 'idCheck.json',
	        dataType: 'json',
	        data: param,
	        success: function(data) {
	        	console.log("id : " + id);
	        	console.log("data : " + data);
	        	console.log("data['rs'] : " + data['rs']);
	        	if (data['rs'] === 1) {
	        		location.href = 'write.jsp';
	        	}else {
        		 	alert("게시글을 작성하려면 로그인을 먼저 하셔야됩니다");
	 	            location.href = 'login.do';
	        	}
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
	});
	
</script>
</head>
<%@include file="../home/topmenu.jsp" %>
<body>
	<h1>소설 게시판</h1>
	<form action="write">
		<div class="board_box">
			<div>
				<div>
					<select>
						<option>제목</option>
						<option>내용</option>
						<option>작성자</option>
					</select>
					<input type="text" name="b_search" id="b_search">
					<input type="button" value="검색하기" id="b_searchBtn">
				</div>
			</div>
		
			<table class="table_ul" border="1">
				<thead>
			        <tr class="tul_th">
			            <th class="th_span th_num">번호</th>
			            <th class="th_span">제목</th>
			            <th class="th_span">작성자</th>
			            <th class="th_span">조회수</th>
			            <th class="th_span">작성일</th>
			        </tr>
			    </thead>
	            <tbody id="tbody">
	               <!--  <tr>
	                    <td class="tul_span"><a href="view.jsp">0</a></td>
	                    <td class="tul_span"><a href="view.jsp">게시글 한번 써보고 싶었어요 ㅎㅎ</a></td>
	                    <td class="tul_span"><a href="view.jsp">test1</a></td>
	                    <td class="tul_span"><a href="view.jsp">1</a></td>
	                    <td class="tul_span"><a href="view.jsp">2023-04-03</a></td>
	                </tr> -->
	            </tbody>
	        </table>
		
		
			<div><input type="button" value="글쓰기" id="b_writeBtn"></div>
		</div>
	</form>
</body>
</html>







