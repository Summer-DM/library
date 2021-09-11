package com.example.library.model;

import lombok.Data;

/**
 * 管理员映射表
 */
@Data
public class Admin {
    //主键ID
    private int aid;
    //管理者姓名
    private String name;
    //登录账号名
    private String stuid;
    //登录密码
    private String password;
}
