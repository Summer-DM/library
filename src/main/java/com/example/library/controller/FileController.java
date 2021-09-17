package com.example.library.controller;

import com.example.library.commonResult.CommonDateResult;
import com.example.library.model.Book;
import com.example.library.service.BookService;
import com.example.library.utils.fileUtiles.ExcelUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

/**
 * @Author Summer_DM
 * @Summary TODO  操作文件接口：文件上传、下载等
 * @Version 1.0
 * @Date 2021/9/16 下午 03:06
 **/
@Controller
@RequestMapping("/file")
public class FileController {

    private static final Logger log = LoggerFactory.getLogger(FileController.class);
    @Autowired
    private BookService bookService;

    /**
     * 文件上传
     * @param file
     * @return
     */
    @RequestMapping("uploadFile")
    @ResponseBody
    public CommonDateResult upload(MultipartFile file) {
        List<Book> books = ExcelUtils.readExcel(file);
        log.info("excel解析结果：{}", books.toString());
        CommonDateResult result = null;
        if (books != null && books.size()>0){
            //插入数据库中
            result = bookService.insertBooks(books);
        }
        result.setData(books);
        return result;
    }
}
