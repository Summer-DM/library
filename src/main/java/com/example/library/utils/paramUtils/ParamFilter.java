package com.example.library.utils.paramUtils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.List;

/**
 * @Author Summer_DM
 * @Summary TODO   用于request传入参数的白名单校验、防止SQL注入、 防止XSS攻击
 * @Version 1.0
 * @Date 2021/8/17 上午 11:07
 **/
public class ParamFilter {

    private static final Logger logger = LoggerFactory.getLogger(ParamFilter.class);
    //设置过滤路径白名单
    final static String[] whiteUrl = {"/plug-in/common/go.jsp"};
    static List urlList = null;

    static {
        urlList = Arrays.asList(whiteUrl);
    }

    final static String[] fileEndWiths = {".xml", "./", ".properties", ".conf"};
    /*输入参数需要控制的字符串  过滤sql关键词，js关键词*/
    final static String[] filterStrArr = {" select ", " from", "insert", "update", "drop",
            "exec", "delete", "truncate", "and", "union", "or", "'", ">", "<", "=", "|", "&", "/", "--", "#", "+", "*", ":", "%", "onerror", "onkeyup", "onclick",
            "oncomplete", "onload", "onmouseover", "onmouseout", "onabort", "onblur", "onchange",
            "ondblclick", "onfocus", "onkeydown", "onkeypress", "onmousedown", "onmouseup", "onreset",
            "onresize", "onselect", "onsubmit", "onunload", "JavaScript", "Script", "frame", "src", "cookie",
            "style", "expression", "+select", "select+", "+from", "from+", "+insert", "insert+", "+update",
            "update+", "+drop", "drop+", "exec+", "+exec", "+delete", "delete+", "+truncate", "truncate+",
            "+and", "and+", "+union", "union+", "+or", "or+", "iframe", "alert", "while", "eval", "sleep", "function"};

    /*输入参数控制  start*/
    public static String commonFilter(String param, HttpServletRequest request) {

        logger.debug("入参为：" + param);

        if (checkWhiteUrl(request)) {
            return param == null ? "" : param;
        }

        if (param != null && !param.equals("")) {
            try {
                //过滤配置文件
                param = filterFileEndWiths(param);
                //过滤sql关键词，js关键词
                if (!param.equals("")) {
                    param = filterParamStrArr(param);
                }
//                //防止sql注入
//                if (!param.equals("")){
//                    param = ESAPI.encoder().encodeForSQL(new OracleCodec(),param);
//                }
//                //防止XSS攻击
//                if (param != null && !param.equals("")){
//                    param = ESAPI.encoder().encodeForHTML(param);
//                }
            } catch (Exception e) {
                e.printStackTrace();
                param = "";
            }
        }
        logger.debug("过滤后参为：" + param);
        return param;
    }

    /**
     * 检查白名单请求
     * @param request
     * @return
     */
    public static boolean checkWhiteUrl(HttpServletRequest request) {
        boolean isWhite = false;
        String uri = request.getRequestURI();
        if (urlList.contains(uri)) {
            isWhite = true;
        }
        logger.debug("是否白名单请求：" + isWhite);
        return isWhite;
    }

    /**
     * 特殊文件过滤
     * @param param
     * @return
     */
    public static String filterFileEndWiths(String param) {
        for (int i = 0; i < fileEndWiths.length; i++) {
            if (param.contains(fileEndWiths[i])) {
                param = "";
                break;
            }
        }
        return param;
    }

    /**
     * 过滤sql关键词，js关键词
     * @param param
     * @return
     */
    public static String filterParamStrArr(String param) {
        String temp = param.toLowerCase();
        for (int i = 0; i < filterStrArr.length; i++) {
            if (temp.contains(filterStrArr[i].toLowerCase())) {
                param = "";
                break;
            }
        }
        return param;
    }
}
