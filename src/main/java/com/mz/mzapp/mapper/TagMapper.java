package com.mz.mzapp.mapper;

import com.mz.mzapp.vo.TagVO;
import com.mz.mzapp.vo.TagVO;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface TagMapper {

    // 전체조회
    @Select("select * from tag_test")
    public List<TagVO> selectAllTag();

    // 하나조회
    @Select("select * from tag_test where t_no=#{num}")
    TagVO selectTag(int num);

    // 삭제
    @Delete("delete tag_test where t_no=#{num}")
    int deleteTag(int num);

    // 수정
    @Update("""
        update tag_test
        set t_name=#{t_name},
            t_type=#{t_type}
        where t_no=#{t_no}
        """)
    int updateTag(TagVO tag);

    @Insert("""
        insert into tag_test (t_no, t_name, t_type)
        values (tag_test_seq.nextval, #{t_name}, #{t_type})
        """)
    int insertTag(TagVO tagVO);
}
