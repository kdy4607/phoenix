-- ========================================
-- 1. 사용자 테이블 (USERS)
-- ========================================

drop table USERS;

-- 테이블 생성
CREATE TABLE USERS (
                       U_ID VARCHAR2(20) PRIMARY KEY,
                       u_pw VARCHAR2(100) NOT NULL,
                       U_name VARCHAR2(50) NOT NULL,
                       u_birth DATE,
                       u_address VARCHAR2(500)
);

-- 기본 데이터 삽입
INSERT INTO USERS (U_ID, u_pw, U_name, u_birth, u_address) VALUES
    ('kim123', 'password123!', '김철수', TO_DATE('1990-03-15', 'YYYY-MM-DD'), '서울특별시 강남구 테헤란로 123');

INSERT INTO USERS (U_ID, u_pw, U_name, u_birth, u_address) VALUES
    ('lee456', 'mypassword456', '이영희', TO_DATE('1985-07-22', 'YYYY-MM-DD'), '부산광역시 해운대구 해운대해변로 456');

INSERT INTO USERS (U_ID, u_pw, U_name, u_birth, u_address) VALUES
    ('park789', 'securepass789', '박민수', TO_DATE('1993-11-08', 'YYYY-MM-DD'), '대구광역시 중구 동성로 789');

INSERT INTO USERS (U_ID, u_pw, U_name, u_birth, u_address) VALUES
    ('choi101', 'password2024!', '최지현', TO_DATE('1988-05-30', 'YYYY-MM-DD'), '인천광역시 연수구 송도국제대로 101');

INSERT INTO USERS (U_ID, u_pw, U_name, u_birth, u_address) VALUES
    ('jung202', 'mykey202pass', '정수빈', TO_DATE('1992-12-03', 'YYYY-MM-DD'), '광주광역시 서구 상무중앙로 202');
-- 커밋
COMMIT;

-- 확인 쿼리
SELECT * FROM USERS;