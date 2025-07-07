package com.kdy.phoenixmain.mapper;

import com.kdy.phoenixmain.vo.ScheduleVO;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface ScheduleMapper {

    // 전체조회
    @Select("select * from test_table")
    public List<ScheduleVO> selectAllReview();


}
