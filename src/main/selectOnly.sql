--메모리가 자꾸 죽어서 만듬..

select RELEASE_DATE
from MOVIES;

CREATE TABLE bookmarks
(
    u_id     VARCHAR2(20), -- 유저 ID
    movie_id NUMBER(3),        -- 영화 ID
    PRIMARY KEY (u_id, movie_id),
    FOREIGN KEY (u_id) REFERENCES users (u_id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movies (movie_id) ON DELETE CASCADE
);

DROP TABLE bookmarks;
SELECT * FROM PHOENIX.bookmarks;
SELECT * FROM users WHERE u_id = 'go';
;SELECT * FROM movies WHERE movie_id = 79; -- 예시

SELECT a.constraint_name, a.column_name, c_pk.table_name AS referenced_table, c_pk.column_name AS referenced_column
FROM user_cons_columns a
         JOIN user_constraints c ON a.constraint_name = c.constraint_name
         JOIN user_cons_columns c_pk ON c.r_constraint_name = c_pk.constraint_name
WHERE c.constraint_type = 'R' AND a.table_name = 'BOOKMARKS';

-- 무비 재설정용
select GENRE from MOVIES;

select * from MOVIES;
SELECT
    m.movie_id,
    m.title,
    REGEXP_SUBSTR(m.genre, '[^/]+', 1, LEVEL) AS genre_split
FROM
    movies m
CONNECT BY
    LEVEL <= LENGTH(m.genre) - LENGTH(REPLACE(m.genre, '/', '')) + 1
       AND PRIOR movie_id = movie_id
       AND PRIOR SYS_GUID() IS NOT NULL


SELECT DISTINCT m2.movie_id, m2.title
FROM movies m1
         JOIN movies m2
              ON m1.genre = m2.genre
WHERE m1.movie_id = 1
  AND m2.movie_id != 1;


SELECT DISTINCT t.tag_id, t.tag_name, t.tag_type
FROM reservations r
         JOIN movie_tags mt ON r.movie_id = mt.movie_id
         JOIN tags t ON mt.tag_id = t.tag_id
WHERE r.u_id = #{u_id}
  AND t.tag_type = 'Genre';



