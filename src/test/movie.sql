create table movie_test(
                           m_no          NUMBER(5) PRIMARY KEY,
                           m_title       VARCHAR2(100) NOT NULL,
                           m_description VARCHAR2(500) NOT NULL,
                           m_poster      VARCHAR2(200) NOT NULL
);
CREATE SEQUENCE movie_test_seq;

INSERT INTO movie_test VALUES (movie_test_seq.NEXTVAL, 'The Shawshank Redemption', 'Two imprisoned men bond over years, finding hope through acts of common decency.', 'shawshank.jpg');

INSERT INTO movie_test VALUES (movie_test_seq.NEXTVAL, 'The Godfather', 'The aging patriarch of an organized crime dynasty transfers control to his reluctant son.', 'godfather.jpg');

INSERT INTO movie_test VALUES (movie_test_seq.NEXTVAL, 'The Dark Knight', 'Batman battles the Joker to save Gotham City from chaos.', 'darkknight.jpg');

INSERT INTO movie_test VALUES (movie_test_seq.NEXTVAL, 'Pulp Fiction', 'The lives of two mob hitmen and a boxer intertwine in a series of violent stories.', 'pulpfiction.jpg');

INSERT INTO movie_test VALUES (movie_test_seq.NEXTVAL, 'Inception', 'A thief enters dreams to steal secrets and plant ideas.', 'inception.jpg');

INSERT INTO movie_test VALUES (movie_test_seq.NEXTVAL, 'Fight Club', 'An office worker forms an underground fight club to rebel against consumer culture.', 'fightclub.jpg');

INSERT INTO movie_test VALUES (movie_test_seq.NEXTVAL, 'Forrest Gump', 'A simple man witnesses and influences several historical events.', 'forrestgump.jpg');

INSERT INTO movie_test VALUES (movie_test_seq.NEXTVAL, 'Interstellar', 'Explorers travel through a wormhole in search of a new home for humanity.', 'interstellar.jpg');

INSERT INTO movie_test VALUES (movie_test_seq.NEXTVAL, 'The Matrix', 'A computer hacker learns about the true nature of his reality.', 'matrix.jpg');

INSERT INTO movie_test VALUES (movie_test_seq.NEXTVAL, 'Gladiator', 'A betrayed Roman general fights for revenge as a gladiator.', 'gladiator.jpg');

INSERT INTO movie_test VALUES (movie_test_seq.NEXTVAL, 'The Lord of the Rings: The Fellowship of the Ring', 'A hobbit sets out to destroy a powerful ring.', 'lotr1.jpg');

INSERT INTO movie_test VALUES (movie_test_seq.NEXTVAL, 'The Avengers', 'Earth’s mightiest heroes team up to save the world from Loki.', 'avengers.jpg');

INSERT INTO movie_test VALUES (movie_test_seq.NEXTVAL, 'Titanic', 'A romance blossoms aboard the ill-fated Titanic ship.', 'titanic.jpg');

INSERT INTO movie_test VALUES (movie_test_seq.NEXTVAL, 'Saving Private Ryan', 'A WWII mission to rescue a paratrooper behind enemy lines.', 'savingryan.jpg');

INSERT INTO movie_test VALUES (movie_test_seq.NEXTVAL, 'Jurassic Park', 'Scientists revive dinosaurs for a theme park — with disastrous consequences.', 'jurassicpark.jpg');

INSERT INTO movie_test VALUES (movie_test_seq.NEXTVAL, 'Avatar', 'A marine joins an alien world and fights to protect its people.', 'avatar.jpg');

INSERT INTO movie_test VALUES (movie_test_seq.NEXTVAL, 'The Lion King', 'A young lion prince flees his kingdom only to learn his destiny.', 'lionking.jpg');

INSERT INTO movie_test VALUES (movie_test_seq.NEXTVAL, 'Star Wars: A New Hope', 'A farm boy joins a rebellion to defeat the evil Empire.', 'starwars4.jpg');

INSERT INTO movie_test VALUES (movie_test_seq.NEXTVAL, 'Toy Story', 'Toys come to life and go on adventures when humans aren’t watching.', 'toystory.jpg');

INSERT INTO movie_test VALUES (movie_test_seq.NEXTVAL, 'Harry Potter and the Sorcerer Stone', 'A young wizard begins his education at Hogwarts.', 'harrypotter1.jpg');


create table Tag_test(
                         t_no          NUMBER(5) PRIMARY KEY,
                         t_name       VARCHAR2(100) NOT NULL,
                         t_type       VARCHAR2(100) NOT NULL
);

create sequence Tag_test_seq;
-- Country
INSERT INTO tag_test VALUES (tag_test_seq.NEXTVAL, 'USA', 'Country');
INSERT INTO tag_test VALUES (tag_test_seq.NEXTVAL, 'UK', 'Country');
INSERT INTO tag_test VALUES (tag_test_seq.NEXTVAL, 'Japan', 'Country');
INSERT INTO tag_test VALUES (tag_test_seq.NEXTVAL, 'France', 'Country');

-- Genre
INSERT INTO tag_test VALUES (tag_test_seq.NEXTVAL, 'Action', 'Genre');
INSERT INTO tag_test VALUES (tag_test_seq.NEXTVAL, 'Drama', 'Genre');
INSERT INTO tag_test VALUES (tag_test_seq.NEXTVAL, 'Comedy', 'Genre');
INSERT INTO tag_test VALUES (tag_test_seq.NEXTVAL, 'Sci-Fi', 'Genre');
INSERT INTO tag_test VALUES (tag_test_seq.NEXTVAL, 'Fantasy', 'Genre');
INSERT INTO tag_test VALUES (tag_test_seq.NEXTVAL, 'Thriller', 'Genre');

-- Award
INSERT INTO tag_test VALUES (tag_test_seq.NEXTVAL, 'Oscar Winner', 'Award');
INSERT INTO tag_test VALUES (tag_test_seq.NEXTVAL, 'Cannes', 'Award');
INSERT INTO tag_test VALUES (tag_test_seq.NEXTVAL, 'Golden Globe', 'Award');

-- Language
INSERT INTO tag_test VALUES (tag_test_seq.NEXTVAL, 'English', 'Language');
INSERT INTO tag_test VALUES (tag_test_seq.NEXTVAL, 'Japanese', 'Language');
INSERT INTO tag_test VALUES (tag_test_seq.NEXTVAL, 'French', 'Language');

-- Platform
INSERT INTO tag_test VALUES (tag_test_seq.NEXTVAL, 'Netflix', 'Platform');
INSERT INTO tag_test VALUES (tag_test_seq.NEXTVAL, 'Disney+', 'Platform');
INSERT INTO tag_test VALUES (tag_test_seq.NEXTVAL, 'Prime Video', 'Platform');

select *
from movie_test;

CREATE TABLE movie_tag_test (
                                movie_no    NUMBER(5) NOT NULL,
                                tag_no      NUMBER(5) NOT NULL,
                                CONSTRAINT pk_movie_tag PRIMARY KEY (movie_no, tag_no),
                                CONSTRAINT fk_movie FOREIGN KEY (movie_no)
                                    REFERENCES movie_test(m_no),
                                CONSTRAINT fk_tag FOREIGN KEY (tag_no)
                                    REFERENCES tag_test(t_no)
);

-- The Shawshank Redemption
INSERT INTO movie_tag_test VALUES (1, 2);  -- UK
INSERT INTO movie_tag_test VALUES (1, 6);  -- Drama

-- The Godfather
INSERT INTO movie_tag_test VALUES (2, 1);  -- USA
INSERT INTO movie_tag_test VALUES (2, 5);  -- Action

-- The Dark Knight
INSERT INTO movie_tag_test VALUES (3, 1);  -- USA
INSERT INTO movie_tag_test VALUES (3, 5);  -- Action

-- Pulp Fiction
INSERT INTO movie_tag_test VALUES (4, 1);  -- USA
INSERT INTO movie_tag_test VALUES (4, 10); -- Thriller

-- Inception
INSERT INTO movie_tag_test VALUES (5, 1);  -- USA
INSERT INTO movie_tag_test VALUES (5, 8);  -- Sci-Fi

-- Fight Club
INSERT INTO movie_tag_test VALUES (6, 1);  -- USA
INSERT INTO movie_tag_test VALUES (6, 6);  -- Drama

-- Forrest Gump
INSERT INTO movie_tag_test VALUES (7, 1);  -- USA
INSERT INTO movie_tag_test VALUES (7, 6);  -- Drama

-- Interstellar
INSERT INTO movie_tag_test VALUES (8, 1);  -- USA
INSERT INTO movie_tag_test VALUES (8, 8);  -- Sci-Fi

-- The Matrix
INSERT INTO movie_tag_test VALUES (9, 1);  -- USA
INSERT INTO movie_tag_test VALUES (9, 8);  -- Sci-Fi

-- Gladiator
INSERT INTO movie_tag_test VALUES (10, 4); -- France
INSERT INTO movie_tag_test VALUES (10, 5); -- Action

-- The Lord of the Rings
INSERT INTO movie_tag_test VALUES (11, 1);  -- USA
INSERT INTO movie_tag_test VALUES (11, 9);  -- Fantasy

-- The Avengers
INSERT INTO movie_tag_test VALUES (12, 1);  -- USA
INSERT INTO movie_tag_test VALUES (12, 5);  -- Action

-- Titanic
INSERT INTO movie_tag_test VALUES (13, 1);  -- USA
INSERT INTO movie_tag_test VALUES (13, 6);  -- Drama

-- Saving Private Ryan
INSERT INTO movie_tag_test VALUES (14, 1);  -- USA
INSERT INTO movie_tag_test VALUES (14, 6);  -- Drama

-- Jurassic Park
INSERT INTO movie_tag_test VALUES (15, 1);  -- USA
INSERT INTO movie_tag_test VALUES (15, 8);  -- Sci-Fi

-- Avatar
INSERT INTO movie_tag_test VALUES (16, 1);  -- USA
INSERT INTO movie_tag_test VALUES (16, 9);  -- Fantasy

-- The Lion King
INSERT INTO movie_tag_test VALUES (17, 1);  -- USA
INSERT INTO movie_tag_test VALUES (17, 9);  -- Fantasy

-- Star Wars
INSERT INTO movie_tag_test VALUES (18, 1);  -- USA
INSERT INTO movie_tag_test VALUES (18, 8);  -- Sci-Fi

-- Toy Story
INSERT INTO movie_tag_test VALUES (19, 1);  -- USA
INSERT INTO movie_tag_test VALUES (19, 7);  -- Comedy

-- Harry Potter
INSERT INTO movie_tag_test VALUES (20, 2);  -- UK
INSERT INTO movie_tag_test VALUES (20, 9);  -- Fantasy

select *
from movie_tag_test;

select *
from movie_test;
select *
from TAG_TEST;

SELECT m.m_no, m.m_title, t.t_no, t.t_name, t.t_type
FROM movie_test m
         LEFT JOIN movie_tag_test mt ON m.m_no = mt.movie_no
         LEFT JOIN tag_test t ON mt.tag_no = t.t_no;