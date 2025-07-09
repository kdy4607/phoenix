-- ========================================
-- 1. 사용자 테이블 (USERS)
-- ========================================

-- 테이블 생성
CREATE TABLE USERS (
                       U_ID VARCHAR2(20) PRIMARY KEY,
                       u_pw VARCHAR2(100) NOT NULL,
                       U_nickname VARCHAR2(50) NOT NULL UNIQUE,
                       U_name VARCHAR2(50) NOT NULL UNIQUE,
                       u_birth DATE,
                       u_address VARCHAR2(500)
);

-- 시퀀스 생성
CREATE SEQUENCE SEQ_U_ID START WITH 1 INCREMENT BY 1;

-- 기본 데이터 삽입
INSERT INTO USERS (U_ID, u_pw, U_nickname, U_name, u_birth, u_address)
VALUES (1, 'password123', 'testuser', '김테스트', DATE '1990-01-01', '서울시 강남구');

INSERT INTO USERS (U_ID, u_pw, U_nickname, U_name, u_birth, u_address)
VALUES (2, 'password456', 'moviefan', '이영화', DATE '1985-05-15', '서울시 서초구');

INSERT INTO USERS (U_ID, u_pw, U_nickname, U_name, u_birth, u_address)
VALUES (3, 'phoenix2025', 'cinephile', '박시네마', DATE '1992-03-20', '서울시 종로구');

INSERT INTO USERS (U_ID, u_pw, U_nickname, U_name, u_birth, u_address)
VALUES (4, 'movie1234', 'filmlovers', '최영화', DATE '1988-07-12', '경기도 수원시');

-- 커밋
COMMIT;

-- 확인 쿼리
SELECT * FROM USERS;