package com.example.library.controller;

import com.example.library.model.Admin;
import com.example.library.model.Book;
import com.example.library.model.Borrow;
import com.example.library.model.User;
import com.example.library.service.AdminService;
import com.example.library.service.BookService;
import com.example.library.service.BorrowService;
import com.example.library.service.UserService;
import com.example.library.utils.paramUtils.ParamUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.DigestUtils;
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
 * @Summary TODO  注册、登录接口
 * @Version 1.0
 * @Date 2021/9/9 下午 04:27
 **/
@Controller
@RequestMapping("/admin")
public class AdminController {

    private static final Logger log = LoggerFactory.getLogger(AdminController.class);
    @Autowired
    private UserService uService;
    @Autowired
    private AdminService adService;
    @Autowired
    private BookService bookService;
    @Autowired
    private BorrowService borrowService;

    //进入登录页面（地址：localhost:8080/library/admin/login）
    @RequestMapping("/login")
    public String login(HttpSession session){
        //设置seesion超时时间，不设置默认是30分钟，单位是秒
        //session.setMaxInactiveInterval(1*60);
        return "admin/login";
    }

    //学生登录成功后跳转首页
    @RequestMapping("student")
    public String toStudent(){
        log.info("学生登录成功后跳转首页");
        return "admin/student";
    }
    //管理员登录成功后跳转首页
    @RequestMapping("admin")
    public String toAdmin(){
        log.info("管理员登录成功后跳转首页");
        return "admin/toadmin";
    }
    //跳转到添加管理员页面
    @RequestMapping("addadmin")
    public String addAdmin(){
        log.info("跳转到添加管理员页面");
        return "admin/addadmin";
    }

    //跳转到添加图书页面
    @RequestMapping("addbookUI")
    public String addbookUI(){
        log.info("跳转到添加图书页面");
        return "admin/addBookUI";
    }
    //登录(1代表管理员，2代表学生)
    @RequestMapping("/dologin")
    @ResponseBody
    public String dologin(@RequestParam("stuid") String stuid, @RequestParam("password") String password, @RequestParam("role") int role, HttpSession session) {
        if (role == 2) {
            String md5pwd = DigestUtils.md5DigestAsHex(password.getBytes());
            User u = uService.findUserByStuidAndPassword(stuid, md5pwd);
//            System.out.println(u);
            if (u != null) {
                session.setAttribute("username", u.getUsername());
                return "student";
            }
        } else {
            String md5pwd = DigestUtils.md5DigestAsHex(password.getBytes());
            Admin admin = adService.findAdminByStuidAndPassword(stuid, md5pwd);
//            System.out.println(admin);
            if (admin != null) {
                session.setAttribute("username", admin.getName());
                return "admin";
            }
        }
        return "false";
    }


    //添加管理员
    @RequestMapping("doaddadmin")
    public String doaddAdmin(Admin admin) {
        //使用md5加密算法对密码加密
        admin.setPassword(DigestUtils.md5DigestAsHex(admin.getPassword().getBytes()));
        adService.addAdmin(admin);
        return "admin/toadmin";
    }

    //跳转到图书管理页面
    @RequestMapping("booklist")
    public String findAllBooks(Map map) {
        List<Book> booklist = bookService.findAllBooks();
        map.put("booklist", booklist);
        return "admin/booklist";
    }


    //进入用户管理页面
    @RequestMapping("findAllStu")
    public String findAllStu(Map map) {
        List<User> userlist = uService.findAllStu();
        map.put("userlist", userlist);
        return "admin/userlist";
    }

    //进入借阅信息页面(管理员）
    @RequestMapping("allBorrowbooks")
    public String findallBorrowbooks(Map map) {
        List<Borrow> allBorrowbooks = borrowService.findallBorrowbooks();
        map.put("allBorrowbooks", allBorrowbooks);
        return "admin/allBorrowbooks";
    }

    //跳转到图书页面(学生)
    @RequestMapping("borrowbooklist")
    public String borrowbooklist(Map map) {
        List<Book> booklist = bookService.findAllBooks();
        map.put("booklist", booklist);
        return "admin/borrowbooklist";
    }

    //跳转查看我的借阅书籍页面
    @RequestMapping("myBorrow")
    public String myborrow(Map map, HttpSession session) {
        String username = session.getAttribute("username").toString();
        List<Borrow> borrowlist = borrowService.findAllMyBorrow(username);
        map.put("borrowlist", borrowlist);
        return "admin/myborrow";
    }

    //注销
    @RequestMapping("logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "admin/login";
    }

    //跳转到学生注册
    @RequestMapping("toregist")
    public String toregist() {

        return "admin/regist";
    }

    //学生注册
    @RequestMapping("regist")
    public String regist(User user) {
        String md5pwd = DigestUtils.md5DigestAsHex(user.getPassword().getBytes());
        user.setPassword(md5pwd);
        uService.addUser(user);
        return "redirect:login";
    }


    //添加图书
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
            return "success";
        } else {
            return "error";
        }
    }

    //借阅图书
    @RequestMapping("borrowbook")
    public String borrowbook(@RequestParam("bookname") String bookname, @RequestParam("bid") int bid, HttpSession session) throws ParseException {
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
        return "redirect:borrowbooklist";
    }

    //删除图书
    @RequestMapping("delete")
    public String delete(@RequestParam("bid") int bid) {
        bookService.deleteBookById(bid);
        return "redirect:booklist";
    }

    //归还书籍
    @RequestMapping("returnbook")
    public String returnbook(@RequestParam("bid") int bid) {
        //1.删除借阅表中bid=bid的记录
        borrowService.delMyBorrow(bid);
        //2.更新书籍表中的借阅状态
        bookService.upBookByBid(bid);
        return "redirect:myBorrow";
    }
}
