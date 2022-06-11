package com.example.library.service;

import com.example.library.model.Borrow;
import com.github.pagehelper.PageInfo;

public interface BorrowService {
    void insertByBorrow(Borrow borrow);

    PageInfo<Borrow> queryMyBorrow(int pageNo, int pageSize, String username);

    void delMyBorrow(int bid);

    //List<Borrow> findallBorrowbooks();

    PageInfo<Borrow> queryBorrowers(int pageNo, int pageSize);
}
