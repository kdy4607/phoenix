package com.kdy.phoenixmain.service;

import com.kdy.phoenixmain.mapper.MovieMapper;
import com.kdy.phoenixmain.vo.MovieVO;
import com.kdy.phoenixmain.vo.TagVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MovieService {

    @Autowired
    private MovieMapper movieMapper;

    // 전체 영화 조회
    public List<MovieVO> getAllMovie() {
        List<MovieVO> movies = movieMapper.selectAllMovie();
        System.out.println("[전체 영화 조회] → " + movies.size() + "건");
        return movies;
    }

    // 단일 영화 상세 조회
    public MovieVO selectOneMovie(int movieId) {
        MovieVO movie = movieMapper.selectOneMovie(movieId);
        System.out.println("[단일 영화 조회] ID: " + movieId + " → " + movie);
        return movie;
    }

    // 태그 ID 기반 영화 필터링 (AND 조건)
    public List<MovieVO> findMoviesByTagIds(List<Integer> tagIds) {
        if (tagIds == null || tagIds.isEmpty()) {
            return getAllMovie();
        }
        List<MovieVO> result = movieMapper.selectMoviesByTagIds(tagIds, tagIds.size());
        System.out.println("[태그 필터링] 선택 태그 수: " + tagIds.size() + " → 결과: " + result.size() + "건");
        return result;
    }


    public List<MovieVO> findMoviesBySearch(String title) {
        return movieMapper.findByTitle(title);
    }

    public List<MovieVO> findMoviesByTagsAndTitle(List<Integer> tagIds, String title) {
        // 아무것도 없으면 전체 조회
        if ((tagIds == null || tagIds.isEmpty()) && (title == null || title.isBlank())) {
            return getAllMovie();
        }

        // 태그 없이 검색어만 있는 경우
        if (tagIds == null || tagIds.isEmpty()) {
            return findMoviesBySearch(title);
        }

        // 검색어 없이 태그만 있는 경우
        if (title == null || title.isBlank()) {
            return findMoviesByTagIds(tagIds);
        }

        // 검색어 + 태그 둘 다 있는 경우
        return movieMapper.selectMoviesByTagsAndTitle(tagIds, tagIds.size(), title);
    }



    public List<TagVO> getTagsbyMovieId(int movieId) {
    return movieMapper.getTagsByMovieId(movieId);
    }


    public List<TagVO> getTagsByMovieId(int movieId) {
       return movieMapper.getTagsByMovieId(movieId);
    }

        // 하나라도 걸리면 보여주는 곳입니다. tap
    public List<MovieVO> selectMoviesByAnyTag(List<Integer> tagIds, int movieId) {
        return movieMapper.selectMoviesByAnyTag(tagIds, movieId);
    }

    public List<MovieVO> getMoviesByStatus(String status) {
        switch (status) {
            case "showing":
                return movieMapper.selectNowShowingMovies();
            case "upcoming":
                return movieMapper.selectUpcomingMovies();
            case "all":
            default:
                return movieMapper.selectAllMovie();
        }
    }

}
