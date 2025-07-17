package com.kdy.phoenixmain.service;

import com.kdy.phoenixmain.mapper.TagMapper;
import com.kdy.phoenixmain.vo.TagVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TagService {

    @Autowired
    private TagMapper tagMapper;

    // 전체 태그 조회
    public List<TagVO> getAllTags() {
        List<TagVO> tags = tagMapper.selectAllTag();
        System.out.println("[태그 전체 조회] → " + tags.size() + "건");
        return tags;
    }

    // 단일 태그 조회
    public TagVO getTagDetail(int tagId) {
        TagVO tag = tagMapper.selectTag(tagId);
        System.out.println("[태그 조회] ID: " + tagId + " → " + tag);
        return tag;
    }


}
