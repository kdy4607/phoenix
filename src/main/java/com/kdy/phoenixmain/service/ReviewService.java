package com.kdy.phoenixmain.service;

import com.kdy.phoenixmain.mapper.ReviewMapper;
import com.kdy.phoenixmain.vo.ReviewVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewService {
    @Autowired
    private ReviewMapper reviewMapper;

    public void writeReview(ReviewVO review) {
        reviewMapper.insertReview(review);
    }

    public List<ReviewVO> getReviews(int movie_id) {
        return reviewMapper.getReviewsByMovieId(movie_id);
    }

    public void updateReview(ReviewVO review) {
        reviewMapper.updateReview(review);
    }

    public void deleteReview(int r_id, String u_id) {
        reviewMapper.deleteReview(r_id, u_id);
    }

}
