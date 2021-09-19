package com.example.library.service;


import com.example.library.commonResult.CommonDateResult;
import com.example.library.model.Admin;

public interface AdminService {
    Admin findAdminByStuidAndPassword(String stuid, String password);

    void addAdmin(Admin admin);

    CommonDateResult changPassword(int id, String oldPassword, String newPassword);
}
