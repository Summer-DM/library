package com.example.library.service.impl;

import com.example.library.dao.AuditDao;
import com.example.library.model.Book;
import com.example.library.model.SpaceApplication;
import com.example.library.service.AuditService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author Summer_DM
 * @Summary TODO  审核管理的接口逻辑
 * @Version 1.0
 * @Date 2021/10/9 下午 02:44
 **/
@Service
public class AuditServiceImpl implements AuditService {
    @Autowired
    private AuditDao auditDao;
    @Override
    public PageInfo<SpaceApplication> spaceApply(int pageNo, int pageSize) {
        PageHelper.startPage(pageNo, pageSize);
        List<SpaceApplication> spaceApplication = auditDao.spaceApply();
        PageInfo<SpaceApplication> pageInfo = new PageInfo<>(spaceApplication);
        return pageInfo;
    }
}
