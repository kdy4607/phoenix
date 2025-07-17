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

    // 특정 영화의 태그 조회
    public List<TagVO> getTagsByMovieId(int movieId) {
        return movieMapper.getTagsByMovieId(movieId);
    }

    // 상세페이지용: 추천 영화 (공통 태그 포함, 자기 자신 제외)
    public List<MovieVO> selectMoviesByAnyTag(List<Integer> tagIds, int movieId) {
        return movieMapper.selectMoviesByAnyTag(tagIds, movieId);
    }

    // 상세페이지용: 같은 장르 영화 추천
    public List<MovieVO> getRelatedByGenre(int movieId) {
        return movieMapper.selectRelatedMovies(movieId);
    }

    // 유저 평점 기준 정렬 및 랭킹 부여
    public List<MovieVO> applyRanking(List<MovieVO> movies) {
        for (int i = 0; i < movies.size(); i++) {
            movies.get(i).setRanking(i + 1);
        }
        return movies;
    }
<<<<<<< HEAD

    public List<MovieVO> getRelatedByGenre(int movieId) {
        return movieMapper.selectRelatedMovies(movieId); // ★ 이 부분 정상 작동
    }


=======
>>>>>>> 7a8cadfbfea0f06e8e480852afeb6c6b5dd66a14
}
