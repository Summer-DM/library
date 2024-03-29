package com.example.library;

import com.example.library.dao.HobbyDao;
import com.example.library.model.Book;
import com.example.library.model.Hobby;
import com.example.library.service.BookService;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest
public class LibraryApplicationTests {
    @Autowired
    private BookService bookService;
    @Autowired
    private HobbyDao hobbyDao;

    @Test
    public void contextLoads() {
        Book b = new Book();
        b.setBookname("庆余年");
        b.setAuthor("猫腻");
        //测试当插入一条数据时，可以返回该条数据的id
        int time = bookService.getTime(b);
        System.out.println(b.getBid());
    }

    @Test
    public void testInsert() {
        try {
            Hobby hobby = new Hobby();
            List<String> hobbys = new ArrayList<String>(4);
            hobbys.add("打篮球");
            hobbys.add("爬山");
            hobbys.add("读书");
            hobbys.add("旅游");
            hobby.setHobby(hobbys);
            hobby.setId(3);
            hobby.setUserId(3);
            hobbyDao.insertHobby(hobby);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
    }

    @Test
    public void testSelect() {
        try {
            Hobby hobby = hobbyDao.getHobbyById(1);
            System.out.println("爱好："+hobby);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
    }
    @Test
    public void testSe() {
        int i = sumSubString("2", "4");
        System.out.println(i);
        double v = calculate_it();
        System.out.println(v);
    }

    private int sumSubString(String a, String b){
        int sub = 0;
        while (a.contains(b)){
            sub++;
            a = a.replaceFirst(b,"");
        }
        return sub;
    }


    public double calculate_it() {
        double x = 0.0d;
        double y = 0.0d;
        int total = 0;
        for (int i = 0; i < 7000000; i++) {
            x = Math.random();
            y = Math.random();
            if (Math.sqrt(x * x + y * y) < 1)
                total++;
        }
        return total / 7000000.0;
    }

}
