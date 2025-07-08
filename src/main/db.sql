-- ========================================
-- 1. 사용자 테이블 (간소화)
-- ========================================
CREATE TABLE USERS (
                       USER_ID NUMBER PRIMARY KEY,
                       USERNAME VARCHAR2(50) NOT NULL UNIQUE,
                       PASSWORD VARCHAR2(100) NOT NULL,
                       EMAIL VARCHAR2(100) NOT NULL UNIQUE,
                       MEMBERSHIP_TIER VARCHAR2(10) DEFAULT 'BRONZE'
);

CREATE SEQUENCE SEQ_USER_ID START WITH 1 INCREMENT BY 1;

-- ========================================
-- 2. 상영관 테이블
-- ========================================
CREATE TABLE ROOMS (
                       ROOM_ID NUMBER PRIMARY KEY,
                       ROOM_NAME VARCHAR2(20) NOT NULL, -- '1관', '2관'
                       TOTAL_SEATS NUMBER NOT NULL
);

-- ========================================
-- 3. 좌석 테이블 (기존 구조 유지)
-- ========================================
CREATE TABLE SEATS (
                       SEAT_ID NUMBER PRIMARY KEY,
                       ROOM_ID NUMBER NOT NULL,
                       SEAT_ROW CHAR(1) NOT NULL, -- A, B, C...
                       SEAT_NUMBER NUMBER NOT NULL, -- 1, 2, 3...
                       STATUS VARCHAR2(10) DEFAULT '사용가능',
                       CONSTRAINT FK_SEATS_ROOM FOREIGN KEY (ROOM_ID) REFERENCES ROOMS(ROOM_ID)
);

CREATE SEQUENCE SEQ_SEAT_ID START WITH 1 INCREMENT BY 1;

-- ========================================
-- 4. 영화 테이블 (필수 정보만 추가)
-- ========================================
CREATE TABLE MOVIES (
                        MOVIE_ID NUMBER PRIMARY KEY,
                        TITLE VARCHAR2(100) NOT NULL,
                        GENRE VARCHAR2(50) NOT NULL,
                        RATING VARCHAR2(20) NOT NULL, -- 전체관람가, 12세관람가, 15세관람가
                        RUNNING_TIME NUMBER NOT NULL, -- 상영시간(분)
                        POSTER_URL VARCHAR2(500)
);

CREATE SEQUENCE SEQ_MOVIE_ID START WITH 1 INCREMENT BY 1;

-- ========================================
-- 5. 상영시간 테이블 (기존 구조 개선)
-- ========================================
CREATE TABLE RUNTIMES (
                          RUNTIME_ID NUMBER PRIMARY KEY,
                          MOVIE_ID NUMBER NOT NULL,
                          ROOM_ID NUMBER NOT NULL,
                          RUN_DATE DATE NOT NULL,
                          START_TIME VARCHAR2(5) NOT NULL, -- '10:00', '14:30' 형태
                          PRICE NUMBER DEFAULT 12000 NOT NULL,
                          AVAILABLE_SEATS NUMBER NOT NULL,
                          CONSTRAINT FK_RUNTIMES_MOVIE FOREIGN KEY (MOVIE_ID) REFERENCES MOVIES(MOVIE_ID),
                          CONSTRAINT FK_RUNTIMES_ROOM FOREIGN KEY (ROOM_ID) REFERENCES ROOMS(ROOM_ID)
);

CREATE SEQUENCE SEQ_RUNTIME_ID START WITH 1 INCREMENT BY 1;

-- ========================================
-- 6. 예약 테이블 (기존 구조 + 최소 수정)
-- ========================================
CREATE TABLE RESERVATIONS (
                              RESERVATION_ID NUMBER PRIMARY KEY,
                              USER_ID NUMBER NOT NULL, -- 데이터 타입 통일
                              RUNTIME_ID NUMBER NOT NULL,
                              ADULT NUMBER DEFAULT 0,
                              YOUTH NUMBER DEFAULT 0,
                              CHILD NUMBER DEFAULT 0,
                              TOTAL_AMOUNT NUMBER NOT NULL,
                              RESERVATION_STATUS VARCHAR2(10) DEFAULT '예약완료',
                              RESERVED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                              CONSTRAINT FK_RESERVATIONS_USER FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
                              CONSTRAINT FK_RESERVATIONS_RUNTIME FOREIGN KEY (RUNTIME_ID) REFERENCES RUNTIMES(RUNTIME_ID)
);

CREATE SEQUENCE SEQ_RESERVATION_ID START WITH 1 INCREMENT BY 1;

-- ========================================
-- 7. 예약 좌석 테이블 (기존 구조 유지)
-- ========================================
CREATE TABLE RESERVATION_SEATS (
                                   RESERVATION_SEAT_ID NUMBER PRIMARY KEY,
                                   RESERVATION_ID NUMBER NOT NULL,
                                   SEAT_ID NUMBER NOT NULL,
                                   CONSTRAINT FK_RES_SEATS_RESERVATION FOREIGN KEY (RESERVATION_ID) REFERENCES RESERVATIONS(RESERVATION_ID),
                                   CONSTRAINT FK_RES_SEATS_SEAT FOREIGN KEY (SEAT_ID) REFERENCES SEATS(SEAT_ID)
);

CREATE SEQUENCE SEQ_RESERVATION_SEAT_ID START WITH 1 INCREMENT BY 1;

-- ========================================
-- 기본 데이터 삽입 (포트폴리오용)
-- ========================================

-- 상영관 데이터
INSERT INTO ROOMS VALUES (1, '1관', 100);
INSERT INTO ROOMS VALUES (2, '2관', 120);

-- 좌석 데이터 (1관: A~F행, 각 10석)
DECLARE
    v_seat_id NUMBER := 1;
BEGIN
    FOR room_num IN 1..2 LOOP
            FOR row_num IN 1..6 LOOP
                    FOR seat_num IN 1..10 LOOP
                            INSERT INTO SEATS VALUES (
                                                         v_seat_id,
                                                         room_num,
                                                         CHR(64 + row_num), -- A, B, C...
                                                         seat_num,
                                                         '사용가능'
                                                     );
                            v_seat_id := v_seat_id + 1;
                        END LOOP;
                END LOOP;
        END LOOP;
END;
/

-- 영화 데이터 (포트폴리오용 샘플)
INSERT INTO MOVIES VALUES (1, '인사이드 아웃 2', '애니메이션', '전체관람가', 96, '/images/insideout2.jpg');
INSERT INTO MOVIES VALUES (2, '디스피커블 미 4', '애니메이션', '전체관람가', 94, '/images/despicable4.jpg');
INSERT INTO MOVIES VALUES (3, '탈주', '액션', '15세관람가', 109, '/images/escape.jpg');
INSERT INTO MOVIES VALUES (4, '파일럿', '코미디', '12세관람가', 100, '/images/pilot.jpg');

-- 상영시간 데이터 (오늘부터 일주일)
DECLARE
    v_base_date DATE := TRUNC(SYSDATE);
    v_runtime_id NUMBER := 1;
BEGIN
    -- 각 영화별로 3일간 상영
    FOR movie_id IN 1..4 LOOP
            FOR day_offset IN 0..2 LOOP
                    -- 하루에 3번 상영
                    INSERT INTO RUNTIMES VALUES (v_runtime_id, movie_id, 1, v_base_date + day_offset, '10:00', 12000, 100);
                    v_runtime_id := v_runtime_id + 1;

                    INSERT INTO RUNTIMES VALUES (v_runtime_id, movie_id, 1, v_base_date + day_offset, '14:30', 12000, 100);
                    v_runtime_id := v_runtime_id + 1;

                    INSERT INTO RUNTIMES VALUES (v_runtime_id, movie_id, 1, v_base_date + day_offset, '19:00', 12000, 100);
                    v_runtime_id := v_runtime_id + 1;
                END LOOP;
        END LOOP;
END;
/

-- 테스트 사용자 추가
INSERT INTO USERS VALUES (1, 'testuser', 'password123', 'test@example.com', 'BRONZE');

-- ========================================
-- 간단한 뷰 (포트폴리오 시연용)
-- ========================================

-- 상영시간 정보 뷰 (간소화)
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

-- 예약 정보 뷰 (간소화)
CREATE OR REPLACE VIEW V_MY_RESERVATIONS AS
SELECT
    res.RESERVATION_ID,
    u.USERNAME,
    m.TITLE,
    rm.ROOM_NAME,
    rt.RUN_DATE,
    rt.START_TIME,
    LISTAGG(s.SEAT_ROW || s.SEAT_NUMBER, ', ')
            WITHIN GROUP (ORDER BY s.SEAT_ROW, s.SEAT_NUMBER) AS SEATS,
    res.TOTAL_AMOUNT,
    res.RESERVATION_STATUS
FROM RESERVATIONS res
         JOIN USERS u ON res.USER_ID = u.USER_ID
         JOIN RUNTIMES rt ON res.RUNTIME_ID = rt.RUNTIME_ID
         JOIN MOVIES m ON rt.MOVIE_ID = m.MOVIE_ID
         JOIN ROOMS rm ON rt.ROOM_ID = rm.ROOM_ID
         JOIN RESERVATION_SEATS rs ON res.RESERVATION_ID = rs.RESERVATION_ID
         JOIN SEATS s ON rs.SEAT_ID = s.SEAT_ID
GROUP BY res.RESERVATION_ID, u.USERNAME, m.TITLE, rm.ROOM_NAME,
         rt.RUN_DATE, rt.START_TIME, res.TOTAL_AMOUNT, res.RESERVATION_STATUS;

COMMIT;