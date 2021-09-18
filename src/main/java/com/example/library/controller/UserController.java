package com.example.library.controller;

import com.example.library.commonResult.CommonDateResult;
import com.example.library.model.User;
import com.example.library.service.UserService;
import com.example.library.utils.fileUtils.ExcelUtils;
import com.example.library.utils.paramUtils.ParamUtils;
import com.github.pagehelper.PageInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.DigestUtils;
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
        //List<User> userlist = userService.findAllStu();
        //map.put("userlist", userlist);
        return "user/userlist";
    }

    /**
     * 初始化用户管理页面
     * @param request
     * @param response
     * @param modelMap
     * @return
     */
    @RequestMapping("queryUsers")
    @ResponseBody
    public PageInfo<User> queryUsers(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
        int pageNo = ParamUtils.getInt(request, "pageNo", 1); // 页码
        int pageSize = ParamUtils.getInt(request, "pageSize", 10); // 取得显示条数
        PageInfo<User> booklist = userService.findAllStu(pageNo,pageSize);
        return booklist;
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
    @ResponseBody
    public CommonDateResult addUser(User user) {
        //使用md5加密算法对密码加密
        user.setPassword(DigestUtils.md5DigestAsHex(user.getPassword().getBytes()));
        CommonDateResult result = userService.addUser(user);
        return result;
    }

    /**
     * 批量新增用户
     * @param file
     * @return
     */
    @RequestMapping("batchAddUser")
    @ResponseBody
    public CommonDateResult batchAddUser(MultipartFile file) {
        //使用md5加密算法对密码加密
        //解析excel，并转化为实体类
        List<Object> users = ExcelUtils.readExcel(file,"user");
        log.info("excel解析结果：{}", users.toString());
        CommonDateResult result = null;
        List<User> userList = new ArrayList<>();
        if (users != null && users.size()>0){
            for (int i = 0;i<users.size();i++){
                User user =(User) users.get(i);
                //给用户的密码加密
                user.setPassword(DigestUtils.md5DigestAsHex(user.getPassword().getBytes()));
                userList.add(user);
            }
            //插入数据库中
            result = userService.insertUsers(userList);
        }
        result.setData(users);
        return result;
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
