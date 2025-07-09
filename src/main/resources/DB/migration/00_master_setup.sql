-- ========================================
-- Phoenix Cinema Database 마스터 설정 스크립트
-- ========================================
--
-- 이 스크립트는 Phoenix Cinema 시스템의 모든 데이터베이스 객체를 생성합니다.
-- 순서대로 실행하여 완전한 데이터베이스를 구축할 수 있습니다.
--
-- 실행 순서:
-- 1. 사용자 테이블
-- 2. 상영관 테이블
-- 3. 좌석 테이블
-- 4. 영화 테이블
-- 5. 상영시간 테이블
-- 6. 예약 테이블
-- 7. 예약 좌석 테이블
-- 8. 뷰 및 인덱스
--
-- ========================================

-- 기존 객체 삭제 (선택사항 - 초기화 시에만 사용)
/*
DROP VIEW V_DAILY_SALES CASCADE CONSTRAINTS;
DROP VIEW V_ROOM_UTILIZATION CASCADE CONSTRAINTS;
DROP VIEW V_MOVIE_SALES_STATS CASCADE CONSTRAINTS;
DROP VIEW V_RESERVATION_DETAIL CASCADE CONSTRAINTS;
DROP VIEW V_SHOWTIME_LIST CASCADE CONSTRAINTS;

DROP TABLE RESERVATION_SEATS CASCADE CONSTRAINTS;
DROP TABLE RESERVATIONS CASCADE CONSTRAINTS;
DROP TABLE RUNTIMES CASCADE CONSTRAINTS;
DROP TABLE MOVIES CASCADE CONSTRAINTS;
DROP TABLE SEATS CASCADE CONSTRAINTS;
DROP TABLE ROOMS CASCADE CONSTRAINTS;
DROP TABLE USERS CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_RESERVATION_SEAT_ID;
DROP SEQUENCE SEQ_RESERVATION_ID;
DROP SEQUENCE SEQ_RUNTIME_ID;
DROP SEQUENCE SEQ_MOVIE_ID;
DROP SEQUENCE SEQ_SEAT_ID;
DROP SEQUENCE SEQ_ROOM_ID;
DROP SEQUENCE SEQ_U_ID;
*/

-- ========================================
-- 실행 시작
-- ========================================

PROMPT ========================================
PROMPT Phoenix Cinema Database Setup 시작
PROMPT ========================================

-- 1. 사용자 테이블 생성
PROMPT 1. 사용자 테이블 생성 중...
@@01_users.sql

-- 2. 상영관 테이블 생성
PROMPT 2. 상영관 테이블 생성 중...
@@02_rooms.sql

-- 3. 좌석 테이블 생성
PROMPT 3. 좌석 테이블 생성 중...
@@03_seats.sql

-- 4. 영화 테이블 생성
PROMPT 4. 영화 테이블 생성 중...
@@04_movies.sql

-- 5. 상영시간 테이블 생성
PROMPT 5. 상영시간 테이블 생성 중...
@@05_runtimes.sql

-- 6. 예약 테이블 생성
PROMPT 6. 예약 테이블 생성 중...
@@06_reservations.sql

-- 7. 예약 좌석 테이블 생성
PROMPT 7. 예약 좌석 테이블 생성 중...
@@07_reservation_seats.sql

-- 8. 뷰 및 인덱스 생성
PROMPT 8. 뷰 및 인덱스 생성 중...
@@08_views_and_indexes.sql

-- ========================================
-- 설정 완료 및 확인
-- ========================================

PROMPT ========================================
PROMPT 데이터베이스 설정 완료!
PROMPT ========================================

-- 생성된 테이블 확인
PROMPT 생성된 테이블 목록:
SELECT TABLE_NAME, NUM_ROWS
FROM USER_TABLES
WHERE TABLE_NAME IN ('USERS', 'ROOMS', 'SEATS', 'MOVIES', 'RUNTIMES', 'RESERVATIONS', 'RESERVATION_SEATS')
ORDER BY TABLE_NAME;

-- 생성된 뷰 확인
PROMPT 생성된 뷰 목록:
SELECT VIEW_NAME
FROM USER_VIEWS
WHERE VIEW_NAME LIKE 'V_%'
ORDER BY VIEW_NAME;

-- 생성된 시퀀스 확인
PROMPT 생성된 시퀀스 목록:
SELECT SEQUENCE_NAME, LAST_NUMBER
FROM USER_SEQUENCES
WHERE SEQUENCE_NAME LIKE 'SEQ_%'
ORDER BY SEQUENCE_NAME;

-- 데이터 요약 통계
PROMPT ========================================
PROMPT 데이터 요약 통계
PROMPT ========================================

SELECT
    '사용자' as 구분,
    COUNT(*) as 개수
FROM USERS
UNION ALL
SELECT
    '상영관' as 구분,
    COUNT(*) as 개수
FROM ROOMS
UNION ALL
SELECT
    '좌석' as 구분,
    COUNT(*) as 개수
FROM SEATS
UNION ALL
SELECT
    '영화' as 구분,
    COUNT(*) as 개수
FROM MOVIES
UNION ALL
SELECT
    '상영시간' as 구분,
    COUNT(*) as 개수
FROM RUNTIMES
UNION ALL
SELECT
    '예약' as 구분,
    COUNT(*) as 개수
FROM RESERVATIONS
UNION ALL
SELECT
    '예약좌석' as 구분,
    COUNT(*) as 개수
FROM RESERVATION_SEATS;

PROMPT ========================================
PROMPT Phoenix Cinema Database 설정 완료!
PROMPT 이제 Spring Boot 애플리케이션을 실행할 수 있습니다.
PROMPT ========================================

-- 최종 커밋
COMMIT;