# 🎬 Phoenix Cinema Database Setup Guide

Phoenix Cinema 프로젝트의 데이터베이스 설정 가이드입니다.

## 📁 파일 구조

```
database/
├── 00_master_setup.sql          # 전체 실행 마스터 스크립트
├── 01_users.sql                 # 사용자 테이블
├── 02_rooms.sql                 # 상영관 테이블
├── 03_seats.sql                 # 좌석 테이블
├── 04_movies.sql                # 영화 테이블
├── 05_runtimes.sql              # 상영시간 테이블
├── 06_reservations.sql          # 예약 테이블
├── 07_reservation_seats.sql     # 예약 좌석 테이블
└── 08_views_and_indexes.sql     # 뷰 및 인덱스
```

## 🚀 빠른 실행 (권장)

### 방법 1: 마스터 스크립트 실행
```sql
-- Oracle SQL*Plus 또는 SQL Developer에서 실행
@00_master_setup.sql
```

### 방법 2: 개별 파일 순차 실행
```sql
@01_users.sql
@02_rooms.sql
@03_seats.sql
@04_movies.sql
@05_runtimes.sql
@06_reservations.sql
@07_reservation_seats.sql
@08_views_and_indexes.sql
```

## 📊 데이터베이스 구조

### 테이블 관계도
```
USERS (사용자)
  ↓ (1:N)
RESERVATIONS (예약)
  ↓ (1:N)        ↓ (N:1)
RESERVATION_SEATS ← RUNTIMES (상영시간)
  ↓ (N:1)        ↓ (N:1)    ↓ (N:1)
SEATS (좌석)   MOVIES    ROOMS
  ↓ (N:1)      (영화)    (상영관)
ROOMS
```

### 주요 테이블

| 테이블명 | 설명 | 주요 컬럼 |
|---------|------|----------|
| **USERS** | 사용자 정보 | U_ID, U_nickname, U_name |
| **ROOMS** | 상영관 정보 | ROOM_ID, ROOM_NAME, TOTAL_SEATS |
| **SEATS** | 좌석 정보 | SEAT_ID, ROOM_ID, SEAT_ROW, SEAT_NUMBER |
| **MOVIES** | 영화 정보 | MOVIE_ID, TITLE, GENRE, RATING |
| **RUNTIMES** | 상영시간 | RUNTIME_ID, MOVIE_ID, ROOM_ID, RUN_DATE, START_TIME |
| **RESERVATIONS** | 예약 정보 | RESERVATION_ID, U_ID, RUNTIME_ID, TOTAL_AMOUNT |
| **RESERVATION_SEATS** | 예약 좌석 | RESERVATION_SEAT_ID, RESERVATION_ID, SEAT_ID |

## 📈 포함된 뷰 (Views)

| 뷰명 | 설명 | 용도 |
|------|------|------|
| **V_SHOWTIME_LIST** | 상영시간 목록 | 상영시간표 조회 |
| **V_RESERVATION_DETAIL** | 예약 상세 정보 | 예약 조회 및 관리 |
| **V_MOVIE_SALES_STATS** | 영화별 매출 통계 | 매출 분석 |
| **V_ROOM_UTILIZATION** | 상영관별 이용률 | 운영 분석 |
| **V_DAILY_SALES** | 일별 매출 통계 | 일일 매출 분석 |

## 💾 샘플 데이터

### 기본 제공 데이터
- **사용자**: 4명의 테스트 사용자
- **상영관**: 5개 상영관 (1관~5관, IMAX관, 프리미엄관, VIP관)
- **좌석**: 총 320석 (상영관별 30~100석)
- **영화**: 10편의 최신 영화
- **상영시간**: 7일간의 상영 스케줄 (총 48회 상영)
- **예약**: 10건의 샘플 예약
- **예약 좌석**: 19개의 예약된 좌석

### 상영관 구성
| 상영관 | 좌석 수 | 구성 | 특징 |
|--------|---------|------|------|
| 1관 | 60석 | A~F행 × 10열 | 일반관 |
| 2관 | 80석 | A~H행 × 10열 | 일반관 |
| IMAX관 | 100석 | A~J행 × 10열 | 프리미엄 가격 |
| 프리미엄관 | 50석 | A~E행 × 10열 | 프리미엄 가격 |
| VIP관 | 30석 | A~C행 × 10열 | 최고급 관 |

## ⚙️ 성능 최적화

### 생성되는 인덱스
- `IDX_RUNTIMES_DATE`: 날짜별 상영시간 조회 최적화
- `IDX_RUNTIMES_MOVIE_DATE`: 영화별 날짜 조회 최적화
- `IDX_RESERVATIONS_USER`: 사용자별 예약 조회 최적화
- `IDX_RESERVATION_USER_STATUS`: 예약 상태별 조회 최적화
- 기타 7개 인덱스

## 🔧 유지보수

### 데이터 초기화
```sql
-- 주의: 모든 데이터가 삭제됩니다!
DROP TABLE RESERVATION_SEATS CASCADE CONSTRAINTS;
DROP TABLE RESERVATIONS CASCADE CONSTRAINTS;
DROP TABLE RUNTIMES CASCADE CONSTRAINTS;
DROP TABLE MOVIES CASCADE CONSTRAINTS;
DROP TABLE SEATS CASCADE CONSTRAINTS;
DROP TABLE ROOMS CASCADE CONSTRAINTS;
DROP TABLE USERS CASCADE CONSTRAINTS;
```

### 특정 테이블만 재생성
```sql
-- 예: 상영시간만 재설정
DROP TABLE RUNTIMES CASCADE CONSTRAINTS;
@05_runtimes.sql
```

## 📋 확인 쿼리

### 기본 데이터 확인
```sql
-- 테이블별 데이터 수 확인
SELECT 'USERS' as TABLE_NAME, COUNT(*) as COUNT FROM USERS
UNION ALL SELECT 'MOVIES', COUNT(*) FROM MOVIES
UNION ALL SELECT 'ROOMS', COUNT(*) FROM ROOMS
UNION ALL SELECT 'RUNTIMES', COUNT(*) FROM RUNTIMES;
```

### 오늘의 상영시간 확인
```sql
SELECT * FROM V_SHOWTIME_LIST 
WHERE RUN_DATE = TRUNC(SYSDATE)
ORDER BY MOVIE_TITLE, START_TIME;
```

### 예약 현황 확인
```sql
SELECT * FROM V_RESERVATION_DETAIL 
ORDER BY RESERVED_AT DESC;
```

## ⚠️ 주의사항

1. **시퀀스 값**: 각 테이블의 PK는 시퀀스로 자동 생성됩니다.
2. **외래키 제약**: 테이블 삭제 시 참조 관계를 고려해야 합니다.
3. **날짜 데이터**: `CURRENT_DATE`를 기준으로 생성되므로 실행 시점에 따라 달라집니다.
4. **용량 제한**: 각 컬럼에 적절한 크기 제한이 설정되어 있습니다.

## 🆘 문제 해결

### 자주 발생하는 오류

#### ORA-00942: 테이블 또는 뷰가 존재하지 않습니다
```sql
-- 해결: 테이블 생성 순서 확인
-- USERS → ROOMS → SEATS → MOVIES → RUNTIMES → RESERVATIONS → RESERVATION_SEATS
```

#### ORA-02291: 무결성 제약조건 위반
```sql
-- 해결: 외래키 참조 데이터 먼저 삽입
-- 예: ROOMS 테이블 데이터 먼저 삽입 후 SEATS 데이터 삽입
```

#### ORA-01401: 열에 삽입된 값이 너무 큽니다
```sql
-- 해결: 컬럼 크기 제한 확인
-- 예: ROOM_ID는 NUMBER(2)이므로 최대 99까지만 가능
```

## 📞 지원

데이터베이스 설정 관련 문의사항이 있으시면 다음을 확인해 주세요:

1. 각 SQL 파일의 주석 확인
2. 오류 메시지와 함께 실행한 쿼리 제공
3. Oracle 버전 및 환경 정보 제공

---

**🎬 Phoenix Cinema Database - 완벽한 영화관 시스템을 위한 데이터베이스**