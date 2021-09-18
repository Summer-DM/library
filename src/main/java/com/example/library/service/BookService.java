package com.example.library.service;

import com.example.library.commonResult.CommonDateResult;
import com.example.library.model.Book;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface BookService {
    List<Book> findAllBooks();

    int deleteBookById(int bid);

    int addBook(Book book);

    void updateBookByBid(int bid);

    void upBookByBid(int bid);

    CommonDateResult queryBookType();

    PageInfo<Book> queryBooks(int pageNo, int pageSize, String bookname, String authorname, List<String> queryType);

    CommonDateResult insertBooks(List<Object> books);
}
