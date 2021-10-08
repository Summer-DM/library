package com.example.library.utils.dateUtils;

import org.apache.commons.lang3.time.DateUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @Author Summer_DM
 * @Summary TODO  日期操作类
 * @Version 1.0
 * @Date 2021/9/22 下午 03:33
 **/
public class CommonDateUtils {

    //所有可能的日期格式
    public static String[] parsePatterns = {"yyyy-MM-dd","yyyy年MM月dd日",
            "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd HH:mm", "yyyy/MM/dd",
            "yyyy/MM/dd HH:mm:ss", "yyyy/MM/dd HH:mm","yyyyMMddHHmmssSSS", "yyyyMMddHHmmss","yyyyMMdd"};


    /**
     * 获取几天后的日期
     * @param d
     * @param day
     * @param format
     * @return
     */
    public static String date(Date d ,int day,String format){
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(d);
        //方法一
        //calendar.set(Calendar.DATE,calendar.get(Calendar.DATE) + day);
        calendar.add(Calendar.DATE,day); //把日期往后增加一天,整数往后推,负数往前移动
        if ("".equals(format) || format == null){
            format="yyyyMMdd";
        }
        SimpleDateFormat dateFormat = new SimpleDateFormat(format);
        String ssss = dateFormat.format(calendar.getTime());
        return ssss;
    }

    /**
     * 获取日期
     * @param date 日期字符串
     * @param pattern   日期格式
     * 例如：20210917    yyyyMMdd------>  Fri Sep 17 00:00:00 CST 2021
     * @return
     */
    public static Date getDate(String date, String pattern){
        Date date1 = null;
        try {
            date1 = new SimpleDateFormat(pattern).parse(date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date1;
    }

    /**
     * 将日期已有格式转变为另为一种格式
     * @param date
     * @param pattern1
     * @param pattern2
     * @return
     */
    public static String getDateString(String date, String pattern1, String pattern2){
        if (date == null || "".equals(date)){
            return date;
        }
        Date newDate = null;
        try {
            newDate = new SimpleDateFormat(pattern1).parse(date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        SimpleDateFormat dateFormat = new SimpleDateFormat(pattern2);
        String format = dateFormat.format(newDate);
        return format;
    }

    /**
     * 日期比较
     * @param dateStr1
     * @param dateStr2
     * @return  dateStr1 >= dateStr2 时，返回true
     */
    public static boolean compareDateString(String dateStr1, String dateStr2){
        if (strIsEmpty(dateStr1) || strIsEmpty(dateStr2)){
            return false;
        }
        try {
            Date str1 = DateUtils.parseDate(dateStr1,parsePatterns);
            Date str2 = DateUtils.parseDate(dateStr2,parsePatterns);
            int sum = str1.compareTo(str2);
            return sum >= 0;
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 判断字符串是否为空
     * @param s
     * @return   为空就返回true
     */
    public static boolean strIsEmpty(String s){
        return s == null || "".equals(s);
    }


    public static void main(String[] args) {
        //String mdd = getDateString("2021-09-18 11:15:56","yyyy-MM-dd HH:mm:ss","HH:mm:ss");
        Date date = new Date();
        long time = date.getTime();
        int date1 = date.getDate();
        String s = date.toString();
        boolean b = compareDateString("2021-09-18 11:15:56",String.valueOf(date.getTime()));
        System.out.println(b);
    }
}
