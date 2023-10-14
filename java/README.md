# 개요
**자바 파일들을 저장한 곳입니다.**

## control
**사이트의 Servlet 및 SQL 작업을 처리하는 곳입니다.**

### *JDBCUtil*
데이터베이스를 연결하는 스태틱 메소드 모음

### *DispathcherController*
do 작업을 실행하는 곳

### *JsonAPI*
Json 작업을 실행하는 곳

## member
**로그인 관리를 위한 시스템을 구축한 곳입니다.**

### *MemberDTO*
회원 정보를 담은 곳

> #### 변수명
> [참고](../database)

### *MemberDAO*
회원 시스템을 처리하는 곳

#### *MemberDAOImpl*
MemberDAO의 자식클래스

### *MemberControl*
회원 시스템의 do 작업을 실행하는 곳

### *MemberJson*
회원 시스템의 Json 작업을 실행하는 곳

## board
**게시판 시스템을 구축한 샘플 폴더입니다.**

## qna
**Q&A 게시판 관리를 위한 시스템을 구축한 곳입니다.**

### *QnaDTO*
Q&A 게시판 정보를 담은 곳

> #### 변수명
> [참고](../database)
>
> num - 게시판, 댓글 일련번호
>
> id - 회원 ID
>
> nickname - 회원 닉네임
>
> title - 게시글 제목
>
> context - 게시글, 댓글 내용
>
> category - 게시글 분류
>
> fileId - 파일 일련번호(post 테이블의 file_id)
>
> fileName - 파일 이름(post 테이블의 file_name)
>
> postdate - 게시글, 댓글 작성 날짜
>
> updateDate - 게시글 수정 날짜(post 테이블의 update_date)
>
> visitCount - 방문자 수(post 테이블의 visit_count)
>
> questNum - 게시글이 속한 질문 번호(답변 게시글 한정)(post 테이블의 quest_num)
>
> boardNum - 댓글이 속한 게시글 번호(reply 테이블의 post_num)

### *QnaDAO*
Q&A 게시판 시스템을 처리하는 곳

#### *QnaDAOImpl*
QnaDAO의 자식클래스

### *QnaControl*
Q&A 게시판의 do 작업을 실행하는 곳

### *QnaJson*
Q&A 게시판의 Json 작업을 실행하는 곳
