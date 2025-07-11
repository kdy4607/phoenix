package com.kdy.phoenixmain.mapper;

import java.util.List;
import java.util.Map;

public class MovieSqlBuilder {

    // 1. 태그만으로 필터링 (AND 조건)
    public String buildQueryByTagIds(Map<String, Object> params) {
        @SuppressWarnings("unchecked")
        List<Integer> tagIds = (List<Integer>) params.get("tagIds");
        Integer tagCount = (Integer) params.get("tagCount");

        StringBuilder sql = new StringBuilder();

        sql.append("""
            SELECT m.movie_id, m.title, m.director, m.actor, m.genre,
                   m.rating, m.user_critic, m.pro_critic, m.description,
                   m.running_time, m.poster_url
            FROM movies m
            JOIN movie_tags mt ON m.movie_id = mt.movie_id
            JOIN tags t ON mt.tag_id = t.tag_id
        """);

        if (tagIds == null || tagIds.isEmpty()) {
            sql.append(" WHERE 1=1 ");
        } else {
            sql.append(" WHERE t.tag_id IN (");
            for (int i = 0; i < tagIds.size(); i++) {
                sql.append("#{tagIds[").append(i).append("]}");
                if (i < tagIds.size() - 1) {
                    sql.append(", ");
                }
            }
            sql.append(") ");
        }

        sql.append("""
            GROUP BY m.movie_id, m.title, m.director, m.actor, m.genre,
                     m.rating, m.user_critic, m.pro_critic, m.description,
                     m.running_time, m.poster_url
            HAVING COUNT(DISTINCT t.tag_id) = #{tagCount}
        """);

        return sql.toString();
    }

    // 2. 검색어 + 태그 조합 필터링
    public String buildQueryByTagsAndTitle(Map<String, Object> params) {
        @SuppressWarnings("unchecked")
        List<Integer> tagIds = (List<Integer>) params.get("tagIds");
        Integer tagCount = (Integer) params.get("tagCount");
        String title = (String) params.get("title");

        StringBuilder sql = new StringBuilder();

        sql.append("""
            SELECT m.movie_id, m.title, m.director, m.actor, m.genre,
                   m.rating, m.user_critic, m.pro_critic, m.description,
                   m.running_time, m.poster_url
            FROM movies m
            LEFT JOIN movie_tags mt ON m.movie_id = mt.movie_id
            LEFT JOIN tags t ON mt.tag_id = t.tag_id
            WHERE 1 = 1
        """);

        // 제목 필터
        if (title != null && !title.isBlank()) {
            sql.append(" AND m.title LIKE '%' || #{title} || '%' ");
        }

        // 태그 필터
        if (tagIds != null && !tagIds.isEmpty()) {
            sql.append(" AND t.tag_id IN (");
            for (int i = 0; i < tagIds.size(); i++) {
                sql.append("#{tagIds[").append(i).append("]}");
                if (i < tagIds.size() - 1) {
                    sql.append(", ");
                }
            }
            sql.append(") ");

            sql.append("""
                GROUP BY m.movie_id, m.title, m.director, m.actor, m.genre,
                         m.rating, m.user_critic, m.pro_critic, m.description,
                         m.running_time, m.poster_url
                HAVING COUNT(DISTINCT t.tag_id) = #{tagCount}
            """);
        }

        return sql.toString();
    }
    // 3. 태그 중 하나라도 포함된 영화 조회 (상세페이지 유사 영화용)
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
            if (i < tagIds.size() - 1) {
                sql.append(", ");
            }
        }

        sql.append(")");

        // 현재 영화 제외 (상세페이지 유사 추천용)
        if (excludeId != null) {
            sql.append(" AND m.movie_id != #{excludeId}");
        }

        return sql.toString();
    }

}
