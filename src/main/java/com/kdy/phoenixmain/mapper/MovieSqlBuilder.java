package com.kdy.phoenixmain.mapper;

import java.util.List;
import java.util.Map;
import java.util.StringJoiner;

public class MovieSqlBuilder {

    public String buildQueryByTagIds(Map<String, Object> params) {
        @SuppressWarnings("unchecked")
        List<Integer> tagIds = (List<Integer>) params.get("tagIds");
        Integer tagCount = (Integer) params.get("tagCount");

        StringBuilder sql = new StringBuilder();

        // 기본 SELECT 문
        sql.append("""
                    SELECT m.movie_id, m.title, m.director, m.actor, m.genre,
                           m.rating, m.user_critic, m.pro_critic, m.description,
                           m.running_time, m.poster_url
                    FROM movies m
                    JOIN movie_tags mt ON m.movie_id = mt.movie_id
                    JOIN tags t ON mt.tag_id = t.tag_id
                    WHERE
                """);

        // IN 절 구성
        if (tagIds == null || tagIds.isEmpty()) {
            sql.append(" 1 = 1 "); // 전체 조회 (태그 없으면 조건 제거)
        } else {
            sql.append(" t.tag_id IN (");
            for (int i = 0; i < tagIds.size(); i++) {
                sql.append("#{tagIds[").append(i).append("]}");
                if (i < tagIds.size() - 1) {
                    sql.append(", ");
                }
            }
            sql.append(") ");
        }

        // GROUP BY & HAVING (AND 조건 구현)
        sql.append("""
                    GROUP BY m.movie_id, m.title, m.director, m.actor, m.genre,
                             m.rating, m.user_critic, m.pro_critic, m.description,
                             m.running_time, m.poster_url
                    HAVING COUNT(DISTINCT t.tag_id) = #{tagCount}
                """);

        return sql.toString();
    }

    public String buildQueryByAnyTag(Map<String, Object> params) {
        @SuppressWarnings("unchecked")
        List<Integer> tags = (List<Integer>) params.get("tags");
        int excludeId = (int) params.get("excludeId");

        StringJoiner tagIn = new StringJoiner(",", "(", ")");
        for (Integer tag : tags) {
            tagIn.add(tag.toString());
        }

        return """ 
                    SELECT * FROM movies
                    WHERE movie_id IN (
                        SELECT DISTINCT movie_id
                        FROM movie_tags
                        WHERE tag_id IN %s
                    )
                    AND movie_id != %d
                """.formatted(tagIn.toString(), excludeId);
    }


}
