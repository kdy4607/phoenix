-- ========================================
-- 상영시간 문제 디버깅 스크립트 (범용 버전)
-- 위치: src/main/resources/db/scripts/troubleshooting/debug_runtime_issues.sql
-- 용도: /schedule 페이지 오류 및 상영시간 관련 문제 해결
-- 호환: SQL*Plus, SQL Developer, IntelliJ, DBeaver 등 모든 클라이언트
-- ========================================

-- 디버깅 시작 메시지
SELECT '========================================' as "메시지" FROM DUAL
UNION ALL SELECT '🚨 상영시간 문제 디버깅 시작' FROM DUAL
UNION ALL SELECT '========================================' FROM DUAL;

-- 1. 기본 테이블 구조 확인
SELECT '🔍 1. RUNTIMES 테이블 구조 확인' as "검사항목" FROM DUAL;

SELECT
    column_name as "컬럼명",
    data_type as "데이터타입",
    data_length as "길이",
    nullable as "NULL허용",
    column_id as "순서"
FROM user_tab_columns
WHERE table_name = 'RUNTIMES'
ORDER BY column_id;

-- 2. MOVIES 테이블 구조 확인
SELECT '🔍 2. MOVIES 테이블 구조 확인' as "검사항목" FROM DUAL;

SELECT
    column_name as "컬럼명",
    data_type as "데이터타입",
    data_length as "길이",
    nullable as "NULL허용"
FROM user_tab_columns
WHERE table_name = 'MOVIES'
ORDER BY column_id;

-- 3. ROOMS 테이블 구조 확인
SELECT '🔍 3. ROOMS 테이블 구조 확인' as "검사항목" FROM DUAL;

SELECT
    column_name as "컬럼명",
    data_type as "데이터타입",
    data_length as "길이",
    nullable as "NULL허용"
FROM user_tab_columns
WHERE table_name = 'ROOMS'
ORDER BY column_id;

-- 4. 샘플 데이터 확인
SELECT '🔍 4. RUNTIMES 샘플 데이터 (최근 5건)' as "검사항목" FROM DUAL;

SELECT
    runtime_id,
    movie_id,
    room_id,
    TO_CHAR(run_date, 'YYYY-MM-DD') as run_date,
    start_time,
    price,
    available_seats
FROM (
         SELECT runtime_id, movie_id, room_id, run_date, start_time, price, available_seats,
                ROW_NUMBER() OVER (ORDER BY runtime_id) as rn
         FROM runtimes
     )
WHERE rn <= 5;

-- 5. 조인 쿼리 테스트 (RuntimeMapper.getRuntimesByDate 시뮬레이션)
SELECT '🔍 5. 조인 쿼리 테스트' as "검사항목" FROM DUAL;

SELECT
    r.runtime_id,
    r.movie_id,
    r.room_id,
    TO_CHAR(r.run_date, 'YYYY-MM-DD') as run_date,
    r.start_time,
    r.price,
    r.available_seats,
    m.title as movie_title,
    m.genre as movie_genre,
    m.rating as movie_rating,
    m.poster_url,
    rm.room_name,
    rm.total_seats
FROM (
         SELECT r.*, ROW_NUMBER() OVER (ORDER BY runtime_id) as rn
         FROM runtimes r
         WHERE TRUNC(r.run_date) = TRUNC(SYSDATE)
     ) r
         JOIN movies m ON r.movie_id = m.movie_id
         JOIN rooms rm ON r.room_id = rm.room_id
WHERE r.rn <= 3
ORDER BY m.title, r.start_time;

-- 6. 날짜 관련 함수 테스트
SELECT '🔍 6. 날짜 함수 테스트' as "검사항목" FROM DUAL;

SELECT
    SYSDATE as "현재시간",
    TRUNC(SYSDATE) as "오늘날짜",
    TRUNC(SYSDATE) + 7 as "7일후",
    TO_CHAR(SYSDATE, 'YYYY-MM-DD') as "포맷된날짜"
FROM DUAL;

-- 7. 상영시간 날짜 범위 확인
SELECT '🔍 7. 상영시간 날짜 범위 확인' as "검사항목" FROM DUAL;

SELECT
    TO_CHAR(MIN(run_date), 'YYYY-MM-DD') as "최초상영일",
    TO_CHAR(MAX(run_date), 'YYYY-MM-DD') as "마지막상영일",
    COUNT(DISTINCT run_date) as "상영일수",
    COUNT(*) as "총상영건수"
FROM runtimes;

-- 8. 조인 실패 원인 분석
SELECT '🔍 8. 조인 실패 원인 분석' as "검사항목" FROM DUAL;

-- 8-1. RUNTIMES에는 있지만 MOVIES에 없는 movie_id
SELECT
    'MOVIES 테이블 누락' as "문제유형",
    r.movie_id,
    COUNT(*) as "문제건수"
FROM runtimes r
         LEFT JOIN movies m ON r.movie_id = m.movie_id
WHERE m.movie_id IS NULL
GROUP BY r.movie_id;

-- 8-2. RUNTIMES에는 있지만 ROOMS에 없는 room_id
SELECT
    'ROOMS 테이블 누락' as "문제유형",
    r.room_id,
    COUNT(*) as "문제건수"
FROM runtimes r
         LEFT JOIN rooms rm ON r.room_id = rm.room_id
WHERE rm.room_id IS NULL
GROUP BY r.room_id;

-- 9. 객체 상태 확인
SELECT '🔍 9. 객체 상태 확인' as "검사항목" FROM DUAL;

SELECT
    object_name as "객체명",
    object_type as "타입",
    status as "상태",
    TO_CHAR(last_ddl_time, 'YYYY-MM-DD HH24:MI') as "마지막수정"
FROM user_objects
WHERE object_name IN ('RUNTIMES', 'MOVIES', 'ROOMS')
ORDER BY object_type, object_name;

-- 10. ScheduleService 쿼리 시뮬레이션
SELECT '🔍 10. ScheduleService 쿼리 시뮬레이션' as "검사항목" FROM DUAL;

-- 10-1. getUpcomingRuntimes 시뮬레이션 (7일간 상영 건수)
SELECT
    '7일간 상영건수' as "구분",
    COUNT(*) as "건수"
FROM runtimes r
         JOIN movies m ON r.movie_id = m.movie_id
         JOIN rooms rm ON r.room_id = rm.room_id
WHERE r.run_date >= TRUNC(SYSDATE)
  AND r.run_date < TRUNC(SYSDATE) + 7;

-- 10-2. 영화별 그룹화 테스트 (오늘 상영)
SELECT
    m.title as "영화명",
    COUNT(*) as "상영건수",
    MIN(r.start_time) as "첫상영",
    MAX(r.start_time) as "마지막상영"
FROM runtimes r
         JOIN movies m ON r.movie_id = m.movie_id
         JOIN rooms rm ON r.room_id = rm.room_id
WHERE TRUNC(r.run_date) = TRUNC(SYSDATE)
GROUP BY m.movie_id, m.title
ORDER BY m.title;

-- 11. 실제 RuntimeMapper 쿼리 테스트
SELECT '🔍 11. RuntimeMapper 실제 쿼리 테스트' as "검사항목" FROM DUAL;

-- Oracle TRUNC 함수 테스트
SELECT
    'Oracle TRUNC 함수 테스트' as "테스트항목",
    COUNT(*) as "결과건수"
FROM runtimes r
WHERE TRUNC(r.run_date) = TRUNC(SYSDATE);

-- 12. 문제 해결 권장사항
SELECT '🔍 12. 문제 해결 권장사항' as "검사항목" FROM DUAL;

SELECT '권장사항' as "구분", '내용' as "설명" FROM DUAL WHERE 1=0
UNION ALL SELECT '1', 'RUNTIMES 테이블에 데이터가 없으면 05_runtimes.sql 실행'
UNION ALL SELECT '2', 'MOVIES/ROOMS 테이블 누락 시 해당 SQL 파일 실행'
UNION ALL SELECT '3', '날짜 함수 오류 시 TRUNC() 함수 사용 확인'
UNION ALL SELECT '4', '조인 실패 시 외래키 제약조건 확인'
UNION ALL SELECT '5', 'RuntimeMapper.java의 SQL 문법 Oracle 호환성 확인'
UNION ALL SELECT '6', 'SQL*Plus 전용 명령어(PROMPT) 제거'
UNION ALL SELECT '7', 'DB 클라이언트별 호환성 확인 (SQL Developer, IntelliJ 등)';

-- 완료 메시지
SELECT '========================================' as "메시지" FROM DUAL
UNION ALL SELECT '🚨 상영시간 문제 디버깅 완료' FROM DUAL
UNION ALL SELECT '' FROM DUAL
UNION ALL SELECT '📋 다음 단계:' FROM DUAL
UNION ALL SELECT '1. 위 결과에서 문제 항목 확인' FROM DUAL
UNION ALL SELECT '2. 누락된 테이블/데이터가 있으면 해당 SQL 파일 실행' FROM DUAL
UNION ALL SELECT '3. RuntimeMapper.java의 SQL을 Oracle 문법으로 수정' FROM DUAL
UNION ALL SELECT '4. 애플리케이션 재시작 후 다시 테스트' FROM DUAL
UNION ALL SELECT '========================================' FROM DUAL;