package com.example.library.service;

import com.example.library.commonResult.CommonDateResult;
import com.example.library.model.Book;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface BookService {
    /**
     * 查询所有书籍
     * @return
     */
    List<Book> findAllBooks();

    /**
     * 根据id去删除一条书籍
     * @param bid
     * @return
     */
    int deleteBookById(int bid);

    /**
     * 新增书籍
     * @param book
     * @return
     */
    int addBook(Book book);

    /**
     * 更新书籍表中的借阅状态（1表示未借阅，2表示已借阅）
     * @param bid
     */
    void updateBookByBid(int bid);
    /**
     * 更新书籍表中的借阅状态（1表示未借阅，2表示已借阅）
     * @param bid
     */
    void upBookByBid(int bid);
    /**
     * 查询书籍类型
     */
    CommonDateResult queryBookType();

    /**
     * 多条件分页查询书籍
     * @param pageNo  页码
     * @param pageSize  页数
     * @param bookname  书籍名称
     * @param authorname    作者名臣
     * @param queryType     书籍类型
     * @return
     */
    PageInfo<Book> queryBooks(int pageNo, int pageSize, String bookname, String authorname, List<String> queryType);

    /**
     * 批量插入书籍
     * @param books
     * @return
     */
    CommonDateResult insertBooks(List<Book> books);

    /**
     * 检查库中是否已有本书记录
     * @param bookname  书名
     * @param authorname    作者名
     * @return
     */
    int checkBook(String bookname, String authorname);

    /**
     * 修改库存
     * @param bookname
     * @param author
     * @param type
     * @return
     */
    int updateBookAmount(String bookname, String author, String type);

    int getTime(Book book);

    /**
     * 获取记录中书籍的总库存个数
     * @param bid
     * @return
     */
    int getBookAmount(int bid);

    /**
     * 更新总库存
     * @param bid
     * @return
     */
    int updateBookAmountById(int bid);

    /**
     * 更新剩余库存
     * @param bid
     */
    void updateBookReserveById(int bid);

    void updateBookReserveByBId(int bid);

    int getBookReserveById(int bid);
}
