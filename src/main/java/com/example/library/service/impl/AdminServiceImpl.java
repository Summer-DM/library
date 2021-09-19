package com.example.library.service.impl;

import com.example.library.commonResult.CommonDateResult;
import com.example.library.dao.AdminDao;
import com.example.library.model.Admin;
import com.example.library.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminDao aDao;
    @Override
    public Admin findAdminByStuidAndPassword(String stuid, String password) {
        return aDao.findAdminByStuidAndPassword( stuid,  password);
    }

    @Override
    public void addAdmin(Admin admin) {
        aDao.addAdmin(admin);
    }

    @Override
    public CommonDateResult changPassword(int id, String oldPassword, String newPassword) {
        CommonDateResult resultSet = new CommonDateResult();
        int result = aDao.updatePassword(id, oldPassword, newPassword);
        if (result > 0) {
            resultSet.setCode("1");
            resultSet.setMessage("密码修改成功");
            resultSet.setStatus(true);
        } else {
            resultSet.setCode("-1");
            resultSet.setMessage("密码修改失败！");
            resultSet.setStatus(false);
        }
        return resultSet;
    }
}
