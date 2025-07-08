package com.mz.mzapp.vo;

import lombok.*;

import java.util.Date;
import java.util.List;

@Data
public class MovieVO {
    private int m_no;
    private String m_title;
    private String m_description;
    private String m_poster;
    private List<TagVO> m_tagList;
}
