package com.example.library.controller;

import com.example.library.model.User;
import com.example.library.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

/**
 * @Author Summer_DM
 * @Summary TODO  用户管理模块
 * @Version 1.0
 * @Date 2021/9/13 下午 03:45
 **/
@Controller
@RequestMapping("/user")
public class UserController {
    private static final Logger log = LoggerFactory.getLogger(UserController.class);
    @Autowired
    private UserService userService;

    /**
     * 进入用户管理页面
     * @param map
     * @return
     */
    @RequestMapping("findAllStu")
    public String findAllStu(Map map) {
        List<User> userlist = userService.findAllStu();
        map.put("userlist", userlist);
        return "user/userlist";
    }

    /**
     * 新增用户页面
     * @return
     */
    @RequestMapping("addUserPage")
    public String addUserPage(){
        log.info("跳转到添加管理员页面");
        return "user/addUser";
    }

    /**
     * 新增用户
     * @param user
     * @return
     */
    @RequestMapping("addUser")
    public String addUser(User user) {
        //使用md5加密算法对密码加密
        user.setPassword(DigestUtils.md5DigestAsHex(user.getPassword().getBytes()));
        userService.addUser(user);
        return "admin/index";
    }

    /**
     * 删除用户
     * @param id
     * @return
     */
    @RequestMapping("deleteUser")
    public String deleteUser(@RequestParam("userId") int id) {
       int result = userService.deleteUser(id);
        if (result == 1){
            log.info("删除图书成功！");
            return "redirect:findAllStu";
        } else {
            log.info("删除图书失败！");
            return "error";
        }
    }
}
