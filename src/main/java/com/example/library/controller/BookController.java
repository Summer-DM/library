package com.example.library.controller;

import com.example.library.model.Book;
import com.example.library.service.BookService;
import com.example.library.utils.paramUtils.ParamUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * @Author Summer_DM
 * @Summary TODO  图书管理模块相关接口
 * @Version 1.0
 * @Date 2021/9/13 上午 09:18
 **/
@Controller
@RequestMapping("/book")
public class BookController {
    private static final Logger log = LoggerFactory.getLogger(BookController.class);
    @Autowired
    private BookService bookService;

    /**
     * 跳转到图书管理页面
     * @param map
     * @return
     */
    @RequestMapping("booklist")
    public String findAllBooks(Map map) {
        List<Book> booklist = bookService.findAllBooks();
        map.put("booklist", booklist);
        return "book/booklist";
    }

    //跳转到添加图书页面
    @RequestMapping("addbookUI")
    public String addbookUI(){
        log.info("跳转到添加图书页面");
        return "book/addBookUI";
    }

    //删除图书
    @RequestMapping("delete")
    public String delete(@RequestParam("bid") int bid) {
        int result = bookService.deleteBookById(bid);
        if (result == 1){
            log.info("删除图书成功！");
            return "redirect:booklist";
        } else {
            log.info("删除图书失败！");
            return "error";
        }
    }

    /**
     * 添加图书
     * @param request
     * @param response
     * @param modelMap
     * @return
     */
    @RequestMapping("addbook")
    @ResponseBody
    public String addbook(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
        Book book = new Book();
        book.setPublicationdate(ParamUtils.getString(request,"publicationdate",""));
        book.setBookname(ParamUtils.getString(request,"bookname",""));
        book.setAuthor(ParamUtils.getString(request,"author",""));
        book.setPublisher(ParamUtils.getString(request,"publisher",""));
        book.setType(ParamUtils.getString(request,"type",""));
        book.setPrice(ParamUtils.getInt(request,"price",0));
        book.setState(ParamUtils.getString(request,"state",""));
        book.setComment(ParamUtils.getString(request,"comment",""));
        int n = bookService.addBook(book);
        if (n == 1) {
            log.info("添加图书成功！");
            return "success";
        } else {
            log.info("添加图书失败！");
            return "error";
        }
    }
}
