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
