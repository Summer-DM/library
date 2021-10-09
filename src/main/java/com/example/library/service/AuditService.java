package com.example.library.service;

import com.example.library.model.SpaceApplication;
import com.github.pagehelper.PageInfo;

/**
 * @Author Summer_DM
 * @Summary TODO  审核管理接口
 * @Version 1.0
 * @Date 2021/10/9 下午 02:44
 **/
public interface AuditService {
    PageInfo<SpaceApplication> spaceApply(int pageNo, int pageSize);
}
