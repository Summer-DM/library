package com.example.library.model;

import lombok.Data;

/**
 * 登录用户（学生）表
 */
@Data
public class User {
    //主键ID
    private int uid;
    //用户名
    private String username;
    //性别
    private String sex;
    //电话
    private String tel;
    //学生所在学院
    private String institute;
    //学生的专业
    private String profession;
    //班级名称
    private String classname;
    //使用的账户（学生的登录id）
    private String stuid;
    //使用的密码
    private String password;
}
