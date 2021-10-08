package com.example.library.model;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 登录用户（学生）表
 * @author Summer_DM
 */
@Data
public class User  implements Serializable {

    private static final long serialVersionUID = 1L;
    //主键ID
    private int id;
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
    //用户类型：0管理员，1普通用户
    private String type;
    //用户创建时间
    private Date createTime;
    //用户修改更新时间
    private Date  updateTime;
}
