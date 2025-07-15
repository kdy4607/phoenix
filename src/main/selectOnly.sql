--메모리가 자꾸 죽어서 만듬..

select RELEASE_DATE
from MOVIES;

CREATE TABLE bookmarks
(
    u_id     VARCHAR2(100), -- 유저 ID
    movie_id NUMBER,        -- 영화 ID
    PRIMARY KEY (u_id, movie_id),
    FOREIGN KEY (u_id) REFERENCES users (u_id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movies (movie_id) ON DELETE CASCADE
);

