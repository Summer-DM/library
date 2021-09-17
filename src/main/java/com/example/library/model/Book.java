package com.example.library.model;

import lombok.Data;

/**
 * 书籍实体
 */
@Data
public class Book {
    //主键id
    private int bid;
    //书名
    private String bookname;
    //作者
    private String author;
    //书的类型  武侠、言情等
    private String booktype;
    //出版社
    private String publisher;
    //出版时间
    private String publicationdate;
    //发行价格
    private int price;
    //发行状态
    private String bookstate;
    //备注
    private String comment;
}
