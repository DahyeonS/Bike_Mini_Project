<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
<%@include file="../member/script/deleteConfrim.jsp" %>
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
});// end
</script>

<!-- 스타일-->
<style>
.outer-menu-item, #info {
    float: left;
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
}
</style>

<div class="outer-menu-item">
    <a href="index.do">Home</a>
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
    <a href="join.do">회원가입</a>
    <a href="login.do">로그인</a>
    </c:if>
    <c:if test="${id != null}">
    <div class="outer-menu-item" style="text-align: center;">
        <!-- 외부 메뉴 항목의 콘텐츠 -->
        내 정보
        <div class="inner-menu">
            <!-- 내부 메뉴 항목의 콘텐츠 -->
            <c:if test="${grade != 'GENERAL'}">
            <a href="memberList.do">회원목록</a><br>
            </c:if>
            <a href="update.do">정보수정</a><br>
            <a href="#" onclick="deleteConfirm();">회원탈퇴</a>
        </div>
	</div>
	&nbsp
    <a href="logout.do" id="logout-btn">로그아웃</a>
    </c:if>
</div>
<br>
<hr>
<div class="outer-menu-item">
    <ul>
        <!-- 외부 메뉴 항목의 콘텐츠 -->
        <li>서다현(Q&A)</li>
        <div class="inner-menu">
            <!-- 내부 메뉴 항목의 콘텐츠 -->
            <li> <a href="../board/test.jsp">목록보기</a></li>
            <li> <a href="">데이터</a></li>
            <li> <a href="">데이터</a></li>
            <li> <a href="">데이터</a></li>
            <li> <a href="">데이터</a></li>
        </div>
    </ul>
</div>
<div class="outer-menu-item">
    <ul>
        <!-- 외부 메뉴 항목의 콘텐츠 -->
        <li>박철규</li>
        <div class="inner-menu">
            <!-- 내부 메뉴 항목의 콘텐츠 -->
            <li> <a href="">데이터</a></li>
            <li> <a href="">데이터</a></li>
            <li> <a href="">데이터</a></li>
            <li> <a href="">데이터</a></li>
            <li> <a href="">데이터</a></li>
        </div>
    </ul>
</div>
<div class="outer-menu-item">
    <ul>
        <!-- 외부 메뉴 항목의 콘텐츠 -->
        <li>고훈</li>
        <div class="inner-menu">
            <!-- 내부 메뉴 항목의 콘텐츠 -->
            <li> <a href="">데이터</a></li>
            <li> <a href="">데이터</a></li>
            <li> <a href="">데이터</a></li>
            <li> <a href="">데이터</a></li>
            <li> <a href="">데이터</a></li>
        </div>
    </ul>
</div>
<div class="outer-menu-item">
    <ul>
        <!-- 외부 메뉴 항목의 콘텐츠 -->
        <li>권지현</li>
        <div class="inner-menu">
            <!-- 내부 메뉴 항목의 콘텐츠 -->
            <li> <a href="">데이터</a></li>
            <li> <a href="">데이터</a></li>
            <li> <a href="">데이터</a></li>
            <li> <a href="">데이터</a></li>
            <li> <a href="">데이터</a></li>
        </div>
    </ul>
</div>
<div class="outer-menu-item">
    <ul>
        <!-- 외부 메뉴 항목의 콘텐츠 -->
        <li>정민석</li>
        <div class="inner-menu">
            <!-- 내부 메뉴 항목의 콘텐츠 -->
            <li> <a href="">데이터</a></li>
            <li> <a href="">데이터</a></li>
            <li> <a href="">데이터</a></li>
            <li> <a href="">데이터</a></li>
            <li> <a href="">데이터</a></li>
        </div>
    </ul>
</div>
<div class="outer-menu-item">
    <ul>
        <!-- 외부 메뉴 항목의 콘텐츠 -->
        <li>황영선</li>
        <div class="inner-menu">
            <!-- 내부 메뉴 항목의 콘텐츠 -->
            <li> <a href="">데이터</a></li>
            <li> <a href="">데이터</a></li>
            <li> <a href="">데이터</a></li>
            <li> <a href="">데이터</a></li>
            <li> <a href="">데이터</a></li>
        </div>
    </ul>
</div>
<br><br><br>
<hr style="position: relative;">