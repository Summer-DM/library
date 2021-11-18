package com.example.library.dao;

import com.example.library.model.Hobby;
import org.springframework.stereotype.Repository;

/**
 * @Author Summer_DM
 * @Summary TODO
 * @Version 1.0
 * @Date 2021/11/3 上午 09:57
 **/
@Repository
public interface HobbyDao {
    Hobby getHobbyById(int id);
    void insertHobby(Hobby hobby);

}
