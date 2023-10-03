# 개요
**자바 파일들을 저장한 곳입니다.**

## control
**사이트의 Servlet 및 SQL 작업을 처리하는 곳입니다.**

### *JDBCUtil*
**데이터베이스를 연결하는 스태틱 메소드 모음**

### *DispathcherController*
**do 작업을 실행하는 곳**

## member
**로그인 관리를 위한 시스템을 구축한 곳입니다.**

### *MemberDTO*
**회원 정보를 담은 곳**

> #### 변수명
> [참고](../database)

### *MemberDAO*
**회원 시스템을 처리하는 곳**

#### *MemberDAOImpl*
MemberDAO의 자식클래스

### *MemberControl*
**회원 시스템의 do 작업을 실행하는 곳**

### *MemberJson*
**회원 시스템의 Json 작업을 실행하는 곳**
