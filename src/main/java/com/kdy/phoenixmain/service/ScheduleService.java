package com.kdy.phoenixmain.service;

import com.kdy.phoenixmain.mapper.ScheduleMapper;
import com.kdy.phoenixmain.vo.ScheduleVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ScheduleService {

    @Autowired
    private ScheduleMapper scheduleMapper;

    // 전체조회
    public List<ScheduleVO> getAllReview() {
        List<ScheduleVO> schedules = scheduleMapper.selectAllReview();
        System.out.println(schedules);
        return schedules;
    }

}
