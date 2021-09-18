package com.example.library.dao;

import com.example.library.model.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserDao {
    User findUserByStuidAndPassword(@Param("stuid") String stuid, @Param("password")String password);

    int addUser(User user);

    List<User> findAllStu();

    int deleteUser(int id);

    int insertUsers(@Param("users") List<User> userList);
}
