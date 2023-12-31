/**
    날짜 : 2023/10/02
    이름 : 이현정
    내용 : 2장 데이터베이스 기본
*/

-- 실습 1-1
CREATE TABLE USER1 (
    ID VARCHAR2(20),
    NAME VARCHAR2(20),
    HP CHAR(13),
    AGE NUMBER
);


-- 실습 1-2
INSERT INTO USER1 VALUES ('A101', '김유신', '010-1234-1111', 25);
INSERT INTO USER1 VALUES ('A102', '김춘추', '010-1234-2222', 23);
INSERT INTO USER1 VALUES ('A103', '장보고', '010-1234-3333', 32);
INSERT INTO USER1 (id, name, age) VALUES ('A104', '강감찬', 45);
INSERT INTO USER1 (id, name, hp) VALUES ('A105', '이순신', '010-1234-5555');

-- 실습 1-3
SELECT * FROM USER1;
SELECT * FROM USER1 WHERE id='A101';
SELECT * FROM USER1 WHERE name='김춘추';
SELECT * FROM USER1 WHERE age > 30;
SELECT id, name, age FROM USER1;

-- 실습 1-4
UPDATE User1 SET hp='010-1234-4444' WHERE id='A104';
UPDATE User1 SET age=51 WHERE id='A105';
UPDATE User1 SET hp='010-1234-1001', age=27 WHERE id='A101';

-- 실습 1-5
DELETE FROM User1 WHERE id='A101';
DELETE FROM User1 WHERE id='A102' AND age=25;
DELETE FROM User1 WHERE age >= 30;


-- 실습 2-1
CREATE TABLE USER2 (
    ID      VARCHAR2(20) PRIMARY KEY,
    NAME    VARCHAR2(20),
    HP      CHAR(13),
    AGE     NUMBER(2)
);

INSERT INTO USER2 VALUES ('A101', '김유신', '010-1234-1111', 25);
INSERT INTO USER2 VALUES ('A102', '김춘추', '010-1234-2222', 23);
INSERT INTO USER2 VALUES ('A103', '장보고', '010-1234-3333', 32);
INSERT INTO USER2 (id, name, age) VALUES ('A104', '강감찬', 45);
INSERT INTO USER2 (id, name, hp) VALUES ('A105', '이순신', '010-1234-5555');

-- 실습 2-2. 고유키 실습
CREATE TABLE USER3 (
    ID      VARCHAR2(20) PRIMARY KEY,
    NAME    VARCHAR2(20),
    HP      CHAR(13) UNIQUE,
    AGE     NUMBER(2)
);
INSERT INTO USER3 VALUES ('A101', '김유신', '010-1234-1111', 25);
INSERT INTO USER3 VALUES ('A102', '김춘추', '010-1234-2222', 23);
INSERT INTO USER3 VALUES ('A103', '장보고', '010-1234-3333', 32);
INSERT INTO USER3 (id, name, age) VALUES ('A104', '강감찬', 45);
INSERT INTO USER3 (id, name, hp) VALUES ('A105', '이순신', '010-1234-5555');


-- 실습 2-3. 외래키 실습
CREATE TABLE PARENT (
    PID VARCHAR2(20) PRIMARY KEY,
    NANE VARCHAR2(20),
    HP CHAR(13) UNIQUE
)
CREATE TABLE CHILD (
    CID VARCHAR2(20) PRIMARY KEY,
    NAME VARCHAR2(20),
    HP CHAR(13) UNIQUE,
    PARENT VARCHAR2(20),
    FOREIGN KEY (PARENT) REFERENCES PARENT (PID)
)
INSERT INTO PARENT VALUES ('P101', '김서현', '010-1234-1001');
INSERT INTO PARENT VALUES ('P102', '이성계', '010-1234-1002');
INSERT INTO PARENT VALUES ('P103', '신사임당', '010-1234-1003');

INSERT INTO CHILD VALUES ('C101', '김유신', '010-1234-2001', 'P101');
INSERT INTO CHILD VALUES ('C102', '이방우', '010-1234-2002', 'P102');
INSERT INTO CHILD VALUES ('C103', '이방원', '010-1234-2003', 'P102');
INSERT INTO CHILD VALUES ('C104', '이이', '010-1234-2004', 'P103');


-- 실습 2-2. DEFAULT/NOT NULL 실습
CREATE TABLE USER4 (
    NAME  VARCHAR2(20) NOT NULL,
    GENDER CHAR(1) NOT NULL,
    AGE INT DEFAULT 1,
    ADDR VARCHAR2(255)
);

INSERT INTO USER4 VALUES('김유신', 'M', 23, '김해시');
INSERT INTO USER4 VALUES ('김춘추', 'M', 21, '경주시');
INSERT INTO USER4 (NAME, GENDER, ADDR) VALUES ('신사임당', 'F', '강릉시');
INSERT INTO USER4 (NAME, GENDER) VALUES ('이순신', 'M');
INSERT INTO USER4 (NAME, GENDER, AGE) VALUES ('정약용', 'M', 33);

-- 실습 2-2. CHECK 제약조건 실습
CREATE TABLE USER5 (
    NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(1) NOT NULL CHECK(GENDER IN('M', 'F')),
    AGE INT DEFAULT 1 CHECK(AGE > 0 AND AGE < 100),
    ADDR VARCHAR2(255)
);
INSERT INTO USER5 VALUES ('김유신', 'M', 23, '김해시');
INSERT INTO USER5 VALUES ('김춘추', 'M', 21, '경주시');
INSERT INTO USER5 (NAME, GENDER, ADDR) VALUES ('신사임당', 'F', '강릉시');
INSERT INTO USER5 (NAME, GENDER) VALUES ('이순신', 'M');
INSERT INTO USER5 (NAME, GENDER, AGE) VALUES ('정약용', 'M', 33);

-- 실습 3-1. 데이터 사전 조회
// 전체 사전 조회
SELECT * FROM DICT;

// 테이블 조회(현재 사용자 기준)
SELECT TABLE_NAME FROM USER_TABLES;

// 전체 테이블 조회(현재 사용자 기준)
SELECT OWNER, TABLE_NAME FROM ALL_TABLES;

// 전체 테이블 조회(SYSTEM 관리자만 가능)
SELECT * FROM DBA_TABLES;

// 전체 사용자 조회(system 관리자만 가능)
SELECT * FROM DBA_USERS;

-- 실습 3-2. 인덱스 조회
// 현재 사용자 인덱스 조회
SELECT * FROM USER_INDEXES;

// 현재 사용자 인덱스 정보 조회
SELECT * FROM USER_IND_COLUMNS;

// 인덱스 생성
CREATE INDEX IDX_USER1_ID ON USER1(ID);
SELECT * FROM USER_IND_COLUMNS;

// 인덱스 삭제
DROP INDEX IDX_USER1_ID;
SELECT * FROM USER_IND_COLUMNS;

-- 실습 3-3. 뷰 생성 권한 할당
GRANT CREATE VIEW TO scott;

-- 실습 3-4. 뷰 생성/조회/삭제
// 뷰 생성
CREATE VIEW VW_USER1 AS (SELECT NAME, HP, AGE FROM USER1);
CREATE VIEW VW_USER2_AGE_UNDER30 AS (SELECT * FROM USER2 WHERE AGE < 30);
SELECT * FROM USER_VIEWS;

// 뷰 조회
SELECT * FROM VW_USER1;
SELECT * FROM VW_USER2_AGE_UNDER30;

// 뷰 삭제
DROP VIEW VW_USER1;
DROP VIEW VW_USER2_AGE_UNDER30;

-- 실습 3-5. 시퀀스 적용 테이블 생성
CREATE TABLE USER6 (
    SEQ         NUMBER PRIMARY KEY,
    NAME        VARCHAR2(20),
    GENDER      CHAR(1),
    AGE         NUMBER,
    ADDR        VARCHAR2(255)
);

-- 실습 3-6. 시퀀스 생성
CREATE SEQUENCE SEQ_USER6 INCREMENT BY 1 START WITH 1;


-- 실습 3-7. 시퀀스값 입력
INSERT INTO USER6 VALUES (SEQ_USER6.NEXTVAL, '김유신', 'M', 25, '김해시');
INSERT INTO USER6 VALUES (SEQ_USER6.NEXTVAL, '김춘추', 'M', 23, '경주시');
INSERT INTO USER6 VALUES (SEQ_USER6.NEXTVAL, '신사임당', 'F', 27, '강릉시');

-- 실습 4-1. 사용자 생성
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER User1 IDENTIFIED BY "1234";

-- 실습 4-2. 사용자 조회
SELECT * FROM ALL_USERS;
SELECT * FROM ALL_USERS WHERE USERNAME='USER1';

-- 실습 4-3. 사용자 변경
ALTER USER USER1 IDENTIFIED BY "12345";  
DROP USER User1;
DROP USER User1 CASCADE;

-- 실습 4-3. Role 부여
GRANT CONNECT, RESOURCE TO User1;
GRANT UNLIMITED TABLESPACE TO User1;


