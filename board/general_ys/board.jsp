<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="stylesheet" type="text/css" href="./css/board_css.css">
 <!-- <link rel="stylesheet" type="text/css" href="../css/reset.css"> -->
<title>board</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- 이건 write 작성할때 로그인 되어있는지 확인 -->

<script>

<% String id = (String)session.getAttribute("id"); %>

 function writeBtn() {
	 	const id = "<%=id%>";
		const param = {id:id};
		$.ajax({
	        type: 'POST',
	        url: 'writeJson.json',
	        dataType: 'json',
	        data: param,
	        success: function(data) {
	        	console.log("id : " + id);
	        	console.log("data : " + data);
	        	console.log("data['rs'] : " + data['rs']);
	        	if (data['rs'] === 1) {
	        		location.href = 'write.jsp';
	        	}
				else {
					alert("게시글을 작성하려면 로그인을 먼저 하셔야됩니다");
					location.href = 'login.jsp'
				};
	        }, error: function(xhr, status, error) {
	        	console.log(xhr, status, error);
	        }
		});
	};
	$(function() {
		$('#b_writeBtn').click(function() {
			writeBtn();
			const id = <%=id%>;
			console.log("id : " + id);
			
			if (id === null || id.trim() === '') {
	            alert("게시글을 작성하려면 로그인을 먼저 하셔야됩니다");
	            location.href = 'login.jsp';
	        }
			
		});
	});
	
</script>
</head>
<%@include file="loginmenu.jsp" %>
<body>
	<h1>OO 게시판</h1>
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
	            <tbody>
	                <tr class="tul_th">
	                    <td class="th_span th_num">번호</td>
	                    <td class="th_span">제목</td>
	                    <td class="th_span">작성자</td>
	                    <td class="th_span">조회수</td>
	                    <td class="th_span">작성일</td>
	                </tr>
	                <tr>
	                    <td class="tul_span"><a href="view.jsp">0</a></td>
	                    <td class="tul_span"><a href="view.jsp">게시판 테스트글</a></td>
	                    <td class="tul_span"><a href="view.jsp">관리자</a></td>
	                    <td class="tul_span"><a href="view.jsp">1</a></td>
	                    <td class="tul_span"><a href="view.jsp">2021-08-05</a></td>
	                </tr>
	            </tbody>
	        </table>
		
		
			<div><input type="button" value="글쓰기" id="b_writeBtn"></div>
		</div>
	</form>
</body>
</html>







