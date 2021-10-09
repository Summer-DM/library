package com.example.library.model;

import lombok.Data;

import java.util.Date;

/**
 * @Author Summer_DM
 * @Summary TODO  场地申请
 * @Version 1.0
 * @Date 2021/10/9 下午 02:24
 **/
@Data
public class SpaceApplication {
    //主键ID
    private int id;
    //申请人姓名
    private String applicant;
    //申请的教室
    private String applied_classroom;
    //申请时间
    private Date create_time;
    //审核人
    private String reviewer;
    //审核通过时间
    private Date approval_time;
    //使用时长（单位是天）
    private String occupation_days;
    //审核状态（0：未审核，1：审核中，2：审核通过）
    private String approval_status;
    //申请人学号
    private String applicant_id;
}
