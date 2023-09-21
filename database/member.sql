-- 회원 테이블 생성
CREATE TABLE member (
  idx NUMBER PRIMARY KEY,
  id VARCHAR2(10) NOT NULL,
  pw VARCHAR2(20) NOT NULL,
  nickname VARCHAR2(10) NOT NULL,
  grade VARCHAR2(10) CHECK (grade IN ('MANAGER', 'ASSOCIATE', 'STAFF', 'GENERAL'))
);

-- 관리자 계정 생성
INSERT INTO member VALUES (1, 'admin', '1234', '관리자', 'MANAGER');
ALTER TABLE member MODIFY grade DEFAULT 'GENERAL';
COMMIT;

-- 확인
SELECT * FROM member;