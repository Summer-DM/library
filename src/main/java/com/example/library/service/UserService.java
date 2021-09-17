package com.example.library.service;

import com.example.library.commonResult.CommonDateResult;
import com.example.library.model.User;
import com.github.pagehelper.PageInfo;

public interface UserService {

    User findUserByStuidAndPassword(String stuid, String password);

    CommonDateResult addUser(User user);

    PageInfo<User> findAllStu(int pageNo, int pageSize);

    int deleteUser(int id);
}
