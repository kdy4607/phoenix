-- ========================================
-- 4. 영화 테이블 (MOVIES)
-- ========================================

-- 테이블 생성
CREATE TABLE MOVIES (
                        MOVIE_ID NUMBER(3) PRIMARY KEY,      -- 최대 999편의 영화
                        TITLE VARCHAR2(100) NOT NULL,
                        GENRE VARCHAR2(50) NOT NULL,
                        RATING VARCHAR2(20) NOT NULL,
                        RUNNING_TIME NUMBER(3) NOT NULL,     -- 최대 999분
                        POSTER_URL VARCHAR2(500)
);

-- 시퀀스 생성
CREATE SEQUENCE SEQ_MOVIE_ID START WITH 1 INCREMENT BY 1 MAXVALUE 999;

-- 기본 영화 데이터 삽입
INSERT INTO MOVIES (MOVIE_ID, TITLE, GENRE, RATING, RUNNING_TIME, POSTER_URL)
VALUES (1, '인사이드 아웃 2', '애니메이션', '전체관람가', 96, '/images/insideout2.jpg');

INSERT INTO MOVIES (MOVIE_ID, TITLE, GENRE, RATING, RUNNING_TIME, POSTER_URL)
VALUES (2, '디스피커블 미 4', '애니메이션', '전체관람가', 94, '/images/despicable4.jpg');

INSERT INTO MOVIES (MOVIE_ID, TITLE, GENRE, RATING, RUNNING_TIME, POSTER_URL)
VALUES (3, '탈주', '액션', '15세관람가', 109, '/images/escape.jpg');

INSERT INTO MOVIES (MOVIE_ID, TITLE, GENRE, RATING, RUNNING_TIME, POSTER_URL)
VALUES (4, '헤드리거', '액션/드라마', '12세관람가', 112, '/images/headrigger.jpg');

INSERT INTO MOVIES (MOVIE_ID, TITLE, GENRE, RATING, RUNNING_TIME, POSTER_URL)
VALUES (5, '파일럿', '코미디', '12세관람가', 117, '/images/pilot.jpg');

INSERT INTO MOVIES (MOVIE_ID, TITLE, GENRE, RATING, RUNNING_TIME, POSTER_URL)
VALUES (6, '트위스터스', '액션/스릴러', '12세관람가', 122, '/images/twisters.jpg');

INSERT INTO MOVIES (MOVIE_ID, TITLE, GENRE, RATING, RUNNING_TIME, POSTER_URL)
VALUES (7, '베놈: 라스트 댄스', '액션/SF', '15세관람가', 109, '/images/venom3.jpg');

INSERT INTO MOVIES (MOVIE_ID, TITLE, GENRE, RATING, RUNNING_TIME, POSTER_URL)
VALUES (8, '위키드', '뮤지컬/판타지', '전체관람가', 160, '/images/wicked.jpg');

INSERT INTO MOVIES (MOVIE_ID, TITLE, GENRE, RATING, RUNNING_TIME, POSTER_URL)
VALUES (9, '글래디에이터 2', '액션/드라마', '15세관람가', 148, '/images/gladiator2.jpg');

INSERT INTO MOVIES (MOVIE_ID, TITLE, GENRE, RATING, RUNNING_TIME, POSTER_URL)
VALUES (10, '모아나 2', '애니메이션/가족', '전체관람가', 100, '/images/moana2.jpg');

-- 커밋
COMMIT;

-- 확인 쿼리
SELECT * FROM MOVIES ORDER BY MOVIE_ID;

-- 장르별 영화 수 확인
SELECT GENRE, COUNT(*) as MOVIE_COUNT
FROM MOVIES
GROUP BY GENRE
ORDER BY MOVIE_COUNT DESC;