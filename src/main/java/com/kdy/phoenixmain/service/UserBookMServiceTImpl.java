package com.kdy.phoenixmain.service;

import com.kdy.phoenixmain.mapper.BookmarkMapper;
import com.kdy.phoenixmain.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserBookMServiceTImpl implements UserBookMServiceT {

    @Autowired
    private BookmarkMapper bookmarkMapper;

    @Override
    public void save(String userId, int movieId) {
        bookmarkMapper.insertBookmark(userId, movieId);
    }

    @Override
    public void delete(String userId, int movieId) {
        bookmarkMapper.deleteBookmark(userId, movieId);
    }

    @Override
    public boolean isBookmarked(String userId, int movieId) {
        return bookmarkMapper.existsBookmark(userId, movieId);
    }

    @Override
    public UserVO findByUsername(String username) {
        return bookmarkMapper.findByUsername(username);
    }
}
