-- 테이블 생성
CREATE TABLE reply (
    id VARCHAR2(10) REFERENCES member(id) ON DELETE CASCADE NOT NULL,
    num NUMBER PRIMARY KEY NOT NULL,
    post_num NUMBER REFERENCES post(num) ON DELETE CASCADE NOT NULL,
    nickname VARCHAR2(10) REFERENCES member(nickname) NOT NULL,
    context VARCHAR2(4000) NOT NULL,
    postdate DATE DEFAULT SYSDATE NOT NULL
);

-- 시퀀스 생성
CREATE SEQUENCE reply_idx
START WITH 1
INCREMENT BY 1
MAXVALUE 9999
NOCACHE
NOORDER;

-- 트리거 생성
CREATE OR REPLACE TRIGGER reply_trigger
BEFORE UPDATE OF nickname ON member
FOR EACH ROW
BEGIN
    UPDATE reply
    SET nickname = :NEW.nickname
    WHERE nickname = :OLD.nickname;
END;
/

-- 확인
SELECT * FROM reply;