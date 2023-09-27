CREATE TABLE comment (
    id VARCHAR2(10) REFERENCES member(id) ON DELETE CASCADE NOT NULL,
    num NUMBER PRIMARY KEY NOT NULL,
    nickname VARCHAR2(10) REFERENCES member(nickname) NOT NULL,
    title VARCHAR2(50) NOT NULL,
    context VARCHAR2(4000) NOT NULL,
    category VARCHAR2(10) NOT NULL,
    file_id NUMBER,
    file_name VARCHAR2(100),
    postdate DATE DEFAULT SYSDATE NOT NULL,
    visit_count NUMBER DEFAULT 0
);