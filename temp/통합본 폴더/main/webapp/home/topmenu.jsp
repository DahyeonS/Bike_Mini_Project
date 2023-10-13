<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../member/script/deleteConfrim.jsp" %>
<!DOCTYPE html>
<html>

	<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
<script src="script/sendAjax.js"></script>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script>
			//탑 메뉴 숨기기
			$(document).ready(function() {
			    $('.outer-menu-item').hover(function() {
			            $(this).find('.inner-menu').show();
			    }, function() {
			            $(this).find('.inner-menu').hide();
			    });
			    $('.outer-menu-item').hover(function() {
			            $(this).find('.inner-menu').show();
			    }, function() {
			            $(this).find('.inner-menu').hide();
			    });
			}); // end
			
			function QnaLoginCheck() {
				if (<%=session.getAttribute("id")%> === null) {
					alert('회원만 작성할 수 있습니다.')
					$('a').attr('href', '../member/login.do');
				}
			};
		</script>
		
		<!-- 스타일-->
		<style>
			.outer-menu-item, #info {
			    float: left;
			    text-align: center;
			}
			.outer-menu-item:hover {
			    background: white;
			    color: black;
			}
			.loginbutton, #logout-btn{
			    float: right;
			}
			.inner-menu{
			    display: none;
			    position: absolute;
			    background: white;
			    z-index: 1000;
			    text-align: center;
			    list-style: none;
			}
			a {
			  text-decoration: none;
			}
			a:link {
			  color : black;
			}
			a:visited {
			  color : black;
			}
			a:hover {
			  color : black;
			}
			a:active {
			  color : black
			}
		</style>
	</head>
	<body>
	
		<div class="outer-menu-item">
		    <a href="../home/index.do">Home</a>
		</div>
		<div class="loginbutton">
			<div id="info">
			<c:if test="${id != null}">
			<c:if test="${grade == 'MANAGER'}">매니저</c:if>
			<c:if test="${grade == 'ASSOCIATE'}">부매니저</c:if>
			<c:if test="${grade == 'STAFF'}">스탭</c:if>
			<c:if test="${grade == 'GENERAL'}">일반회원</c:if>
		    ${nickname}(${id})님&nbsp
		    </c:if>
		    </div>
			<c:if test="${id == null}">
		    <a href="../member/join.do">회원가입</a>
		    <a href="../member/login.do">로그인</a>
		    </c:if>
		    <c:if test="${id != null}">
		    <div class="outer-menu-item" style="text-align: center;">
		        <!-- 외부 메뉴 항목의 콘텐츠 -->
		        내 정보
		        <div class="inner-menu">
		            <!-- 내부 메뉴 항목의 콘텐츠 -->
		            <c:if test="${grade != 'GENERAL'}">
		            <a href="../member/memberList.do">회원목록</a><br>
		            </c:if>
		            <a href="../member/update.do">정보수정</a><br>
		            <a href="#" onclick="deleteConfirm();">회원탈퇴</a>
		        </div>
			</div>
			&nbsp
		    <a href="../member/logout.do" id="logout-btn">로그아웃</a>
		    </c:if>
		</div>
		<br>
		<hr>
		<div class="container">
			<div class="row">
				<div class="col style="margin:auto;">
					<div class="outer-menu-item">
					    <ul class="list-group">
					        <!-- 외부 메뉴 항목의 콘텐츠 -->
					    	 <div class="text-center"">
								<h5>Q&A</h5>
							</div>
					        <div class="inner-menu">
					            <!-- 내부 메뉴 항목의 콘텐츠 -->
					            <li class="list-group-item"> <a href="../qna/qnaBoardList.do">목록</a></li>
					            <li class="list-group-item"> <a href="../qna/qnaWrite.do" onclick="QnaLoginCheck();">질문</a></li>
					        </div>
					    </ul>
					</div>
				</div>
				<div class="col style="margin:auto;">
					<div class="outer-menu-item">
					    <ul class="list-group">
					        <!-- 외부 메뉴 항목의 콘텐츠 -->
					    	 <div class="text-center"">
								<h5>박철규</h5>
							</div>
					        <div class="inner-menu">
					            <!-- 내부 메뉴 항목의 콘텐츠 -->
					            <li class="list-group-item"> <a href="../pcgboard/FreeBoardList.do">게시판</a></li>
					            <li class="list-group-item"> <a href="../pcgboard/FreeBoardListPaging.do">페이징</a></li>
					        </div>
					    </ul>
					</div>
				</div>
				<div class="col style="margin:auto;">
					<div class="outer-menu-item">
					    <ul class="list-group">
					        <!-- 외부 메뉴 항목의 콘텐츠 -->
					    	 <div class="text-center"">
								<h5>고훈</h5>
							</div>
					        <div class="inner-menu">
					            <!-- 내부 메뉴 항목의 콘텐츠 -->
					            <li class="list-group-item"> <a href="../khBoard/boardList.do">일반</a></li>
					            <li class="list-group-item"> <a href="../khBoard/qnaList.do">Q&A</a></li>
					            <li class="list-group-item"> <a href="../khBoard/imageList.do">사진</a></li>
					        </div>
					    </ul>
					</div>
				</div>
					<div class="col style="margin:auto;">
					<div class="outer-menu-item">
					    <ul class="list-group">
					        <!-- 외부 메뉴 항목의 콘텐츠 -->
					    	 <div class="text-center"">
								<h5>권지현</h5>
							</div>
					        <div class="inner-menu">
					            <!-- 내부 메뉴 항목의 콘텐츠 -->
					            <li class="list-group-item"> <a href="../jhBoard/boardList.do">일반</a></li>
					            <li class="list-group-item"> <a href="../jhBoard/qnaBoardList.do">Q&A</a></li>
					        </div>
					    </ul>
					</div>
				</div>
					<div class="col style="margin:auto;">
					<div class="outer-menu-item">
					    <ul class="list-group">
					        <!-- 외부 메뉴 항목의 콘텐츠 -->
					    	 <div class="text-center"">
								<h5>정민석</h5>
							</div>
					        <div class="inner-menu">
					            <!-- 내부 메뉴 항목의 콘텐츠 -->
					            <li class="list-group-item"> <a href="../jmsboard/board.do">게시판</a></li>
					        </div>
					    </ul>
					</div>
				</div>
					<div class="col style="margin:auto;">
					<div class="outer-menu-item">
					    <ul class="list-group">
					        <!-- 외부 메뉴 항목의 콘텐츠 -->
					    	 <div class="text-center"">
								<h5>황영선</h5>
							</div>
					        <div class="inner-menu">
					            <!-- 내부 메뉴 항목의 콘텐츠 -->
					            <li class="list-group-item">  <a href="../novel/board.do">소설</a></li>
					        </div>
					    </ul>
					</div>
				</div>
			</div>
		</div><hr><br>
		
 		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
 		<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
	</body>
</html>