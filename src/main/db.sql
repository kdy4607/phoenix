-- ========================================
-- 수정된 Oracle DB 스키마 (SEATS 테이블 구조 반영)
-- ========================================

-- ========================================
-- 1. 사용자 테이블
-- ========================================
CREATE TABLE USERS (
                       U_ID VARCHAR2(20) PRIMARY KEY,
                       u_pw VARCHAR2(100) NOT NULL,
                       U_nickname VARCHAR2(50) NOT NULL UNIQUE,
                       U_name VARCHAR2(50) NOT NULL UNIQUE,
                       u_birth DATE,
                       u_address VARCHAR2(500)
);

-- 시퀀스 (20자리까지 가능하므로 충분)
CREATE SEQUENCE SEQ_U_ID START WITH 1 INCREMENT BY 1;

-- ========================================
-- 2. 상영관 테이블 (ROOM_ID NUMBER(2)에 맞춤)
-- ========================================
CREATE TABLE ROOMS (
                       ROOM_ID NUMBER(2) PRIMARY KEY, -- NUMBER(2)로 변경 (최대 99)
                       ROOM_NAME VARCHAR2(20) NOT NULL,
                       TOTAL_SEATS NUMBER(3) NOT NULL -- NUMBER(3)으로 변경 (최대 999)
);

-- 시퀀스를 1부터 시작하고 99를 넘지 않도록 관리
CREATE SEQUENCE SEQ_ROOM_ID START WITH 1 INCREMENT BY 1 MAXVALUE 99;

-- ========================================
-- 3. 좌석 테이블 (제공된 구조 그대로 사용)
-- ========================================
CREATE TABLE SEATS (
                       SEAT_ID NUMBER(3) PRIMARY KEY,    -- 최대 999
                       ROOM_ID NUMBER(2) NOT NULL,       -- 최대 99
                       SEAT_ROW CHAR(1) NOT NULL,        -- A, B, C...
                       SEAT_NUMBER NUMBER(3) NOT NULL,   -- 최대 999
                       STATUS VARCHAR2(20) DEFAULT '사용가능',
                       CONSTRAINT FK_SEATS_ROOM FOREIGN KEY (ROOM_ID) REFERENCES ROOMS(ROOM_ID)
);

-- 시퀀스를 999를 넘지 않도록 설정
CREATE SEQUENCE SEQ_SEAT_ID START WITH 1 INCREMENT BY 1 MAXVALUE 999;

-- ========================================
-- 4. 영화 테이블
-- ========================================
CREATE TABLE MOVIES (
                        MOVIE_ID NUMBER(3) PRIMARY KEY,   -- NUMBER(3)으로 제한 (최대 999편)
                        TITLE VARCHAR2(100) NOT NULL,
                        GENRE VARCHAR2(50) NOT NULL,
                        RATING VARCHAR2(20) NOT NULL,
                        RUNNING_TIME NUMBER(3) NOT NULL,  -- 최대 999분
                        POSTER_URL VARCHAR2(500)
);

CREATE SEQUENCE SEQ_MOVIE_ID START WITH 1 INCREMENT BY 1 MAXVALUE 999;

-- ========================================
-- 5. 상영시간 테이블
-- ========================================
CREATE TABLE RUNTIMES (
                          RUNTIME_ID NUMBER(4) PRIMARY KEY,     -- 상영시간은 많을 수 있으므로 4자리
                          MOVIE_ID NUMBER(3) NOT NULL,
                          ROOM_ID NUMBER(2) NOT NULL,
                          RUN_DATE DATE NOT NULL,
                          START_TIME VARCHAR2(5) NOT NULL,
                          PRICE NUMBER(6) DEFAULT 12000 NOT NULL, -- 가격은 6자리 (999,999원까지)
                          AVAILABLE_SEATS NUMBER(3) NOT NULL,
                          CONSTRAINT FK_RUNTIMES_MOVIE FOREIGN KEY (MOVIE_ID) REFERENCES MOVIES(MOVIE_ID),
                          CONSTRAINT FK_RUNTIMES_ROOM FOREIGN KEY (ROOM_ID) REFERENCES ROOMS(ROOM_ID)
);

CREATE SEQUENCE SEQ_RUNTIME_ID START WITH 1 INCREMENT BY 1 MAXVALUE 9999;

-- ========================================
-- 6. 예약 테이블
-- ========================================
CREATE TABLE RESERVATIONS (
                              RESERVATION_ID NUMBER(6) PRIMARY KEY,  -- 예약은 많을 수 있으므로 6자리
                              U_ID NUMBER(20) NOT NULL,
                              RUNTIME_ID NUMBER(4) NOT NULL,
                              ADULT NUMBER(2) DEFAULT 0,             -- 최대 99명
                              YOUTH NUMBER(2) DEFAULT 0,             -- 최대 99명
                              CHILD NUMBER(2) DEFAULT 0,             -- 최대 99명
                              TOTAL_AMOUNT NUMBER(8) NOT NULL,       -- 금액은 8자리까지
                              RESERVATION_STATUS VARCHAR2(20) DEFAULT '예약완료',
                              RESERVED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                              CONSTRAINT FK_RESERVATIONS_USER FOREIGN KEY (U_ID) REFERENCES USERS(U_ID),
                              CONSTRAINT FK_RESERVATIONS_RUNTIME FOREIGN KEY (RUNTIME_ID) REFERENCES RUNTIMES(RUNTIME_ID)
);

CREATE SEQUENCE SEQ_RESERVATION_ID START WITH 1 INCREMENT BY 1 MAXVALUE 999999;

-- ========================================
-- 7. 예약 좌석 테이블
-- ========================================
CREATE TABLE RESERVATION_SEATS (
                                   RESERVATION_SEAT_ID NUMBER(8) PRIMARY KEY, -- 예약좌석은 가장 많을 수 있으므로 8자리
                                   RESERVATION_ID NUMBER(6) NOT NULL,
                                   SEAT_ID NUMBER(3) NOT NULL,
                                   CONSTRAINT FK_RES_SEATS_RESERVATION FOREIGN KEY (RESERVATION_ID) REFERENCES RESERVATIONS(RESERVATION_ID),
                                   CONSTRAINT FK_RES_SEATS_SEAT FOREIGN KEY (SEAT_ID) REFERENCES SEATS(SEAT_ID)
);

CREATE SEQUENCE SEQ_RESERVATION_SEAT_ID START WITH 1 INCREMENT BY 1 MAXVALUE 99999999;

-- ========================================
-- 기본 데이터 삽입 (크기 제한에 맞춰 수정)
-- ========================================

-- 상영관 데이터 (ROOM_ID는 1~99 범위)
INSERT INTO ROOMS (ROOM_ID, ROOM_NAME, TOTAL_SEATS) VALUES (1, '1관', 60);
INSERT INTO ROOMS (ROOM_ID, ROOM_NAME, TOTAL_SEATS) VALUES (2, '2관', 80);
INSERT INTO ROOMS (ROOM_ID, ROOM_NAME, TOTAL_SEATS) VALUES (3, 'IMAX관', 100);

-- 영화 데이터 (MOVIE_ID는 1~999 범위)
INSERT INTO MOVIES (MOVIE_ID, TITLE, GENRE, RATING, RUNNING_TIME, POSTER_URL)
VALUES (1, '인사이드 아웃 2', '애니메이션', '전체관람가', 96, '/images/insideout2.jpg');

INSERT INTO MOVIES (MOVIE_ID, TITLE, GENRE, RATING, RUNNING_TIME, POSTER_URL)
VALUES (2, '디스피커블 미 4', '애니메이션', '전체관람가', 94, '/images/despicable4.jpg');

INSERT INTO MOVIES (MOVIE_ID, TITLE, GENRE, RATING, RUNNING_TIME, POSTER_URL)
VALUES (3, '탈주', '액션', '15세관람가', 109, '/images/escape.jpg');

-- 좌석 데이터 (SEAT_ID 1~999, ROOM_ID 1~99, SEAT_NUMBER 1~999 범위)
-- 1관: A~F행, 각 10석 (총 60석)
DECLARE
    v_seat_id NUMBER(3) := 1;
    v_room_id NUMBER(2) := 1;
BEGIN
    FOR row_num IN 1..6 LOOP  -- A~F행
    FOR seat_num IN 1..10 LOOP  -- 1~10번 좌석
    INSERT INTO SEATS (SEAT_ID, ROOM_ID, SEAT_ROW, SEAT_NUMBER, STATUS)
    VALUES (v_seat_id, v_room_id, CHR(64 + row_num), seat_num, '사용가능');
    v_seat_id := v_seat_id + 1;
        END LOOP;
        END LOOP;
END;
/

-- 2관: A~H행, 각 10석 (총 80석)
DECLARE
    v_seat_id NUMBER(3) := 61;  -- 1관 다음부터 시작
    v_room_id NUMBER(2) := 2;
BEGIN
    FOR row_num IN 1..8 LOOP  -- A~H행
    FOR seat_num IN 1..10 LOOP  -- 1~10번 좌석
    INSERT INTO SEATS (SEAT_ID, ROOM_ID, SEAT_ROW, SEAT_NUMBER, STATUS)
    VALUES (v_seat_id, v_room_id, CHR(64 + row_num), seat_num, '사용가능');
    v_seat_id := v_seat_id + 1;
        END LOOP;
        END LOOP;
END;
/

-- 상영시간 데이터 (RUNTIME_ID는 1~9999 범위)
INSERT INTO RUNTIMES (RUNTIME_ID, MOVIE_ID, ROOM_ID, RUN_DATE, START_TIME, PRICE, AVAILABLE_SEATS)
VALUES (1, 1, 1, CURRENT_DATE, '10:00', 12000, 60);

INSERT INTO RUNTIMES (RUNTIME_ID, MOVIE_ID, ROOM_ID, RUN_DATE, START_TIME, PRICE, AVAILABLE_SEATS)
VALUES (2, 1, 1, CURRENT_DATE, '14:30', 12000, 60);

INSERT INTO RUNTIMES (RUNTIME_ID, MOVIE_ID, ROOM_ID, RUN_DATE, START_TIME, PRICE, AVAILABLE_SEATS)
VALUES (3, 2, 1, CURRENT_DATE, '19:00', 12000, 60);

INSERT INTO RUNTIMES (RUNTIME_ID, MOVIE_ID, ROOM_ID, RUN_DATE, START_TIME, PRICE, AVAILABLE_SEATS)
VALUES (4, 2, 2, CURRENT_DATE, '11:00', 12000, 80);

INSERT INTO RUNTIMES (RUNTIME_ID, MOVIE_ID, ROOM_ID, RUN_DATE, START_TIME, PRICE, AVAILABLE_SEATS)
VALUES (5, 3, 2, CURRENT_DATE, '16:00', 12000, 80);

-- 내일 상영시간도 추가
INSERT INTO RUNTIMES (RUNTIME_ID, MOVIE_ID, ROOM_ID, RUN_DATE, START_TIME, PRICE, AVAILABLE_SEATS)
VALUES (6, 1, 1, CURRENT_DATE + 1, '10:00', 12000, 60);

INSERT INTO RUNTIMES (RUNTIME_ID, MOVIE_ID, ROOM_ID, RUN_DATE, START_TIME, PRICE, AVAILABLE_SEATS)
VALUES (7, 2, 1, CURRENT_DATE + 1, '14:30', 12000, 60);

INSERT INTO RUNTIMES (RUNTIME_ID, MOVIE_ID, ROOM_ID, RUN_DATE, START_TIME, PRICE, AVAILABLE_SEATS)
VALUES (8, 3, 2, CURRENT_DATE + 1, '18:00', 12000, 80);

-- 사용자 데이터
INSERT INTO USERS (U_ID, u_pw, U_nickname, U_name, u_birth, u_address)
VALUES (1, 'password123', 'testuser', '김테스트', DATE '1990-01-01', '서울시 강남구');

INSERT INTO USERS (U_ID, u_pw, U_nickname, U_name, u_birth, u_address)
VALUES (2, 'password456', 'moviefan', '이영화', DATE '1985-05-15', '서울시 서초구');

-- 커밋
COMMIT;

-- ========================================
-- 수정된 뷰 생성
-- ========================================

-- 상영시간 정보 뷰
CREATE OR REPLACE VIEW V_SHOWTIME_LIST AS
SELECT
    r.RUNTIME_ID,
    m.TITLE,
    m.GENRE,
    m.RATING,
    rm.ROOM_NAME,
    r.RUN_DATE,
    r.START_TIME,
    r.PRICE,
    r.AVAILABLE_SEATS,
    rm.TOTAL_SEATS
FROM RUNTIMES r
         JOIN MOVIES m ON r.MOVIE_ID = m.MOVIE_ID
         JOIN ROOMS rm ON r.ROOM_ID = rm.ROOM_ID
WHERE r.RUN_DATE >= TRUNC(SYSDATE);

-- 예약 상세 정보 뷰
CREATE OR REPLACE VIEW V_RESERVATION_DETAIL AS
SELECT
    res.RESERVATION_ID,
    u.U_nickname AS USER_NICKNAME,
    u.U_name AS USER_NAME,
    m.TITLE AS MOVIE_TITLE,
    rm.ROOM_NAME,
    rt.RUN_DATE,
    rt.START_TIME,
    LISTAGG(s.SEAT_ROW || s.SEAT_NUMBER, ', ')
            WITHIN GROUP (ORDER BY s.SEAT_ROW, s.SEAT_NUMBER) AS SEATS,
    res.TOTAL_AMOUNT,
    res.RESERVATION_STATUS
FROM RESERVATIONS res
         JOIN USERS u ON res.U_ID = u.U_ID
         JOIN RUNTIMES rt ON res.RUNTIME_ID = rt.RUNTIME_ID
         JOIN MOVIES m ON rt.MOVIE_ID = m.MOVIE_ID
         JOIN ROOMS rm ON rt.ROOM_ID = rm.ROOM_ID
         JOIN RESERVATION_SEATS rs ON res.RESERVATION_ID = rs.RESERVATION_ID
         JOIN SEATS s ON rs.SEAT_ID = s.SEAT_ID
GROUP BY res.RESERVATION_ID, u.U_nickname, u.U_name, m.TITLE, rm.ROOM_NAME,
         rt.RUN_DATE, rt.START_TIME, res.TOTAL_AMOUNT, res.RESERVATION_STATUS;

-- ========================================
-- H2 Database용 수정된 data.sql
-- ========================================

-- H2에서는 Oracle의 CHAR(1) 대신 VARCHAR(1) 사용
-- 그리고 시퀀스 대신 IDENTITY 사용 가능

-- ROOMS 데이터
INSERT INTO ROOMS (ROOM_ID, ROOM_NAME, TOTAL_SEATS) VALUES (1, '1관', 60);
INSERT INTO ROOMS (ROOM_ID, ROOM_NAME, TOTAL_SEATS) VALUES (2, '2관', 80);

-- MOVIES 데이터
INSERT INTO MOVIES (MOVIE_ID, TITLE, GENRE, RATING, RUNNING_TIME, POSTER_URL)
VALUES (1, '인사이드 아웃 2', '애니메이션', '전체관람가', 96, '/images/insideout2.jpg');

INSERT INTO MOVIES (MOVIE_ID, TITLE, GENRE, RATING, RUNNING_TIME, POSTER_URL)
VALUES (2, '디스피커블 미 4', '애니메이션', '전체관람가', 94, '/images/despicable4.jpg');

INSERT INTO MOVIES (MOVIE_ID, TITLE, GENRE, RATING, RUNNING_TIME, POSTER_URL)
VALUES (3, '탈주', '액션', '15세관람가', 109, '/images/escape.jpg');

-- SEATS 데이터 (1관: A~F행, 각 10석)
-- H2에서는 복잡한 PL/SQL 대신 단순한 INSERT 사용
INSERT INTO SEATS (SEAT_ID, ROOM_ID, SEAT_ROW, SEAT_NUMBER, STATUS) VALUES
                                                                        (1, 1, 'A', 1, '사용가능'), (2, 1, 'A', 2, '사용가능'), (3, 1, 'A', 3, '사용가능'), (4, 1, 'A', 4, '사용가능'), (5, 1, 'A', 5, '사용가능'),
                                                                        (6, 1, 'A', 6, '사용가능'), (7, 1, 'A', 7, '사용가능'), (8, 1, 'A', 8, '사용가능'), (9, 1, 'A', 9, '사용가능'), (10, 1, 'A', 10, '사용가능'),
                                                                        (11, 1, 'B', 1, '사용가능'), (12, 1, 'B', 2, '사용가능'), (13, 1, 'B', 3, '사용가능'), (14, 1, 'B', 4, '사용가능'), (15, 1, 'B', 5, '사용가능'),
                                                                        (16, 1, 'B', 6, '사용가능'), (17, 1, 'B', 7, '사용가능'), (18, 1, 'B', 8, '사용가능'), (19, 1, 'B', 9, '사용가능'), (20, 1, 'B', 10, '사용가능'),
                                                                        (21, 1, 'C', 1, '사용가능'), (22, 1, 'C', 2, '사용가능'), (23, 1, 'C', 3, '사용가능'), (24, 1, 'C', 4, '사용가능'), (25, 1, 'C', 5, '사용가능'),
                                                                        (26, 1, 'C', 6, '사용가능'), (27, 1, 'C', 7, '사용가능'), (28, 1, 'C', 8, '사용가능'), (29, 1, 'C', 9, '사용가능'), (30, 1, 'C', 10, '사용가능'),
                                                                        (31, 1, 'D', 1, '사용가능'), (32, 1, 'D', 2, '사용가능'), (33, 1, 'D', 3, '사용가능'), (34, 1, 'D', 4, '사용가능'), (35, 1, 'D', 5, '사용가능'),
                                                                        (36, 1, 'D', 6, '사용가능'), (37, 1, 'D', 7, '사용가능'), (38, 1, 'D', 8, '사용가능'), (39, 1, 'D', 9, '사용가능'), (40, 1, 'D', 10, '사용가능'),
                                                                        (41, 1, 'E', 1, '사용가능'), (42, 1, 'E', 2, '사용가능'), (43, 1, 'E', 3, '사용가능'), (44, 1, 'E', 4, '사용가능'), (45, 1, 'E', 5, '사용가능'),
                                                                        (46, 1, 'E', 6, '사용가능'), (47, 1, 'E', 7, '사용가능'), (48, 1, 'E', 8, '사용가능'), (49, 1, 'E', 9, '사용가능'), (50, 1, 'E', 10, '사용가능'),
                                                                        (51, 1, 'F', 1, '사용가능'), (52, 1, 'F', 2, '사용가능'), (53, 1, 'F', 3, '사용가능'), (54, 1, 'F', 4, '사용가능'), (55, 1, 'F', 5, '사용가능'),
                                                                        (56, 1, 'F', 6, '사용가능'), (57, 1, 'F', 7, '사용가능'), (58, 1, 'F', 8, '사용가능'), (59, 1, 'F', 9, '사용가능'), (60, 1, 'F', 10, '사용가능');

-- RUNTIMES 데이터 (오늘과 내일)
INSERT INTO RUNTIMES (RUNTIME_ID, MOVIE_ID, ROOM_ID, RUN_DATE, START_TIME, PRICE, AVAILABLE_SEATS)
VALUES (1, 1, 1, CURRENT_DATE, '10:00', 12000, 60);

INSERT INTO RUNTIMES (RUNTIME_ID, MOVIE_ID, ROOM_ID, RUN_DATE, START_TIME, PRICE, AVAILABLE_SEATS)
VALUES (2, 1, 1, CURRENT_DATE, '14:30', 12000, 60);

INSERT INTO RUNTIMES (RUNTIME_ID, MOVIE_ID, ROOM_ID, RUN_DATE, START_TIME, PRICE, AVAILABLE_SEATS)
VALUES (3, 2, 1, CURRENT_DATE, '19:00', 12000, 60);

INSERT INTO RUNTIMES (RUNTIME_ID, MOVIE_ID, ROOM_ID, RUN_DATE, START_TIME, PRICE, AVAILABLE_SEATS)
VALUES (4, 3, 1, CURRENT_DATE, '21:30', 12000, 60);

-- 내일 상영시간
INSERT INTO RUNTIMES (RUNTIME_ID, MOVIE_ID, ROOM_ID, RUN_DATE, START_TIME, PRICE, AVAILABLE_SEATS)
VALUES (5, 1, 1, CURRENT_DATE + 1, '10:00', 12000, 60);

INSERT INTO RUNTIMES (RUNTIME_ID, MOVIE_ID, ROOM_ID, RUN_DATE, START_TIME, PRICE, AVAILABLE_SEATS)
VALUES (6, 2, 1, CURRENT_DATE + 1, '14:30', 12000, 60);

-- USERS 데이터
INSERT INTO USERS (U_ID, u_pw, U_nickname, U_name, u_birth, u_address)
VALUES (1, 'password123', 'testuser', '김테스트', DATE '1990-01-01', '서울시 강남구');

INSERT INTO USERS (U_ID, u_pw, U_nickname, U_name, u_birth, u_address)
VALUES (2, 'password456', 'moviefan', '이영화', DATE '1985-05-15', '서울시 서초구');

-- ========================================
-- 오류 해결 포인트
-- ========================================

/*
🚨 ORA-01401 오류 해결 사항:

1. NUMBER 컬럼 크기 명시
   - SEAT_ID: NUMBER(3) → 최대 999
   - ROOM_ID: NUMBER(2) → 최대 99
   - SEAT_NUMBER: NUMBER(3) → 최대 999

2. 시퀀스 MAXVALUE 설정
   - 각 시퀀스마다 컬럼 크기에 맞는 MAXVALUE 설정
   - MAXVALUE 999, MAXVALUE 99 등

3. 데이터 삽입 시 주의사항
   - 모든 값이 정의된 범위 내에 있는지 확인
   - SEAT_ID 1~999, ROOM_ID 1~99 범위 준수

4. 포트폴리오용 최적화
   - 실제 극장 규모에 맞는 현실적인 크기
   - 1관 60석, 2관 80석으로 설정
   - 3일치 상영시간 데이터 제공

✅ 이제 모든 컬럼이 정의된 크기 범위 내에서 동작합니다!
*/

CREATE TABLE TAGS(
                     TAG_ID NUMBER(3) PRIMARY KEY,
                     TAG_NAME varchar2 (40) UNIQUE NOT NULL,
                     TAG_TYPE varchar2 (10) NOT NULL
);

CREATE SEQUENCE SEQ_TAGS START WITH 1 INCREMENT BY 1 MAXVALUE 999;

-- Genre (장르) 8개
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'Action', 'Genre');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'Comedy', 'Genre');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'Drama', 'Genre');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'Thriller', 'Genre');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'Horror', 'Genre');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'Romance', 'Genre');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'Fantasy', 'Genre');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'Sci-Fi', 'Genre');

-- Studio (제작사) 7개
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'Marvel Studios', 'Studio');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'Pixar', 'Studio');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'Warner Bros.', 'Studio');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'Disney', 'Studio');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'Paramount', 'Studio');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'Universal', 'Studio');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'Studio Ghibli', 'Studio');

-- Country (국가) 7개
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'USA', 'Country');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'Japan', 'Country');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'France', 'Country');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'UK', 'Country');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'South Korea', 'Country');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'India', 'Country');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'Germany', 'Country');

-- Mood (분위기) 8개
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'Dark', 'Mood');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'Lighthearted', 'Mood');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'Suspenseful', 'Mood');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'Romantic', 'Mood');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'Inspiring', 'Mood');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'Melancholic', 'Mood');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'Uplifting', 'Mood');
INSERT INTO TAGS (TAG_ID, TAG_NAME, TAG_TYPE) VALUES (SEQ_TAGS.NEXTVAL, 'Violent', 'Mood');

select * from TAGS;


SELECT * FROM MOVIES;

CREATE TABLE MOVIE_TAGS (
                            MOVIE_ID NUMBER(3),
                            TAG_ID NUMBER(3) ,
                            PRIMARY KEY (MOVIE_ID, TAG_ID),
                            FOREIGN KEY (MOVIE_ID) REFERENCES MOVIES(MOVIE_ID) ON DELETE CASCADE,
                            FOREIGN KEY (TAG_ID) REFERENCES TAGS(TAG_ID) ON DELETE CASCADE
);
-- Inside Out 2 (Movie_ID = 1)
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (1, 2);  -- Comedy
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (1, 12); -- Disney
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (1, 16); -- USA
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (1, 24); -- Lighthearted
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (1, 27); -- Inspiring

-- Despicable Me 4 (Movie_ID = 2)
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (2, 2);  -- Comedy
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (2, 14); -- Universal
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (2, 16); -- USA
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (2, 24); -- Lighthearted

-- 탈주 (Movie_ID = 3)
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (3, 3);  -- Drama
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (3, 20); -- South Korea
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (3, 23); -- Dark
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (3, 28); -- Melancholic

-- 파일럿 (Movie_ID = 4)
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (4, 4);  -- Thriller
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (4, 20); -- South Korea
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (4, 25); -- Suspenseful

-- 트위스터스 (Movie_ID = 5)
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (5, 1);  -- Action
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (5, 16); -- USA
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (5, 30); -- Violent

-- 헤드리거 (Movie_ID = 6)
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (6, 5);  -- Horror
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (6, 16); -- USA
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (6, 23); -- Dark

-- 베놈: 라스트 댄스 (Movie_ID = 7)
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (7, 1);  -- Action
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (7, 9);  -- Marvel Studios
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (7, 16); -- USA
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (7, 30); -- Violent

-- 위키드 (Movie_ID = 8)
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (8, 7);  -- Fantasy
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (8, 12); -- Disney
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (8, 16); -- USA
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (8, 26); -- Romantic

-- 글래디에이터 2 (Movie_ID = 9)
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (9, 1);  -- Action
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (9, 13); -- Paramount
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (9, 19); -- UK
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (9, 23); -- Dark
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (9, 30); -- Violent

-- 모아나 2 (Movie_ID = 10)
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (10, 7);  -- Fantasy
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (10, 12); -- Disney
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (10, 16); -- USA
INSERT INTO MOVIE_TAGS (MOVIE_ID, TAG_ID) VALUES (10, 27); -- Inspiring

SELECT column_name, data_type
FROM user_tab_columns
WHERE table_name = 'TAGS';

