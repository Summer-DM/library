package com.example.library.model;

import lombok.Data;

import java.util.List;

/**
 * @Author Summer_DM
 * @Summary TODO  用来测试mybatis自定义的handler
 * @Version 1.0
 * @Date 2021/11/3 上午 09:54
 **/
@Data
public class Hobby {
    private Integer id;
    private Integer userId;
    private List<String> hobby;

}
