
select * from MOVIES order by MOVIE_ID;
-- 영화 기본 데이터
INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.nextval, 'Deadpool & Wolverine', 'Shawn Levy', 'Ryan Reynolds, Hugh Jackman', 'Action/Comedy', '15+ Rating', 4.5, 4.6,
             'Deadpool and Wolverine team up in a time-traveling multiverse adventure.',
             128, 'https://image.tmdb.org/t/p/original/6YRQfjHpUQjyfQS0Maf1Xl0ZdpN.jpg', DATE '2024-07-26'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.nextval, 'Kung Fu Panda 4', 'Mike Mitchell', 'Jack Black, Awkwafina, Viola Davis', 'Animation/Action', 'All Ages', 4.2, 4.3,
             'Po faces a new villain and prepares to become the spiritual leader of the Valley of Peace.',
             94, 'https://image.tmdb.org/t/p/original/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg', DATE '2024-03-08'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.nextval, 'The Fall Guy', 'David Leitch', 'Ryan Gosling, Emily Blunt', 'Action/Comedy', '15+ Rating', 4.1, 4.2,
             'A stuntman gets caught in a conspiracy while trying to rescue a missing actor.',
             126, 'https://image.tmdb.org/t/p/original/e7Jvsry47JJQruuezjU2X1Z6J77.jpg', DATE '2024-05-03'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.nextval, 'IF', 'John Krasinski', 'Cailey Fleming, Ryan Reynolds, Steve Carell', 'Fantasy/Family', 'All Ages', 3.8, 4.0,
             'A girl discovers she can see imaginary friends abandoned by others and embarks on a magical journey.',
             104, 'https://image.tmdb.org/t/p/original/gKkl37BQuKTanygYQG1pyYgLVgf.jpg', DATE '2024-05-17'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.nextval, 'A Quiet Place: Day One', 'Michael Sarnoski', 'Lupita Nyong''o, Joseph Quinn', 'Horror/Sci-Fi', '15+ Rating', 4.0, 4.2,
             'A woman experiences the beginning of the alien invasion in New York City.',
             99, 'https://image.tmdb.org/t/p/original/5mzr6JZbrqnqD8rCEvPhuCE5Fw2.jpg', DATE '2024-06-28'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.nextval, 'Moana 2', 'David G. Derrick Jr.', 'Auli''i Cravalho, Dwayne Johnson', 'Animation/Adventure', 'All Ages', 4.3, 4.4,
             'Moana and Maui embark on a brand-new voyage beyond the reef.',
             98, 'https://image.tmdb.org/t/p/original/moana2.jpg', DATE '2024-11-27'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.nextval, 'Mufasa: The Lion King', 'Barry Jenkins', 'Aaron Pierre, Kelvin Harrison Jr.', 'Animation/Drama', 'All Ages', 4.0, 4.1,
             'Mufasa''s origin story told in a prequel to The Lion King.',
             101, 'https://image.tmdb.org/t/p/original/mufasa.jpg', DATE '2024-12-20'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.nextval, 'The Boy and the Heron', 'Hayao Miyazaki', 'Soma Santoki, Masaki Suda', 'Animation/Fantasy', 'All Ages', 4.5, 4.6,
             'A boy enters a magical world to find his mother, guided by a talking heron.',
             124, 'https://image.tmdb.org/t/p/original/so3LDh7ofv0Q8MUyGyECSt9EBSb.jpg', DATE '2023-12-08'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.nextval, 'Wish', 'Chris Buck, Fawn Veerasunthorn', 'Ariana DeBose, Chris Pine', 'Animation/Fantasy', 'All Ages', 3.9, 4.0,
             'A young girl makes a wish on a star that brings a magical entity to life.',
             95, 'https://image.tmdb.org/t/p/original/AcoVfiv1rrWOmAdpnAMnM56ki19.jpg', DATE '2023-11-22'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.nextval, 'Migration', 'Benjamin Renner', 'Kumail Nanjiani, Elizabeth Banks', 'Animation/Adventure', 'All Ages', 4.0, 4.1,
             'A family of ducks leaves the safety of a New England pond for a vacation in Jamaica.',
             83, 'https://image.tmdb.org/t/p/original/ldfCF9RhR40mppkzmftxapaHeTo.jpg', DATE '2023-12-22'
         );

--다음10개의 인설트
INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Inside the Yellow Cocoon Shell',
             'Phạm Thiên Ân',
             'Lê Phong Vũ, Nguyễn Thịnh, Ngọc Anh',
             'Drama/Mystery', '15+ Rating', 4.1, 4.3,
             'A man brings his sister-in-law’s body back to their hometown and reconnects with faith and meaning.',
             179,
             'https://image.tmdb.org/t/p/original/qDQavBXEzYB7tUYjDIsIE1WbJnW.jpg',
             DATE '2024-05-31'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Kingdom of the Planet of the Apes',
             'Wes Ball',
             'Owen Teague, Freya Allan',
             'Sci-Fi/Action', '15+ Rating', 4.3, 4.4,
             'Several generations after Caesar’s reign, a young ape embarks on a journey.',
             145,
             'https://image.tmdb.org/t/p/original/gmGK5Gw5CIGMPhOmTO0bNA9Q66c.jpg',
             DATE '2024-05-10'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Challengers',
             'Luca Guadagnino',
             'Zendaya, Mike Faist, Josh O''Connor',
             'Drama/Sports', '15+ Rating', 4.2, 4.3,
             'A tennis star is caught in a love triangle with her husband and ex-boyfriend.',
             131,
             'https://image.tmdb.org/t/p/original/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg',
             DATE '2024-04-26'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Ghostbusters: Frozen Empire',
             'Gil Kenan',
             'Paul Rudd, Carrie Coon, Finn Wolfhard',
             'Fantasy/Comedy', '12+ Rating', 3.8, 3.7,
             'Ghostbusters old and new unite to face a chilling ancient evil.',
             115,
             'https://image.tmdb.org/t/p/original/3W7xGpD1B8z3TVI1vzr2xrY6ML1.jpg',
             DATE '2024-03-29'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Civil War',
             'Alex Garland',
             'Kirsten Dunst, Cailee Spaeny, Wagner Moura',
             'Action/Thriller', '15+ Rating', 4.0, 4.2,
             'In a future America, a team of journalists travels to Washington during a violent conflict.',
             109,
             'https://image.tmdb.org/t/p/original/sh7Rg8Er3tFcN9BpKIPOMvALgZd.jpg',
             DATE '2024-04-12'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Dune: Part Two',
             'Denis Villeneuve',
             'Timothée Chalamet, Zendaya, Austin Butler',
             'Sci-Fi/Adventure', '12+ Rating', 4.6, 4.7,
             'Paul Atreides joins the Fremen and seeks revenge against House Harkonnen.',
             166,
             'https://image.tmdb.org/t/p/original/8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg',
             DATE '2024-03-01'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Wish Dragon 2',
             'Chris Appelhans',
             'Jimmy Wong, John Cho',
             'Animation/Fantasy', 'All Ages', 4.1, 4.2,
             'Din and Long return for another adventure to grant wishes in unexpected ways.',
             98,
             'https://image.tmdb.org/t/p/original/wishdragon2.jpg',
             DATE '2025-01-10'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Robot Dreams',
             'Pablo Berger',
             'Ivan Labanda, Rafa Calvo',
             'Animation/Drama', 'All Ages', 4.4, 4.5,
             'A dog and his robot build a beautiful friendship in 1980s New York.',
             102,
             'https://image.tmdb.org/t/p/original/hNFMawyNDWZKKHU4GYCBz1krsRM.jpg',
             DATE '2024-05-31'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Elio',
             'Adrian Molina',
             'Yonas Kibreab, America Ferrera',
             'Animation/Sci-Fi', 'All Ages', 4.0, 4.1,
             'Elio is beamed into space and mistakenly identified as Earth’s ambassador.',
             95,
             'https://image.tmdb.org/t/p/original/elio.jpg',
             DATE '2025-03-07'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Speak No Evil',
             'James Watkins',
             'James McAvoy, Mackenzie Davis',
             'Horror/Thriller', '15+ Rating', 3.9, 4.0,
             'A vacation turns into a nightmare when a family visits acquaintances with sinister motives.',
             101,
             'https://image.tmdb.org/t/p/original/speaknoevil.jpg',
             DATE '2024-09-13'
         );

--다다음10개의 인설트





INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'The Garfield Movie',
             'Mark Dindal',
             'Chris Pratt, Samuel L. Jackson',
             'Animation/Comedy', 'All Ages', 3.9, 4.0,
             'Garfield sets off on a wild outdoor adventure with his long-lost father.',
             101,
             'https://image.tmdb.org/t/p/original/garfield.jpg',
             DATE '2024-05-24'
         );



INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'The Watchers',
             'Ishana Night Shyamalan',
             'Dakota Fanning, Olwen Fouéré',
             'Horror/Fantasy', '15+ Rating', 3.7, 3.8,
             'A woman gets stranded in a forest where unseen creatures stalk her.',
             102,
             'https://image.tmdb.org/t/p/original/watchers.jpg',
             DATE '2024-06-14'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Borderlands',
             'Eli Roth',
             'Cate Blanchett, Kevin Hart',
             'Sci-Fi/Action', '15+ Rating', 4.0, 3.9,
             'A ragtag team sets out on a dangerous mission on the planet Pandora.',
             110,
             'https://image.tmdb.org/t/p/original/borderlands.jpg',
             DATE '2024-08-09'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Beetlejuice Beetlejuice',
             'Tim Burton',
             'Michael Keaton, Jenna Ortega',
             'Fantasy/Comedy', '12+ Rating', 4.3, 4.2,
             'The mischievous spirit returns to haunt the Deetz family once more.',
             104,
             'https://image.tmdb.org/t/p/original/beetlejuice2.jpg',
             DATE '2024-09-06'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Trap',
             'M. Night Shyamalan',
             'Josh Hartnett, Saleka Shyamalan',
             'Thriller/Horror', '15+ Rating', 4.0, 3.8,
             'A father and daughter attend a concert that’s secretly a police trap.',
             98,
             'https://image.tmdb.org/t/p/original/trap.jpg',
             DATE '2024-08-09'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Speak',
             'Laurie Collyer',
             'Kristen Stewart',
             'Drama', '15+ Rating', 4.1, 4.2,
             'A teenager becomes silent after experiencing trauma and slowly learns to speak again.',
             89,
             'https://image.tmdb.org/t/p/original/speak2004.jpg',
             DATE '2024-04-12'
         );

select TITLE,POSTER_URL from MOVIES;

UPDATE PHOENIX.MOVIES
SET POSTER_URL = 'https://image.tmdb.org/t/p/original/m0SbwFNCa9epW1X60deLqTHiP7x.jpg'
WHERE TITLE = 'Moana 2';







INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Paddington in Peru',
             'Dougal Wilson',
             'Ben Whishaw, Hugh Bonneville',
             'Family/Adventure',
             'All Ages',
             4.2,
             4.1,
             'Paddington returns to Peru to visit his Aunt Lucy and embarks on a surprising adventure.',
             103,
             NULL,
             DATE '2025-11-08'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Deadpool 3',
             'Shawn Levy',
             'Ryan Reynolds, Hugh Jackman',
             'Action/Comedy',
             '15+ Rating',
             4.6,
             4.3,
             'Deadpool and Wolverine team up for multiversal chaos and sarcasm.',
             118,
             NULL,
             DATE '2024-11-08'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Gladiator 2',
             'Ridley Scott',
             'Paul Mescal, Denzel Washington',
             'Action/Drama',
             '15+ Rating',
             4.4,
             4.2,
             'The legacy of Maximus lives on as a new warrior rises in the Roman Empire.',
             135,
             NULL,
             DATE '2024-11-22'
         );



INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Wicked: Part One',
             'Jon M. Chu',
             'Cynthia Erivo, Ariana Grande',
             'Musical/Fantasy',
             'All Ages',
             4.3,
             4.1,
             'The untold story of the witches of Oz comes to life in this musical epic.',
             140,
             NULL,
             DATE '2024-11-27'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Moana (Live-Action)',
             'Thomas Kail',
             'Auli''i Cravalho',
             'Adventure/Musical',
             'All Ages',
             4.0,
             3.8,
             'The live-action reimagining of Disney’s beloved oceanic adventure.',
             115,
             NULL,
             DATE '2025-07-10'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Shrek 5',
             'Mike Mitchell',
             'Mike Myers, Eddie Murphy',
             'Animation/Comedy',
             'All Ages',
             4.2,
             4.0,
             'Shrek returns for one final adventure with Donkey and the gang.',
             102,
             NULL,
             DATE '2025-08-15'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Avengers: Secret Wars',
             'Destin Daniel Cretton',
             'Various MCU Cast',
             'Superhero/Action',
             '12+ Rating',
             4.7,
             4.5,
             'The multiverse collides as heroes unite for a final battle.',
             150,
             NULL,
             DATE '2026-05-01'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'The Super Mario Bros. Movie 2',
             'Aaron Horvath',
             'Chris Pratt, Anya Taylor-Joy',
             'Animation/Adventure',
             'All Ages',
             4.3,
             4.0,
             'Mario and Luigi face new challenges in the Mushroom Kingdom.',
             98,
             NULL,
             DATE '2026-04-03'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Avatar 3',
             'James Cameron',
             'Sam Worthington, Zoe Saldana',
             'Sci-Fi/Fantasy',
             '12+ Rating',
             4.6,
             4.4,
             'The journey continues on Pandora with new tribes and ancient threats.',
             165,
             NULL,
             DATE '2025-12-19'
         );

SELECT TITLE, POSTER_URL
FROM MOVIES
WHERE POSTER_URL IS NULL;


1
1
1
1
1
1
1
1
1


INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Fantastic Four',
             'Matt Shakman',
             'Pedro Pascal, Vanessa Kirby',
             'Superhero/Sci-Fi',
             '12+ Rating',
             4.3,
             4.1,
             'Marvel''s first family returns with a brand-new adventure in the MCU.',
             125,
             NULL,
             DATE '2025-07-25'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'The Lord of the Rings: The War of the Rohirrim',
             'Kenji Kamiyama',
             'Brian Cox, Miranda Otto',
             'Animation/Fantasy',
             '12+ Rating',
             4.4,
             4.2,
             'An animated prequel exploring the legacy of Helm Hammerhand, King of Rohan.',
             130,
             NULL,
             DATE '2024-12-13'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Tron: Ares',
             'Joachim Rønning',
             'Jared Leto, Evan Peters',
             'Sci-Fi/Action',
             '15+ Rating',
             4.2,
             3.9,
             'A new chapter in the Tron universe featuring digital warfare and rebellion.',
             140,
             NULL,
             DATE '2025-10-10'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'How to Train Your Dragon (Live-Action)',
             'Dean DeBlois',
             'Mason Thames, Nico Parker',
             'Adventure/Fantasy',
             'All Ages',
             4.5,
             4.3,
             'A live-action retelling of the beloved story of Hiccup and Toothless.',
             112,
             NULL,
             DATE '2025-06-13'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Minecraft: The Movie',
             'Jared Hess',
             'Jason Momoa',
             'Adventure/Family',
             'All Ages',
             3.8,
             3.5,
             'The hit sandbox game is brought to life in an epic live-action film.',
             110,
             NULL,
             DATE '2025-04-04'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'The Smurfs Musical',
             'Chris Miller',
             'Rihanna',
             'Animation/Musical',
             'All Ages',
             4.0,
             3.9,
             'A musical take on the blue beloved characters in a new cinematic universe.',
             95,
             NULL,
             DATE '2025-02-14'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Frozen 3',
             'Jennifer Lee',
             'Idina Menzel, Kristen Bell',
             'Animation/Fantasy',
             'All Ages',
             4.4,
             4.1,
             'Elsa and Anna return to face a mysterious new journey beyond Arendelle.',
             103,
             NULL,
             DATE '2026-11-26'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Zootopia 2',
             'Byron Howard',
             'Ginnifer Goodwin, Jason Bateman',
             'Animation/Comedy',
             'All Ages',
             4.3,
             4.0,
             'Judy and Nick are back to crack down on bigger crimes in Zootopia.',
             101,
             NULL,
             DATE '2025-11-26'
         );

INSERT INTO PHOENIX.MOVIES (
    MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
    USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME,
    POSTER_URL, RELEASE_DATE
) VALUES (
             SEQ_MOVIE_ID.NEXTVAL,
             'Tangled: Ever After',
             'Nathan Greno',
             'Mandy Moore, Zachary Levi',
             'Animation/Romance',
             'All Ages',
             4.1,
             3.9,
             'Rapunzel and Eugene’s new chapter full of adventure and love.',
             99,
             NULL,
             DATE '2026-06-01'
         );


SELECT TITLE,POSTER_URL
FROM MOVIES where POSTER_URL is null;


2
2
2
2
2
2
2

INSERT INTO PHOENIX.MOVIES (MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
                            USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME, POSTER_URL, RELEASE_DATE)
VALUES (
           SEQ_MOVIE_ID.NEXTVAL,
           'Venom: The Last Dance',
           'Kelly Marcel',
           'Tom Hardy',
           'Action/Superhero',
           '15+ Rating',
           4.0,
           3.8,
           'Venom and Eddie Brock face their final chapter together.',
           112,
           NULL,
           DATE '2024-10-25'
       );

INSERT INTO PHOENIX.MOVIES (MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
                            USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME, POSTER_URL, RELEASE_DATE)
VALUES (
           SEQ_MOVIE_ID.NEXTVAL,
           'The Wild Robot',
           'Chris Sanders',
           'Lupita Nyong''o',
           'Animation/Adventure',
           'All Ages',
           4.1,
           4.3,
           'A robot learns to survive and adapt in the wild after a shipwreck.',
           101,
           NULL,
           DATE '2024-09-20'
       );

INSERT INTO PHOENIX.MOVIES (MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
                            USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME, POSTER_URL, RELEASE_DATE)
VALUES (
           SEQ_MOVIE_ID.NEXTVAL,
           'Superman: Legacy',
           'James Gunn',
           'David Corenswet, Rachel Brosnahan',
           'Action/Superhero',
           '12+ Rating',
           4.5,
           4.2,
           'The DC Universe begins anew with a young Superman.',
           134,
           NULL,
           DATE '2025-07-11'
       );

INSERT INTO PHOENIX.MOVIES (MOVIE_ID, TITLE, DIRECTOR, ACTOR, GENRE, RATING,
                            USER_CRITIC, PRO_CRITIC, DESCRIPTION, RUNNING_TIME, POSTER_URL, RELEASE_DATE)
VALUES (
           SEQ_MOVIE_ID.NEXTVAL,
           'Inside Out 3',
           'Kelsey Mann',
           'Amy Poehler',
           'Animation/Drama',
           'All Ages',
           4.4,
           4.2,
           'As Riley matures, new emotions and challenges emerge.',
           100,
           NULL,
           DATE '2026-06-15'
       );
























