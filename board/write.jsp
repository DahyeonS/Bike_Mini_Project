<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="stylesheet" type="text/css" href="../css/write.css">
<title>write</title>
</head>
<body>
	 <div class="wrap">
        <h1>회원제 게시판 - 글쓰기</h1>
        <form action="view.jsp">
            <div class="main">
                <table border="1">
                    <tbody>
                        <tr>
                            <td class="w_name">제목</td>
                            <td><input type="text" name="wTitle" id="wTitle"></td>
                        </tr>
                        <tr>
                            <td class="w_name">내용</td>
                            <td><input type="text" name="wContext" id="wContext"></td>
                        </tr>
                        <tr>
                            <td colspan="2" class="w_btn">
                                <input type="hidden" name="category" value="일반">
                                <input type="submit" value="작성 완료">
                                <input type="button" value="다시 입력">
                                <input type="button" value="목록 보기">
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </form>
    </div>
</body>
</html>