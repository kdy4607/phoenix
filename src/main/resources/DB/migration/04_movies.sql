-- ========================================
-- 4. 영화 테이블 (MOVIES)
-- ========================================

DROP TABLE MOVIES CASCADE CONSTRAINTS;
DROP SEQUENCE SEQ_MOVIE_ID;

-- 테이블 생성
CREATE TABLE MOVIES (
                        MOVIE_ID NUMBER(3) PRIMARY KEY,
                        TITLE VARCHAR2(100) NOT NULL,
                        DIRECTOR VARCHAR2(100) NOT NULL,
                        ACTOR VARCHAR2(200) NOT NULL,
                        GENRE VARCHAR2(50) NOT NULL,
                        RATING VARCHAR2(20) NOT NULL,
                        USER_CRITIC NUMBER(2,1) DEFAULT 0 CHECK (USER_CRITIC >= 0 AND USER_CRITIC <= 5),
                        PRO_CRITIC NUMBER(2,1) DEFAULT 0 CHECK (PRO_CRITIC >= 0 AND PRO_CRITIC <= 5),
                        DESCRIPTION VARCHAR2(1000),
                        RUNNING_TIME NUMBER(3) NOT NULL,
                        POSTER_URL VARCHAR2(500)
);
-- 시퀀스 생성
CREATE SEQUENCE SEQ_MOVIE_ID START WITH 1 INCREMENT BY 1 MAXVALUE 999;

-- 영화 기본 데이터
INSERT INTO MOVIES (MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING, USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME, POSTER_URL)
VALUES (1, '인사이드 아웃 2', '켈시 만', '에이미 폴러, 마야 호크, 켄식 우다이', '애니메이션/가족', '전체관람가', 4.4, 4.6,
        '13세가 된 라일리의 머릿속에 불시착한 새로운 감정들! 라일리가 성장하면서 그녀의 마음속 감정 컨트롤 본부에도 새로운 변화가 찾아온다.',
        96, '/images/insideout2.jpg');

INSERT INTO MOVIES (MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING, USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME, POSTER_URL)
VALUES (2, '디스피커블 미 4', '크리스 르노', '스티브 카렐, 크리스틴 위그', '애니메이션/코미디', '전체관람가', 4.2, 3.9,
        '그루와 루시, 그리고 딸들은 새로운 가족을 맞이하고 평화로운 일상을 보내고 있다. 하지만 과거 그루의 숙적 맥심 르 말이 감옥에서 탈출한다.',
        94, '/images/despicableme4.jpg');

INSERT INTO MOVIES (MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING, USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME, POSTER_URL)
VALUES (3, '탈주', '이종필', '이제훈, 고경표, 이솜', '액션/범죄', '15세관람가', 3.9, 4.1,
        '1988년 서울올림픽을 앞둔 대한민국. 군사정권의 폭압에 맞선 민주화 투쟁이 거세지는 가운데, 안기부는 시국사범들을 비밀리에 격리 수용한다.',
        109, '/images/escape.jpg');

INSERT INTO MOVIES (MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING, USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME, POSTER_URL)
VALUES (4, '파일럿', '김한결', '조정석, 이주명, 한선화', '코미디', '12세관람가', 4.1, 3.7,
        '대한민국 최고의 파일럿을 꿈꾸는 한정우. 하지만 그에게 주어진 것은 전세기 비행뿐이다.',
        100, '/images/pilot.jpg');

INSERT INTO MOVIES (MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING, USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME, POSTER_URL)
VALUES (5, '트위스터스', '리 아이작 청', '데이지 에드가 존스, 글렌 파웰', '액션/재난', '12세관람가', 3.8, 4.0,
        '케이트는 친구들과 함께 토네이도를 추적하던 중 예상치 못한 거대한 토네이도에 휩쓸려 친구들을 잃고 홀로 살아남는다.',
        122, '/images/twisters.jpg');

INSERT INTO MOVIES (MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING, USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME, POSTER_URL)
VALUES (6, '헤드리거', '김성훈', '정우성, 임시완, 이하늬', '액션/드라마', '12세관람가', 4.3, 4.4,
        '축구에 모든 것을 걸었던 윤홍대. 부상으로 선수 생활을 접고 고향에 돌아온 그에게 아버지는 마지막 부탁을 한다.',
        113, '/images/header.jpg');
-- 커밋
COMMIT;

-- 확인 쿼리
SELECT * FROM MOVIES ORDER BY MOVIE_ID;

-- 장르별 영화 수 확인
SELECT GENRE, COUNT(*) as MOVIE_COUNT
FROM MOVIES
GROUP BY GENRE
ORDER BY MOVIE_COUNT DESC;