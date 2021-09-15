package com.example.library.utils.stringUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author Summer_DM
 * @Summary TODO  字符串处理工具
 * @Version 1.0
 * @Date 2021/9/15 上午 10:28
 **/
public class StringUtils {

    /**
     * 将逗号分割的字符串，全部放进list里边
     *
     * @param str
     * @return
     */
    public static List<String> getList(String str) {
        List<String> list = new ArrayList<>();
        if (!"".equals(str)) {
            String[] types = str.split(",");
            for (String type : types) {
                list.add(type);
            }
        }
        return list;
    }
}
