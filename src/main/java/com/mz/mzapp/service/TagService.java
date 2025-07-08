package com.mz.mzapp.service;

import com.mz.mzapp.mapper.TagMapper;
import com.mz.mzapp.mapper.TagMapper;
import com.mz.mzapp.vo.TagVO;
import com.mz.mzapp.vo.TagVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TagService {

    @Autowired
    private TagMapper tagMapper;



    // 전체조회
    public List<TagVO> getAllTag() {
        List<TagVO> tags = tagMapper.selectAllTag();
        System.out.println(tags);
        return tags;
    }

    // 상세조회
    public TagVO detailTag(int num) {
        TagVO tag = tagMapper.selectTag(num);
        System.out.println(tag);
        return tag;
    }



    // 등록
    public void addTag(TagVO tagVO) {
        if (tagMapper.insertTag(tagVO) == 1) {
            System.out.println("add tag success");
        }

    }

    public void delTag(int num) {
        if (tagMapper.deleteTag(num) == 1) {
            System.out.println("delete tag success");
        }
    }

    public void modifyTag(TagVO tag) {
        if (tagMapper.updateTag(tag) == 1) {
            System.out.println("update tag success");
        }
    }


}
