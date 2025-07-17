package com.kdy.phoenixmain.mapper;

import com.kdy.phoenixmain.vo.TagVO;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface TagMapper {

    // 전체 조회
    @Select("SELECT * FROM tags ORDER BY tag_id")
    List<TagVO> selectAllTag();

    // 하나 조회
    @Select("SELECT * FROM tags WHERE tag_id = #{num}")
    TagVO selectTag(int num);


}
