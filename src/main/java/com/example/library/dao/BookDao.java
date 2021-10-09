package com.example.library.dao;

import com.example.library.model.Book;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface BookDao {

    List<Book> findAllBooks();

    int deleteBookById(int bid);

    int addBook(Book book);

    void updateBookByBid(int bid);

    void upBookByBid(int bid);

    List<Map<String, String>> queryBookType();

    List<Book> queryBooksByPage(List<String> list, String bookname, String authorname);

    int insertBooks(@Param("books") List<Book> books);

    int checkBook(String bookName, String author);

    int updateBookAmount(String bookName, String author, String type);

    int getTime(Book book);

    int getBookAmount(int bid);

    int updateBookAmountById(int bid);

    void updateBookReserveById(int bid);

    void updateBookReserveByBId(int bid);

    int getBookReserveById(int bid);
}
