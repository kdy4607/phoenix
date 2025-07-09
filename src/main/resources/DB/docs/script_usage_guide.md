# 📋 Phoenix Cinema DB 스크립트 사용 가이드

## 📁 스크립트 디렉토리 구조

```
src/main/resources/db/scripts/
├── health-check/           # 📊 상태 확인
├── troubleshooting/        # 🚨 문제 해결  
├── maintenance/            # 🛠️ 정기 유지보수
├── backup/                 # 💾 백업/복원
└── monitoring/             # 📈 성능 모니터링
```

---

## 🚨 **긴급 상황별 스크립트 사용법**

### ❌ **"/schedule 페이지 오류" 발생 시**

#### 1단계: 문제 진단
```bash
# Oracle SQL*Plus 또는 SQL Developer에서 실행
cd src/main/resources/db/scripts/troubleshooting/
@debug_runtime_issues.sql
```

#### 2단계: 기본 상태 확인
```bash
cd src/main/resources/db/scripts/health-check/
@db_status_check.sql
```

#### 3단계: 문제별 해결 방법

| 문제 상황 | 원인 | 해결 방법 |
|-----------|------|-----------|
| **테이블 없음** | DB 스크립트 미실행 | `@00_master_setup.sql` 실행 |
| **데이터 없음** | 샘플 데이터 누락 | `@05_runtimes.sql` 재실행 |
| **SQL 문법 오류** | MySQL→Oracle 호환성 | `RuntimeMapper.java` 수정 |
| **조인 실패** | 외래키 데이터 불일치 | 문제 데이터 수정 |

---

## 📊 **일상적인 운영 관리**

### 🔄 **매일 실행 권장**
```bash
# 1. 기본 상태 확인
@health-check/db_status_check.sql

# 2. 당일 예약 현황 확인  
@monitoring/daily_report.sql
```

### 🗓️ **주간 실행 권장**
```bash
# 1. 성능 분석
@monitoring/weekly_stats.sql

# 2. 데이터 정리
@maintenance/cleanup_old_data.sql
```

### 📅 **월간 실행 권장**
```bash
# 1. 전체 백업
@backup/backup_schema.sql
@backup/backup_data.sql

# 2. 통계 업데이트
@maintenance/update_statistics.sql
```

---

## 🛠️ **스크립트별 상세 사용법**

### 📊 **health-check/db_status_check.sql**
```sql
-- 용도: 전체 시스템 상태 진단
-- 실행 시기: 문제 발생 시, 정기 점검 시
-- 소요 시간: 약 30초

@health-check/db_status_check.sql
```

**출력 정보:**
- ✅ 테이블별 데이터 수
- ✅ 상영시간 상태
- ✅ 외래키 제약조건
- ✅ 인덱스 상태
- ✅ 최근 예약 현황

### 🚨 **troubleshooting/debug_runtime_issues.sql**
```sql
-- 용도: 상영시간 관련 문제 집중 분석
-- 실행 시기: /schedule 오류 발생 시
-- 소요 시간: 약 1분

@troubleshooting/debug_runtime_issues.sql
```

**분석 항목:**
- 🔍 테이블 구조 검증
- 🔍 조인 쿼리 테스트
- 🔍 날짜 함수 호환성
- 🔍 데이터 무결성

---

## 📝 **스크립트 실행 절차**

### 🖥️ **SQL*Plus 사용**
```bash
# 1. DB 연결
sqlplus username/password@database

# 2. 디렉토리 이동 (Oracle에서는 @경로 사용)
SQL> @src/main/resources/db/scripts/health-check/db_status_check.sql

# 3. 결과 확인
# 화면에 출력되는 결과를 확인하고 문제점 파악
```

### 🛠️ **SQL Developer 사용**
```sql
-- 1. 파일 열기: 원하는 SQL 스크립트 파일 오픈
-- 2. 전체 실행: Ctrl+Enter 또는 F5
-- 3. 결과 확인: 하단 결과 창에서 출력 내용 검토
```

### 🐧 **Linux/Mac 명령어 스크립트**
```bash
#!/bin/bash
# 스크립트 자동 실행 예시

DB_USER="your_username"
DB_PASS="your_password"  
DB_HOST="your_database"

# 상태 확인 실행
sqlplus ${DB_USER}/${DB_PASS}@${DB_HOST} @health-check/db_status_check.sql > status_report_$(date +%Y%m%d).log

echo "상태 확인 완료. 로그 파일 확인: status_report_$(date +%Y%m%d).log"
```

---

## ⚠️ **안전 수칙**

### 🔒 **운영 환경에서 주의사항**
1. **백업 필수**: 스크립트 실행 전 반드시 백업
2. **테스트 환경 먼저**: 개발 환경에서 먼저 테스트
3. **권한 확인**: 필요한 DB 권한 사전 확인
4. **시간대 고려**: 서비스 사용량이 적은 시간대 실행

### 🚫 **절대 하지 말 것**
- ❌ 운영 중 DROP 문 실행
- ❌ 백업 없이 대량 데이터 수정
- ❌ 권한 불명확한 스크립트 실행
- ❌ 트랜잭션 단위 고려 없는 실행

---

## 🎯 **문제 상황별 빠른 참조**

### 🔥 **긴급 상황**
| 증상 | 즉시 실행 스크립트 | 예상 원인 |
|------|-------------------|-----------|
| 🚨 /schedule 500 오류 | `debug_runtime_issues.sql` | SQL 문법, 데이터 누락 |
| 🚨 페이지 로딩 안됨 | `db_status_check.sql` | DB 연결, 테이블 문제 |
| 🚨 예매 불가 | `performance_check.sql` | 락, 인덱스 문제 |

### ⚡ **성능 문제**
| 증상 | 실행 스크립트 | 해결 방향 |
|------|---------------|-----------|
| 📊 조회 속도 느림 | `performance_check.sql` | 인덱스 추가/재구성 |
| 📊 메모리 부족 | `system_metrics.sql` | 통계 업데이트 |
| 📊 동시 접속 오류 | `connection_test.sql` | 커넥션 풀 설정 |

---

## 📞 **지원 및 문의**

### 🆘 **문제 해결이 안 될 때**
1. **로그 수집**: 스크립트 실행 결과 전체 복사
2. **에러 메시지**: 정확한 오류 메시지 기록
3. **실행 환경**: OS, Oracle 버전, Java 버전 명시
4. **재현 절차**: 문제 발생 단계별 기록

### 📚 **추가 학습 자료**
- Oracle 공식 문서: [https://docs.oracle.com](https://docs.oracle.com)
- Spring Boot MyBatis: [https://mybatis.org/spring-boot-starter](https://mybatis.org/spring-boot-starter)
- DB 성능 튜닝 가이드: 프로젝트 내 `docs/` 폴더 참조

---

**💡 Tip: 정기적인 스크립트 실행으로 시스템을 안정적으로 유지하세요!**