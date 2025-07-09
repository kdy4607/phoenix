package com.kdy.phoenixmain.mapper;

import java.util.List;
import java.util.Map;

public class MovieSqlBuilder {
    public String buildQueryByTags(Map<String, Object> params) {
        List<String> tags = (List<String>) params.get("tags");
        Integer tagCount = (Integer) params.get("tagCount");

        StringBuilder sb = new StringBuilder();
        sb.append("""
            SELECT m.m_no, m.m_title, m.m_description, m.m_poster
            FROM movie_test m
            JOIN movie_tag_test mt ON m.m_no = mt.movie_no
            JOIN tag_test t ON mt.tag_no = t.t_no
            WHERE t.t_name IN 
        """);

        sb.append(" (");
        for (int i = 0; i < tags.size(); i++) {
            sb.append("#{tags[").append(i).append("]}");
            if (i < tags.size() - 1) sb.append(", ");
        }
        sb.append(")");

        sb.append("""
            GROUP BY m.m_no, m.m_title, m.m_description, m.m_poster
            HAVING COUNT(DISTINCT t.t_name) = #{tagCount}
        """);

        return sb.toString();
    }
}