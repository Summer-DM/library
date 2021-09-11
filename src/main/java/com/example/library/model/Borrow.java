package com.example.library.model;

import lombok.Data;

/**
 * 借阅表实体
 */
@Data
public class Borrow {
    //主键ID
    private int id;
    //借阅者
    private String borrower;
    //借阅时间
    private String borrowtime;
    //借阅的书名
    private String bookname;
    //关联的书id
    private int bid;
}
