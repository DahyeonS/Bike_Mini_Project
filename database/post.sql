-- 테이블 생성
CREATE TABLE post (
    id VARCHAR2(10) REFERENCES member(id) ON DELETE CASCADE NOT NULL,
    num NUMBER PRIMARY KEY NOT NULL,
    nickname VARCHAR2(10) REFERENCES member(nickname) NOT NULL,
    title VARCHAR2(50) NOT NULL,
    context VARCHAR2(4000) NOT NULL,
    category VARCHAR2(10) CHECK (category IN ('일반', '질문', '답변')) NOT NULL,
    file_id NUMBER,
    file_name VARCHAR2(100),
    postdate DATE DEFAULT SYSDATE NOT NULL,
    visit_count NUMBER DEFAULT 0
);

-- 시퀀스 생성
CREATE SEQUENCE post_idx
START WITH 1
INCREMENT BY 1
MAXVALUE 9999
NOCACHE
NOORDER;

CREATE SEQUENCE file_idx
START WITH 1
INCREMENT BY 1
MAXVALUE 9999
NOCACHE
NOORDER;

-- 확인
SELECT * FROM post;