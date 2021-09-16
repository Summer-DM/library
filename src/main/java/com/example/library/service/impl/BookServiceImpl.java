package com.example.library.service.impl;

import com.example.library.commonResult.CommonDateResult;
import com.example.library.dao.BookDao;
import com.example.library.model.Book;
import com.example.library.service.BookService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class BookServiceImpl implements BookService {
    @Autowired
    private BookDao bDao;

    @Override
    public List<Book> findAllBooks() {
        return bDao.findAllBooks();
    }

    @Override
    public int deleteBookById(int bid) {
        return bDao.deleteBookById(bid);
    }

    @Override
    public int addBook(Book book) {
        return bDao.addBook(book);
    }

    @Override
    public void updateBookByBid(int bid) {
        bDao.updateBookByBid(bid);
    }

    @Override
    public void upBookByBid(int bid) {
        bDao.upBookByBid(bid);
    }

    @Override
    public CommonDateResult queryBookType() {
        CommonDateResult resultSet = new CommonDateResult();
        List<Map<String, String>> list = bDao.queryBookType();
        resultSet.setData(list);
        return resultSet;
    }

    @Override
    public PageInfo<Book> queryBooks(int pageNo, int pageSize, String bookname, String authorname, List<String> queryType) {
        //利用PageHelper分页查询 注意：这个一定要放查询语句的前一行,否则无法进行分页,因为它对紧随其后第一个sql语句有效
        PageHelper.startPage(pageNo, pageSize);
        List<Book> userList = bDao.queryBooksByPage(queryType, bookname, authorname);
        PageInfo<Book> pageInfo = new PageInfo<>(userList);
        return pageInfo;
    }
}
