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
<!-- 이건 id 유무체크 -->
<script>
	function boardAjax() {
		var id = $('#id').val();
		var pw = $("#pw").val();
	    var pw2 = $("#pw2").val();
	    var name = $('#name').val();
	    var age = $('#age').val();
	    // const params = {id,pw,name,age};
	    const params = {id:id, pw:pw, name:name, age:age};
	    // console.log("params : " +params);

	    // 비밀번호와 비밀번호 확인이 일치하는지 확인
	    console.log("pw : " + pw);
	    console.log("pw2 : " + pw2);
	    if (pw !== pw2) {
	        // 비밀번호가 일치하지 않는 경우
	        alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.');
	        return;
	    }
		
		/* $.ajax({
			type: 'POST',
			url: 'joinProcAjax.do',
			dataType: 'json',
			data: params,
			success: function(data) {
				if(data['rs'] === 1) {
					alert('회원가입 되었습니다~');
					location.href = 'login.do';
				} else {
					alert('잠시후 다시 한번 시도해주세요ㅠ');					
				}
				
			},
			error : function(xhr, status, error) {
				console.log(xhr, status, error);
				alert("실패했니?");
			}
		}); */
	};
	$(function(){		        
        $('#b_writeBtn').on('click', function() {
        	boardAjax()
        });
        
	});
</script>
</head>
<body>
	<h1>OO 게시판</h1>
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
	
	
		<div><a href="write.jsp"><input type="button" value="글쓰기" id="b_writeBtn"></a></div>
	</div>
</body>
</html>







