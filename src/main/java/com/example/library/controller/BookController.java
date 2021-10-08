package com.example.library.controller;

import com.example.library.commonResult.CommonDateResult;
import com.example.library.model.Book;
import com.example.library.service.BookService;
import com.example.library.utils.fileUtils.ExcelUtils;
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
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
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
        int result = 0;
        //根据书籍ID去查询库存，如果是多条，则总库存-1；如果是一条，则直接删除
        int bookAmount = bookService.getBookAmount(bid);
        if (bookAmount > 1){
            result = bookService.updateBookAmountById(bid);
        }else {
            result = bookService.deleteBookById(bid);
        }
        if (result >= 1) {
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
        //先去查询数据库中是否已有相同书籍
        int num = bookService.checkBook(book.getBookname(),book.getAuthor());
        int result = 0;
        if (num > 0){
            //有相同书籍，则总数+1(如果是未借阅则，剩余库存+1)
            result = bookService.updateBookAmount(book.getBookname(),book.getAuthor(),book.getBookstate());
        }else {
            //没有则新增一条
            result = bookService.addBook(book);
        }
        if (result > 0) {
            log.info("添加图书成功！");
            return "success";
        } else {
            log.info("添加图书失败！");
            return "error";
        }
    }

    /**
     * 批量导入书籍
     * @param file
     * @return
     */
    @RequestMapping("batchAddBooks")
    @ResponseBody
    public CommonDateResult batchAddBooks(MultipartFile file) {
        //解析excel，并转化为实体类
        List<Object> books = ExcelUtils.readExcel(file,"book");
        log.info("批量导入书籍excel解析结果：{}", books.toString());
        CommonDateResult result = null;
        List<Book> bookList = new ArrayList<>();
        if (books != null && books.size()>0){
            for (Object book: books){
                Book bo = (Book)book;
                //先去查询数据库中是否已有相同书籍
                int num = bookService.checkBook(bo.getBookname(),bo.getAuthor());
                if (num > 0){
                    //如果数据库中已存在，则此条记录总数+1，如果状态为1，则剩余库存+1
                    bookService.updateBookAmount(bo.getBookname(),bo.getAuthor(),bo.getBookstate());
                }else {
                    bookList.add(bo);
                }
            }
            if (bookList != null && bookList.size()>0){
                //插入数据库中
                result = bookService.insertBooks(bookList);
            }
        }
        result.setData(books);
        return result;
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
