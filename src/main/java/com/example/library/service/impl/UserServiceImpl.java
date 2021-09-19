package com.example.library.service.impl;

import com.example.library.commonResult.CommonDateResult;
import com.example.library.dao.UserDao;
import com.example.library.model.User;
import com.example.library.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao udao;

    @Override
    public User findUserByStuidAndPassword(String stuid, String password) {
        return udao.findUserByStuidAndPassword(stuid, password);
    }

    @Override
    public CommonDateResult addUser(User user) {
        CommonDateResult resultSet = new CommonDateResult();
        int result = udao.addUser(user);
        if (result > 0) {
            resultSet.setCode("1");
            resultSet.setMessage("新增用户成功");
            resultSet.setStatus(true);
        } else {
            resultSet.setCode("-1");
            resultSet.setMessage("新增用户失败！");
            resultSet.setStatus(false);
        }
        return resultSet;
    }

    @Override
    public PageInfo<User> findAllStu(int pageNo, int pageSize) {
        //利用PageHelper分页查询 注意：这个一定要放查询语句的前一行,否则无法进行分页,因为它对紧随其后第一个sql语句有效
        PageHelper.startPage(pageNo, pageSize);
        List<User> userList = udao.findAllStu();
        PageInfo<User> pageInfo = new PageInfo<>(userList);
        return pageInfo;
    }

    @Override
    public int deleteUser(int id) {
        return udao.deleteUser(id);
    }

    @Override
    public CommonDateResult insertUsers(List<User> userList) {
        CommonDateResult resultSet = new CommonDateResult();
        int result = udao.insertUsers(userList);
        if (result > 0) {
            resultSet.setCode("1");
            resultSet.setMessage("批量导入成功");
            resultSet.setStatus(true);
        } else {
            resultSet.setCode("-1");
            resultSet.setMessage("批量导入失败！");
            resultSet.setStatus(false);
        }
        return resultSet;
    }
}
