package com.kdy.phoenixmain.service;

import com.kdy.phoenixmain.mapper.BookmarkMapper;
import com.kdy.phoenixmain.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

@Service
public class UserBookMServiceT {

    @Autowired
    private BookmarkMapper bookmarkMapper;

    public UserVO findByUsername(@RequestParam("username") String username){
        return bookmarkMapper.findByUsername(username);
    }



}