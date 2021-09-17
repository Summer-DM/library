package com.example.library.controller;

import com.example.library.model.Admin;
import com.example.library.model.User;
import com.example.library.service.AdminService;
import com.example.library.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

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

    //进入登录页面（地址：localhost:8080/library/admin/login）
    @RequestMapping("/login")
    public String login(HttpSession session){
        //设置seesion超时时间，不设置默认是30分钟，单位是秒
        //session.setMaxInactiveInterval(1*60);
        return "admin/login";
    }

    /**
     * 登录成功后跳转到首页
     * @param session
     * @return
     */
    @RequestMapping("index")
    public String index(HttpSession session){
        return "admin/index";
    }

    //跳转到添加管理员页面
    @RequestMapping("addadmin")
    public String addAdmin(){
        log.info("跳转到添加管理员页面");
        return "admin/addadmin";
    }
    /**
     * 用户登录
     * @param stuid  用户名
     * @param password  密码
     * @param session
     * @return  登录成功后跳转首页
     */
    @RequestMapping("/toIndex")
    @ResponseBody
    public String toIndex(@RequestParam("stuid") String stuid, @RequestParam("password") String password, HttpSession session) {
        String md5pwd = DigestUtils.md5DigestAsHex(password.getBytes());
        User user = uService.findUserByStuidAndPassword(stuid, md5pwd);
        if (null != user){
            String type = user.getType();
            //将用户信息存入session中
            session.setAttribute("username", user.getUsername());
            session.setAttribute("user", user);
            session.setAttribute("type", type);
            return "index";
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

    //注销
    @RequestMapping("logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "admin/login";
    }

}
