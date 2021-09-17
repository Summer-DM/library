package com.example.library.controller;

import com.example.library.commonResult.CommonDateResult;
import com.example.library.model.Book;
import com.example.library.service.BookService;
import com.example.library.utils.paramUtils.ParamUtils;
import com.example.library.utils.stringUtils.StringUtils;
import com.github.pagehelper.PageInfo;
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
     *
     * @param map
     * @return
     */
    @RequestMapping("booklist")
    public String findAllBooks(Map map) {
        List<Book> booklist = bookService.findAllBooks();
        return "book/booklist";
    }

    //跳转到添加图书页面
    @RequestMapping("addbookUI")
    public String addbookUI() {
        log.info("跳转到添加图书页面");
        return "book/addBookUI";
    }

    //删除图书
    @RequestMapping("delete")
    public String delete(@RequestParam("bid") int bid) {
        int result = bookService.deleteBookById(bid);
        if (result == 1) {
            log.info("删除图书成功！");
            return "redirect:booklist";
        } else {
            log.info("删除图书失败！");
            return "error";
        }
    }

    /**
     * 添加图书
     *
     * @param request
     * @param response
     * @param modelMap
     * @return
     */
    @RequestMapping("addbook")
    @ResponseBody
    public String addbook(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
        Book book = new Book();
        book.setPublicationdate(ParamUtils.getString(request, "publicationdate", ""));
        book.setBookname(ParamUtils.getString(request, "bookname", ""));
        book.setAuthor(ParamUtils.getString(request, "author", ""));
        book.setPublisher(ParamUtils.getString(request, "publisher", ""));
        book.setBooktype(ParamUtils.getString(request, "booktype", ""));
        book.setPrice(ParamUtils.getInt(request, "price", 10));
        book.setBookstate(ParamUtils.getString(request, "bookstate", ""));
        book.setComment(ParamUtils.getString(request, "comment", ""));

        int n = bookService.addBook(book);
        if (n == 1) {
            log.info("添加图书成功！");
            return "success";
        } else {
            log.info("添加图书失败！");
            return "error";
        }
    }

    /**
     * 查询图书
     *
     * @param request
     * @param response
     * @param modelMap
     * @return
     */
    @RequestMapping("queryBookType")
    @ResponseBody
    public CommonDateResult queryBookType(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
        CommonDateResult bookType = bookService.queryBookType();
        bookType.setCode("1");
        bookType.setMessage("查询成功");
        return bookType;
    }

    /**
     * 查询书籍
     * @param request
     * @param response
     * @param modelMap
     * @return
     */
    @RequestMapping("queryBooks")
    @ResponseBody
    public PageInfo<Book> queryBooks(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
        int pageNo = ParamUtils.getInt(request, "pageNo", 1); // 页码
        int pageSize = ParamUtils.getInt(request, "pageSize", 10); // 取得显示条数
        String bookname = ParamUtils.getString(request, "bookname", ""); // 书籍名称
        String authorname = ParamUtils.getString(request, "authorname", ""); // 书籍作者
        String queryType = ParamUtils.getString(request, "booktype", ""); // 书籍类型
        List<String> typeList = StringUtils.getList(queryType);
        PageInfo<Book> booklist = bookService.queryBooks(pageNo,pageSize,bookname,authorname,typeList);
        CommonDateResult bookType = bookService.queryBookType();
        List<Map<String,String>> data = (List<Map<String,String>>)bookType.getData();
        //将类型切换成汉字返回
        List<Book> list = booklist.getList();
            for (int i = 0;i<list.size();i++){
                for (int j = 0;j<data.size();j++){
                    Map<String, String> map = data.get(j);
                    if (map.get("dic_code").equals(list.get(i).getBooktype())){
                        list.get(i).setBooktype(map.get("dic_value"));
                    }
                }
            }
        return booklist;
    }


}
