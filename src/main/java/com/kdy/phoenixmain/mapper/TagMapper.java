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

    // 삭제
    @Delete("DELETE FROM tags WHERE tag_id = #{num}")
    int deleteTag(int num);

    // 수정
    @Update("""
        UPDATE tags
        SET tag_name = #{tag_name},
            tag_type = #{tag_type}
        WHERE tag_id = #{tag_id}
        """)
    int updateTag(TagVO tag);

    // 등록 (Oracle용)
    @Insert("""
        INSERT INTO tags (tag_id, tag_name, tag_type)
        VALUES (SEQ_TAGS.NEXTVAL, #{tag_name}, #{tag_type})
        """)
    @SelectKey(
            statement = "SELECT SEQ_TAGS.CURRVAL FROM dual",
            keyProperty = "tag_id",
            before = false,
            resultType = int.class
    )
    int insertTag(TagVO tagVO);
}
