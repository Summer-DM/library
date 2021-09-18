package com.example.library.controller;

import com.example.library.utils.paramUtils.ParamUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;

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
    private final String BOOK_FILE_NAME = "批量导入书籍模板.xlsx";
    private final String USER_FILE_NAME = "批量导入用户模板.xlsx";

    /**
     * 文件下载（适用于本地或者项目根路径文件的下载）
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/downloadFile")
    @ResponseBody
    public String downloadFile(HttpServletRequest request, HttpServletResponse response) {
        String fileName = "";
        //获取文件类型  导入用户、导入书籍
        String fileType = ParamUtils.getString(request, "fileType", "");
        if ("user".equals(fileType)) {
            fileName = USER_FILE_NAME;
        } else {
            fileName = BOOK_FILE_NAME;
        }
        log.info("获取文件名称：" + fileName);
        String path = request.getSession().getServletContext().getRealPath("/") + "templates";
        if (fileName != null) {
            //设置文件路径
            File file = new File(path + "/" + fileName);
            if (file.exists()) {
                // 设置强制下载不打开
                response.setContentType("application/force-download");
                //设置文件编码
                response.setCharacterEncoding("UTF-8");
                try {
                    //文件名转码
                    String encodenickname = URLEncoder.encode(fileName, "UTF-8");
                    response.setHeader("Content-Disposition", "attachment;fileName=" + new String(encodenickname.getBytes("UTF-8"), "ISO8859-1"));
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
                byte[] buffer = new byte[2048];
                FileInputStream fis = null;
                BufferedInputStream bis = null;
                try {
                    fis = new FileInputStream(file);
                    bis = new BufferedInputStream(fis);
                    OutputStream os = response.getOutputStream();
                    int i = bis.read(buffer);
                    while (i != -1) {
                        os.write(buffer, 0, i);
                        i = bis.read(buffer);
                    }
                    log.info("\"文件下载成功！\\n文件名:%s，\\n文件路径:%s\", fileName,file.getAbsolutePath()");
                    return String.format("\"文件下载成功！\\n文件名:%s", fileName);
                } catch (Exception e) {
                    e.printStackTrace();
                } finally { // 做关闭操作
                    if (bis != null) {
                        try {
                            bis.close();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                    if (fis != null) {
                        try {
                            fis.close();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        }
        return "下载失败";
    }


}
