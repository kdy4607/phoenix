package com.kdy.phoenixmain.mapper;

import java.util.List;
import java.util.Map;

public class MovieSqlBuilder {

    // ✅ 상세페이지 추천용: 태그 하나라도 겹치는 영화
    public String buildQueryByAnyTag(Map<String, Object> params) {
        @SuppressWarnings("unchecked")
        List<Integer> tagIds = (List<Integer>) params.get("tags");
        Integer excludeId = (Integer) params.get("excludeId");

        StringBuilder sql = new StringBuilder();
        sql.append("""
            SELECT DISTINCT m.movie_id, m.title, m.director, m.actor, m.genre,
                            m.rating, m.user_critic, m.pro_critic, m.description,
                            m.running_time, m.poster_url
            FROM movies m
            JOIN movie_tags mt ON m.movie_id = mt.movie_id
            WHERE mt.tag_id IN (
        """);

        for (int i = 0; i < tagIds.size(); i++) {
            sql.append("#{tags[").append(i).append("]}");
            if (i < tagIds.size() - 1) sql.append(", ");
        }
        sql.append(")");

        if (excludeId != null) {
            sql.append(" AND m.movie_id != #{excludeId}");
        }

        return sql.toString();
    }
}
