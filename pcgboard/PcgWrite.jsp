
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pcg 게시판 뷰어</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./css/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
<script type="text/javascript">

function validateForm() {
	 var title = $("#title").val();
     var context = $("#content").val();
	
	if(title == "" ){
	alert("제목을 입력하세요.");
	$("#title").focus();
	return false;
	}else if(context == "" ){
	alert("내용을 입력하세요.");
	$("#content").focus();
	return false;
	}
}

function Insert() {
    var id = "${id}"; // 세션 id 값
    var nickname = "${nickname}"; // 세션 닉네임 값
    if (id !== "" ) { // 세션에 id가 있을 때 글쓰기
        var title = $("#title").val();
        var context = $("#content").val();
        var category = $("#category").val(); // 카테고리 id 를 가진 val 만들기
    validateForm();
    console.log(title);
    console.log(context);
    console.log(category);
        // AJAX 요청 설정
        $.ajax({
            type: 'POST',
            url: 'pcgInsertboard.json',
            dataType: 'json',
            data: { id: id, nickname: nickname, title: title, context: context, category: category },
            success: function (data) {
                console.log(data);
                if (data['rs'] == 1) {
                    alert("작성이 완료 되었습니다.");
                } else {
                    alert("글이 저장되지 않았습니다. 잠시후 다시 시도해주세요.");
                }
            },
            error: function (xhr, status, error) {
                console.log(xhr, status, error);
            }
        });
    } else { // 세션에 id가 없으면 로그인 요청
        alert("로그인 후 작성해주세요.");
    }
}

</script>
</head>
<body>
	<%@include file="../home/topmenu.jsp"%>
	<h2>게시판 -글쓰기</h2>
	<form name="writeFrm" method="post" action="write.json"
		onsubmit="return validateForm(this);">
	<table border="1"  class="container">
		<tr>
			<td>제목</td>
			
			<td>
					<select name=category id="category">
					<option value="자유">자유</option>
					<option value="일반">일반</option>
					</select>
			<input type="text" name="title" id="title" style="width: 90%;" /></td>
		</tr>
		<tr>
			<td>내용</td>
			<td>
			<div class="form-floating">
			  <textarea name="content" id="content" class="form-control" placeholder="Leave a comment here" id="floatingTextarea"></textarea>
  			  <label for="floatingTextarea">Comments</label>
			</div>
					</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<button type="button" onclick='Insert()'>작성 완료</button>
				<button type="reset">다시 입력</button>
				<button type="button" onclick="location.href='../pcgboard/FreeBoardList.do';">목록보기</button> 

			</td>
		</tr>


	</table>
	</form>
	<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
			crossorigin="anonymous"></script>
		<script
			src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
			integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
			crossorigin="anonymous"></script>
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js"
			integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa"
			crossorigin="anonymous"></script>
</body>
</html>