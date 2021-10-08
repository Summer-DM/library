package com.example.library;

import com.example.library.model.Book;
import com.example.library.service.BookService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest
public class LibraryApplicationTests {
    @Autowired
    private BookService bookService;
    @Test
    public void contextLoads() {
        Book b = new Book();
        b.setBookname("庆余年");
        b.setAuthor("猫腻");
        //测试当插入一条数据时，可以返回该条数据的id
        int time = bookService.getTime(b);
        System.out.println(b.getBid());
    }

}
