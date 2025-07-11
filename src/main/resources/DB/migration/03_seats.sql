-- ========================================
-- 3. 좌석 테이블 (SEATS)
-- ========================================

-- 테이블 생성
CREATE TABLE SEATS (
                       SEAT_ID NUMBER(3) PRIMARY KEY,       -- 최대 999개 좌석
                       ROOM_ID NUMBER(2) NOT NULL,          -- 최대 99개 상영관
                       SEAT_ROW CHAR(1) NOT NULL,           -- A, B, C...
                       SEAT_NUMBER NUMBER(3) NOT NULL,      -- 최대 999번 좌석
                       STATUS VARCHAR2(20) DEFAULT '사용가능',
                       CONSTRAINT FK_SEATS_ROOM FOREIGN KEY (ROOM_ID) REFERENCES ROOMS(ROOM_ID)
);

-- 시퀀스 생성
CREATE SEQUENCE SEQ_SEAT_ID START WITH 1 INCREMENT BY 1 MAXVALUE 999;

-- 1관 좌석 데이터 (A~F행, 각 10석, 총 60석)
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

-- 2관 좌석 데이터 (A~H행, 각 10석, 총 80석)
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

-- ========================================
-- 비어있는 상영관의 좌석 데이터 추가
-- ========================================

-- 3관 IMAX관 좌석 데이터 (A~J행, 각 10석, 총 100석)
-- SEAT_ID 141부터 시작
DECLARE
v_seat_id NUMBER(3) := 141;  -- 기존 데이터 다음부터 시작
    v_room_id NUMBER(2) := 3;    -- IMAX관
BEGIN
FOR row_num IN 1..10 LOOP  -- A~J행
        FOR seat_num IN 1..10 LOOP  -- 1~10번 좌석
            INSERT INTO SEATS (SEAT_ID, ROOM_ID, SEAT_ROW, SEAT_NUMBER, STATUS)
            VALUES (v_seat_id, v_room_id, CHR(64 + row_num), seat_num, '사용가능');
            v_seat_id := v_seat_id + 1;
END LOOP;
END LOOP;
END;
/

-- 4관 좌석 데이터 (A~J행, 각 10석, 총 100석)
-- SEAT_ID 241부터 시작
DECLARE
v_seat_id NUMBER(3) := 241;  -- IMAX관 다음부터 시작
    v_room_id NUMBER(2) := 4;    -- 4관
BEGIN
FOR row_num IN 1..10 LOOP  -- A~J행
        FOR seat_num IN 1..10 LOOP  -- 1~10번 좌석
            INSERT INTO SEATS (SEAT_ID, ROOM_ID, SEAT_ROW, SEAT_NUMBER, STATUS)
            VALUES (v_seat_id, v_room_id, CHR(64 + row_num), seat_num, '사용가능');
            v_seat_id := v_seat_id + 1;
END LOOP;
END LOOP;
END;
/

-- 5관 PR관 좌석 데이터 (A~E행, 각 10석, 총 50석)
-- SEAT_ID 341부터 시작
DECLARE
v_seat_id NUMBER(3) := 341;  -- 4관 다음부터 시작
    v_room_id NUMBER(2) := 5;    -- PR관
BEGIN
FOR row_num IN 1..5 LOOP  -- A~E행
        FOR seat_num IN 1..10 LOOP  -- 1~10번 좌석
            INSERT INTO SEATS (SEAT_ID, ROOM_ID, SEAT_ROW, SEAT_NUMBER, STATUS)
            VALUES (v_seat_id, v_room_id, CHR(64 + row_num), seat_num, '사용가능');
            v_seat_id := v_seat_id + 1;
END LOOP;
END LOOP;
END;
/

-- 커밋
COMMIT;

-- ========================================
-- 확인 쿼리
-- ========================================

-- 상영관별 좌석 수 확인
SELECT
    r.ROOM_ID,
    r.ROOM_NAME,
    r.TOTAL_SEATS as "정의된_좌석수",
    COUNT(s.SEAT_ID) as "실제_좌석수",
    CASE
        WHEN r.TOTAL_SEATS = COUNT(s.SEAT_ID) THEN 'OK'
        ELSE 'ERROR'
        END as "상태"
FROM ROOMS r
         LEFT JOIN SEATS s ON r.ROOM_ID = s.ROOM_ID
GROUP BY r.ROOM_ID, r.ROOM_NAME, r.TOTAL_SEATS
ORDER BY r.ROOM_ID;

-- 새로 추가된 좌석 확인 (IMAX관)
SELECT ROOM_ID, SEAT_ROW, COUNT(*) as SEATS_PER_ROW
FROM SEATS
WHERE ROOM_ID = 3
GROUP BY ROOM_ID, SEAT_ROW
ORDER BY SEAT_ROW;

-- 새로 추가된 좌석 확인 (4관)
SELECT ROOM_ID, SEAT_ROW, COUNT(*) as SEATS_PER_ROW
FROM SEATS
WHERE ROOM_ID = 4
GROUP BY ROOM_ID, SEAT_ROW
ORDER BY SEAT_ROW;

-- 새로 추가된 좌석 확인 (PR관)
SELECT ROOM_ID, SEAT_ROW, COUNT(*) as SEATS_PER_ROW
FROM SEATS
WHERE ROOM_ID = 5
GROUP BY ROOM_ID, SEAT_ROW
ORDER BY SEAT_ROW;

-- 전체 좌석 범위 확인
SELECT
    MIN(SEAT_ID) as "최소_좌석ID",
    MAX(SEAT_ID) as "최대_좌석ID",
    COUNT(*) as "총_좌석수"
FROM SEATS;

-- 상영관별 좌석 ID 범위 확인
SELECT
    ROOM_ID,
    MIN(SEAT_ID) as "시작_ID",
    MAX(SEAT_ID) as "끝_ID",
    COUNT(*) as "좌석수"
FROM SEATS
GROUP BY ROOM_ID
ORDER BY ROOM_ID;