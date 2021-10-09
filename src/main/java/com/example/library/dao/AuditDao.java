package com.example.library.dao;

import com.example.library.model.SpaceApplication;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Author Summer_DM
 * @Summary TODO
 * @Version 1.0
 * @Date 2021/10/9 下午 02:48
 **/
@Repository
public interface AuditDao {
    List<SpaceApplication> spaceApply();
}
