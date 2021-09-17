package com.example.library.service.impl;

import com.example.library.dao.BorrowDao;
import com.example.library.model.Borrow;
import com.example.library.model.User;
import com.example.library.service.BorrowService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BorrowServiceImpl implements BorrowService {
    @Autowired
    private BorrowDao bDao;

    @Override
    public void insertByBorrow(Borrow borrow) {
        bDao.insertByBorrow(borrow);
    }

    @Override
    public List<Borrow> findAllMyBorrow(String username) {
        return bDao.findAllMyBorrow(username);
    }

    @Override
    public void delMyBorrow(int bid) {
        bDao.delMyBorrow(bid);
    }

    @Override
    public List<Borrow> findallBorrowbooks() {
        return bDao.findallBorrowbooks();
    }

    @Override
    public PageInfo<Borrow> queryBorrowers(int pageNo, int pageSize) {
        //利用PageHelper分页查询 注意：这个一定要放查询语句的前一行,否则无法进行分页,因为它对紧随其后第一个sql语句有效
        PageHelper.startPage(pageNo, pageSize);
        List<Borrow> borrowList = bDao.findallBorrowbooks();
        PageInfo<Borrow> pageInfo = new PageInfo<>(borrowList);
        return pageInfo;
    }
}
