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

    // 태그 등록
    public void addTag(TagVO tagVO) {
        int result = tagMapper.insertTag(tagVO);
        if (result == 1) {
            System.out.println("[태그 등록 성공] → " + tagVO);
        } else {
            System.out.println("[태그 등록 실패]");
        }
    }

    // 태그 삭제
    public void deleteTag(int tagId) {
        int result = tagMapper.deleteTag(tagId);
        if (result == 1) {
            System.out.println("[태그 삭제 성공] ID: " + tagId);
        } else {
            System.out.println("[태그 삭제 실패]");
        }
    }

    // 태그 수정
    public void updateTag(TagVO tagVO) {
        int result = tagMapper.updateTag(tagVO);
        if (result == 1) {
            System.out.println("[태그 수정 성공] → " + tagVO);
        } else {
            System.out.println("[태그 수정 실패]");
        }
    }
}
