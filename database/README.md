# 개요
데이터베이스를 관리할 SQL 파일들을 모아놓은 곳입니다.

## *member.sql*
**로그인 및 회원 관리를 위한 회원 테이블**

> ### 칼럼명
> idx - 회원 일련번호
> 
> id - 회원 ID
> 
> pw - 회원 비밀번호
> 
> nickname - 회원 닉네임
> 
> grade - 회원 등급(매니저, 부매니저, 스탭, 일반회원 4단계로 나뉘어 있음)
>
> regdate - 회원가입 날짜

## *post.sql*
**작성한 게시물을 저장하는 게시물 테이블**

> ### 칼럼명
> num - 게시판 일련번호
> 
> id - 회원 ID
> 
> nickname - 회원 닉네임
>
> title - 게시글 제목
>
> context - 게시글 내
> 
> category - 게시글 분류(현재 일반, 질문, 답변 3가지로 나뉘어 있음)
>
> file_id - 파일 일련번호
>
> file_name - 파일 이름
>
> postdate - 게시 날짜
>
> update_date - 수정 날짜
> 
> visit_count - 방문자 수
>
> quest_num - 게시글이 속한 질문 번호(답변 게시글 한정)

## *reply.sql*
**작성한 댓글을 저장하는 댓글 테이블**

> ### 칼럼명
> id - 회원 ID
>
> num - 댓글 일련번호
>
> post_num - 댓글이 속한 게시글 번호
>
> nickname - 회원 닉네임
>
> context - 댓글 내용
>
> postdate - 댓글 작성 날짜
