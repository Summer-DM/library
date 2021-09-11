package com.example.library.utils.paramUtils;

import org.apache.commons.lang3.StringEscapeUtils;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @Author Summer_DM
 * @Summary TODO   处理前端传进来的request参数
 * @Version 1.0
 * @Date 2021/8/17 上午 11:06
 **/
public class ParamUtils {

    // 是否进行JS语法替换为转义，不建议开启
    // 最好是页面输出参数的时候做转义
    private static final boolean JS_STYLE_CHECK = false;

    public static int getInt(HttpServletRequest request, String paramName) throws NumberFormatException {
        int temp;
        temp = Integer.parseInt(getString(request, paramName));
        return temp;
    }

    public static int getInt(HttpServletRequest request, String paramName, int defaultInt) {
        try {
            String temp = getString(request, paramName);
            if (temp == null) {
                return defaultInt;
            } else {
                return Integer.parseInt(temp);
            }
        } catch (NumberFormatException e) {
            //e.printStackTrace();
            return defaultInt;
        }
    }

    public static String getString(HttpServletRequest request, String paramName) {
        String temp = request.getParameter(paramName);
        temp = ParamFilter.commonFilter(temp,request);
        /*if (temp != null) {
            // 新增安全注入抵抗的代码
            temp = getSafeSql(temp);
            //新增过滤入参，阻止XSS攻击
            temp = getSafeEncode(temp);
        }*/
        return temp;
    }

    public static String getString(HttpServletRequest request, String paramName, String defaultString) {
        String temp = request.getParameter(paramName);
        temp = ParamFilter.commonFilter(temp,request);
        /*if (temp != null) {
            // 新增安全注入抵抗的代码
            temp = getSafeSql(temp);
            //新增过滤入参，阻止XSS攻击
            temp = getSafeEncode(temp);
        }*/
        return temp == null ? defaultString : temp;
    }

    /**
     * 获取日期类型数据
     * @param request
     * @param name
     * @param format
     * @param def
     * @return
     */
    public static Date getDate(HttpServletRequest request, String name, String format, Date def) {
        String valStr = request.getParameter(name);
        valStr = ParamFilter.commonFilter(valStr,request);
        if (valStr != null && !valStr.equals("")) {
            SimpleDateFormat sdf = new SimpleDateFormat(format);
            try {
                return sdf.parse(valStr);
            } catch (ParseException e) {
                //
            }
        }
        return def;
    }

    /**
     * URL传参数据过滤html字符，以防止XSS攻击
     *
     * @return 安全的字符串
     */
    public static String getSafeEncode(String input) {
        if (input == null) {
            return input;
        }
        StringBuilder sb = new StringBuilder(input.length());
        for (int i = 0, c = input.length(); i < c; i++) {
            char ch = input.charAt(i);
            switch (ch) {
                case '&':
                    sb.append("&amp;");
                    break;
                case '<':
                    sb.append("&lt;");
                    break;
                case '>':
                    sb.append("&gt;");
                    break;
                case '"':
                    sb.append("&quot;");
                    break;
                case '\'':
                    sb.append("&#x27;");
                    break;
//                case '/': sb.append("&#x2F;");
//                    break;
                default:
                    sb.append(ch);
            }
        }
        return sb.toString();
    }


}
