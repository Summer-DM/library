package com.example.library.controller;

import com.example.library.commonResult.CommonDateResult;
import com.example.library.model.Book;
import com.example.library.model.Borrow;
import com.example.library.service.BookService;
import com.example.library.service.BorrowService;
import com.example.library.utils.paramUtils.ParamUtils;
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
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

/**
 * @Author Summer_DM
 * @Summary TODO  借阅信息管理接口
 * @Version 1.0
 * @Date 2021/9/13 下午 03:31
 **/
@Controller
@RequestMapping("/borrow")
public class BorrowController {
    private static final Logger log = LoggerFactory.getLogger(BorrowController.class);
    @Autowired
    private BorrowService borrowService;
    @Autowired
    private BookService bookService;
    /**
     * 进入借阅信息页面(管理员）
     * @param map
     * @return
     */
    @RequestMapping("allBorrowbooks")
    public String findallBorrowbooks(Map map) {
        //List<Borrow> allBorrowbooks = borrowService.findallBorrowbooks();
        //map.put("allBorrowbooks", allBorrowbooks);
        return "borrow/allBorrowbooks";
    }

    /**
     * 初始化借阅信息页面
     * @param request
     * @param response
     * @param modelMap
     * @return
     */
    @RequestMapping("queryBorrowers")
    @ResponseBody
    public PageInfo<Borrow> queryBorrowers(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
        int pageNo = ParamUtils.getInt(request, "pageNo", 1); // 页码
        int pageSize = ParamUtils.getInt(request, "pageSize", 10); // 取得显示条数
        PageInfo<Borrow> borrowlist = borrowService.queryBorrowers(pageNo,pageSize);
        return borrowlist;
    }

    /**
     * 跳转查看我的借阅书籍页面
     * @param map
     * @param session
     * @return
     */
    @RequestMapping("myBorrow")
    public String myborrow(Map map, HttpSession session) {
        //String username = session.getAttribute("username").toString();
        //List<Borrow> borrowlist = borrowService.findAllMyBorrow(username);
        //map.put("borrowlist", borrowlist);
        return "borrow/myborrow";
    }

    /**
     * 查看我的借阅书籍页面
     * @param request
     * @param session
     * @return
     */
    @RequestMapping("queryMyBorrow")
    @ResponseBody
    public PageInfo<Borrow> queryMyBorrow(HttpServletRequest request, HttpSession session) {
        int pageNo = ParamUtils.getInt(request, "pageNo", 1); // 页码
        int pageSize = ParamUtils.getInt(request, "pageSize", 10); // 取得显示条数
        String username = session.getAttribute("username").toString();
        PageInfo<Borrow> borrowlist = borrowService.queryMyBorrow(pageNo,pageSize,username);
        return borrowlist;
    }
    /**
     * 归还书籍
     * @param bid
     * @return
     */
    @RequestMapping("returnbook")
    public String returnbook(@RequestParam("bid") int bid) {
        //1.删除借阅表中bid=bid的记录
        borrowService.delMyBorrow(bid);
        //2.更新书籍表中的借阅状态
        bookService.upBookByBid(bid);
        //3、剩余库存+1
        bookService.updateBookReserveByBId(bid);
        return "redirect:myBorrow";
    }

    /**
     * 跳转到图书页面(学生)
     * @param map
     * @return
     */
    @RequestMapping("borrowbooklist")
    public String borrowbooklist(Map map) {
        List<Book> booklist = bookService.findAllBooks();
        map.put("booklist", booklist);
        return "borrow/borrowbooklist";
    }

    /**
     * 借阅图书
     * @param bookname  书籍名称
     * @param bid   书籍id
     * @param session
     * @return
     * @throws ParseException
     */
    @RequestMapping("borrowbook")
    @ResponseBody
    public CommonDateResult borrowbook(@RequestParam("bookname") String bookname, @RequestParam("bid") int bid, HttpSession session) throws ParseException {
        CommonDateResult commonDateResult = new CommonDateResult();
        Borrow borrow = new Borrow();
        borrow.setBookname(bookname);
        borrow.setBid(bid);
        borrow.setBorrower(session.getAttribute("username").toString());
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String time = df.format(System.currentTimeMillis());
        borrow.setBorrowtime(time);
        //添加进借阅表
        borrowService.insertByBorrow(borrow);
        //更新书籍表中的借阅状态（1表示未借阅，2表示已借阅）
        bookService.updateBookByBid(bid);
        //更新库存状态（总库存不变，剩余库存-1）
        bookService.updateBookReserveById(bid);
        //查询剩库存
        int bookReserve = bookService.getBookReserveById(bid);
        commonDateResult.setCode("1");
        commonDateResult.setData(bookReserve);
        return commonDateResult;
    }
}
