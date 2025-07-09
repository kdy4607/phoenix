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

-- 3관 IMAX관 좌석 데이터 (A~J행, 각 10석, 총 100석)
DECLARE
v_seat_id NUMBER(3) := 141;  -- 1,2관 다음부터 시작
    v_room_id NUMBER(2) := 3;
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

-- 4관 프리미엄관 좌석 데이터 (A~E행, 각 10석, 총 50석)
DECLARE
v_seat_id NUMBER(3) := 241;  -- 1,2,3관 다음부터 시작
    v_room_id NUMBER(2) := 4;
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

-- 5관 VIP관 좌석 데이터 (A~C행, 각 10석, 총 30석)
DECLARE
v_seat_id NUMBER(3) := 291;  -- 앞선 관들 다음부터 시작
    v_room_id NUMBER(2) := 5;
BEGIN
FOR row_num IN 1..3 LOOP  -- A~C행
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

-- 확인 쿼리
SELECT ROOM_ID, COUNT(*) as SEAT_COUNT
FROM SEATS
GROUP BY ROOM_ID
ORDER BY ROOM_ID;

-- 상영관별 좌석 배치 확인
SELECT ROOM_ID, SEAT_ROW, COUNT(*) as SEATS_PER_ROW
FROM SEATS
GROUP BY ROOM_ID, SEAT_ROW
ORDER BY ROOM_ID, SEAT_ROW;