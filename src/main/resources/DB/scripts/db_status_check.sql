-- ========================================
-- Phoenix Cinema DB 상태 확인 스크립트 (범용 버전)
-- 위치: src/main/resources/db/scripts/health-check/db_status_check.sql
-- 용도: 시스템 상태 진단 및 문제 발견
-- 호환: SQL*Plus, SQL Developer, IntelliJ, DBeaver 등 모든 클라이언트
-- ========================================

-- 실행 시작 메시지
SELECT '========================================' as "메시지" FROM DUAL
UNION ALL SELECT 'Phoenix Cinema DB 상태 확인 시작' FROM DUAL
UNION ALL SELECT '실행 시간: ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL
UNION ALL SELECT '========================================' FROM DUAL;

-- 1. 테이블 존재 여부 및 데이터 수 확인
SELECT '📊 1. 테이블 존재 여부 및 데이터 수 확인' as "검사항목" FROM DUAL;

SELECT
    table_name as "테이블명",
    CASE
        WHEN num_rows IS NULL THEN '통계 없음'
        ELSE TO_CHAR(num_rows)
        END as "데이터 수",
    CASE
        WHEN last_analyzed IS NULL THEN '분석 안됨'
        ELSE TO_CHAR(last_analyzed, 'YYYY-MM-DD')
        END as "마지막 분석일"
FROM user_tables
WHERE table_name IN ('USERS', 'ROOMS', 'SEATS', 'MOVIES', 'RUNTIMES', 'RESERVATIONS', 'RESERVATION_SEATS')
ORDER BY table_name;

-- 2. 실제 데이터 수 확인 (정확한 카운트)
SELECT '📊 2. 실제 데이터 수 확인' as "검사항목" FROM DUAL;

SELECT 'USERS' as "테이블", COUNT(*) as "실제 데이터 수" FROM USERS
UNION ALL SELECT 'ROOMS', COUNT(*) FROM ROOMS
UNION ALL SELECT 'SEATS', COUNT(*) FROM SEATS
UNION ALL SELECT 'MOVIES', COUNT(*) FROM MOVIES
UNION ALL SELECT 'RUNTIMES', COUNT(*) FROM RUNTIMES
UNION ALL SELECT 'RESERVATIONS', COUNT(*) FROM RESERVATIONS
UNION ALL SELECT 'RESERVATION_SEATS', COUNT(*) FROM RESERVATION_SEATS;

-- 3. 상영시간 데이터 상태 확인
SELECT '📊 3. 상영시간 데이터 상태 확인' as "검사항목" FROM DUAL;

SELECT
    TO_CHAR(run_date, 'YYYY-MM-DD') as "상영날짜",
    COUNT(*) as "상영 건수",
    COUNT(DISTINCT movie_id) as "영화 수",
    COUNT(DISTINCT room_id) as "사용 상영관 수",
    SUM(CASE WHEN available_seats = 0 THEN 1 ELSE 0 END) as "매진 건수"
FROM runtimes
GROUP BY run_date
ORDER BY run_date;

-- 4. 오늘 상영시간 확인
SELECT '📊 4. 오늘 상영시간 확인' as "검사항목" FROM DUAL;

SELECT
    r.runtime_id as "ID",
    m.title as "영화명",
    rm.room_name as "상영관",
    r.start_time as "시작시간",
    r.available_seats as "잔여좌석",
    rm.total_seats as "총좌석",
    CASE WHEN r.available_seats = 0 THEN '매진' ELSE '예매가능' END as "상태"
FROM runtimes r
         JOIN movies m ON r.movie_id = m.movie_id
         JOIN rooms rm ON r.room_id = rm.room_id
WHERE TRUNC(r.run_date) = TRUNC(SYSDATE)
ORDER BY m.title, r.start_time;

-- 5. 외래키 제약조건 확인
SELECT '📊 5. 외래키 제약조건 상태 확인' as "검사항목" FROM DUAL;

SELECT
    constraint_name as "제약조건명",
    table_name as "테이블",
    status as "상태",
    validated as "검증상태"
FROM user_constraints
WHERE constraint_type = 'R'
  AND table_name IN ('RUNTIMES', 'RESERVATIONS', 'RESERVATION_SEATS', 'SEATS')
ORDER BY table_name, constraint_name;

-- 6. 인덱스 상태 확인
SELECT '📊 6. 인덱스 상태 확인' as "검사항목" FROM DUAL;

SELECT
    index_name as "인덱스명",
    table_name as "테이블",
    status as "상태",
    num_rows as "행수"
FROM user_indexes
WHERE table_name IN ('RUNTIMES', 'RESERVATIONS', 'RESERVATION_SEATS')
ORDER BY table_name, index_name;

-- 7. 뷰 상태 확인
SELECT '📊 7. 뷰 상태 확인' as "검사항목" FROM DUAL;

SELECT
    view_name as "뷰명",
    CASE
        WHEN status = 'VALID' THEN '정상'
        ELSE '오류'
        END as "상태"
FROM user_views
WHERE view_name LIKE 'V_%'
ORDER BY view_name;

-- 8. 최근 예약 현황
SELECT '📊 8. 최근 예약 현황 (최근 7일)' as "검사항목" FROM DUAL;

SELECT
    TO_CHAR(reserved_at, 'YYYY-MM-DD') as "예약일",
    COUNT(*) as "예약 건수",
    SUM(adult + youth + child) as "총 관객수",
    SUM(total_amount) as "총 매출",
    COUNT(CASE WHEN reservation_status = '예약완료' THEN 1 END) as "완료",
    COUNT(CASE WHEN reservation_status = '예약취소' THEN 1 END) as "취소"
FROM reservations
WHERE reserved_at >= SYSDATE - 7
GROUP BY TRUNC(reserved_at)
ORDER BY TRUNC(reserved_at) DESC;

-- 9. 데이터 무결성 체크
SELECT '📊 9. 데이터 무결성 체크' as "검사항목" FROM DUAL;

-- 9-1. 상영시간의 좌석수 일치 여부
SELECT
    '상영시간 좌석수 불일치' as "문제유형",
    COUNT(*) as "문제 건수"
FROM runtimes r
         JOIN rooms rm ON r.room_id = rm.room_id
WHERE r.available_seats > rm.total_seats;

-- 9-2. 예약 좌석수와 인원수 불일치 (Oracle에서 동작하도록 수정)
SELECT
    '예약 좌석-인원 불일치' as "문제유형",
    COUNT(*) as "문제 건수"
FROM (
         SELECT
             res.reservation_id,
             (res.adult + res.youth + res.child) as total_people,
             COUNT(rs.seat_id) as total_seats
         FROM reservations res
                  LEFT JOIN reservation_seats rs ON res.reservation_id = rs.reservation_id
         WHERE res.reservation_status = '예약완료'
         GROUP BY res.reservation_id, (res.adult + res.youth + res.child)
         HAVING (res.adult + res.youth + res.child) != COUNT(rs.seat_id)
     );

-- 10. 중요 테이블 기본 정보
SELECT '📊 10. 중요 테이블 기본 정보' as "검사항목" FROM DUAL;

SELECT
    'RUNTIMES' as "테이블",
    (SELECT COUNT(*) FROM runtimes) as "전체 건수",
    (SELECT COUNT(*) FROM runtimes WHERE TRUNC(run_date) = TRUNC(SYSDATE)) as "오늘 상영",
    (SELECT COUNT(*) FROM runtimes WHERE run_date >= TRUNC(SYSDATE) AND run_date < TRUNC(SYSDATE) + 7) as "일주일 상영"
FROM DUAL

UNION ALL

SELECT
    'MOVIES' as "테이블",
    (SELECT COUNT(*) FROM movies) as "전체 건수",
    (SELECT COUNT(DISTINCT r.movie_id) FROM runtimes r WHERE r.run_date >= TRUNC(SYSDATE)) as "상영중 영화",
    0 as "추가정보"
FROM DUAL

UNION ALL

SELECT
    'RESERVATIONS' as "테이블",
    (SELECT COUNT(*) FROM reservations) as "전체 건수",
    (SELECT COUNT(*) FROM reservations WHERE reservation_status = '예약완료') as "완료된 예약",
    (SELECT COUNT(*) FROM reservations WHERE TRUNC(reserved_at) = TRUNC(SYSDATE)) as "오늘 예약"
FROM DUAL;

-- 완료 메시지
SELECT '========================================' as "메시지" FROM DUAL
UNION ALL SELECT 'Phoenix Cinema DB 상태 확인 완료' FROM DUAL
UNION ALL SELECT '완료 시간: ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL
UNION ALL SELECT '========================================' FROM DUAL;

-- 요약 정보
SELECT
    'DB 상태 확인 완료' as "결과",
    TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') as "완료시간"
FROM DUAL;