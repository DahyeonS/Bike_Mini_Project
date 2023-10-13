-- 회원 테이블 생성
CREATE TABLE member (
  idx NUMBER PRIMARY KEY,
  id VARCHAR2(10) NOT NULL UNIQUE,
  pw VARCHAR2(20) NOT NULL,
  nickname VARCHAR2(20) NOT NULL UNIQUE,
  grade VARCHAR2(10) CHECK (grade IN ('MANAGER', 'ASSOCIATE', 'STAFF', 'GENERAL')),
  regdate DATE DEFAULT SYSDATE NOT NULL
);

-- 시퀀스 생성
CREATE SEQUENCE member_idx
START WITH 1
INCREMENT BY 1
MAXVALUE 9999
NOCACHE
NOORDER;

-- 관리자 계정 생성
INSERT INTO member VALUES (member_idx.NEXTVAL, 'admin', '1234', '관리자', 'MANAGER', SYSDATE);
ALTER TABLE member MODIFY grade DEFAULT 'GENERAL';
COMMIT;

-- 확인
SELECT * FROM member;