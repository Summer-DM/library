package com.example.library.commonResult;

import com.example.library.model.Book;
import com.github.pagehelper.PageInfo;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * @Author Summer_DM
 * @Summary TODO  定义一个公共返回结果
 * @Version 1.0
 * @Date 2021/9/14 上午 10:03
 **/
public class DataResultSet implements Serializable {

    //返回状态码
    private long code;
    //返回信息
    private String message;
    //返回页数
    private long pageNo;
    //返回一页条数
    private long pageSize;
    //返回总条数
    private long totalCount;
    //返回的一个list
    private List list;

    @Override
    public String toString() {
        return "DataResultSet{" +
                "code=" + code +
                ", message='" + message + '\'' +
                ", pageNo=" + pageNo +
                ", pageSize=" + pageSize +
                ", totalCount=" + totalCount +
                ", list=" + list +
                '}';
    }

    public long getCode() {
        return code;
    }

    public void setCode(long code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public long getPageNo() {
        return pageNo;
    }

    public void setPageNo(long pageNo) {
        this.pageNo = pageNo;
    }

    public long getPageSize() {
        return pageSize;
    }

    public void setPageSize(long pageSize) {
        this.pageSize = pageSize;
    }

    public long getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(long totalCount) {
        this.totalCount = totalCount;
    }

    public List getList() {
        return list;
    }

    public void setList(List list) {
        this.list = list;
    }

    public void formatNull() {
        if (list != null && list.size() > 0 && list.get(0) instanceof Map) {
            List<Map<String,Object>> target = this.list;
            for (Map<String,Object> map:target){
                for(Map.Entry<String ,Object> entry:map.entrySet()){
                    if(entry.getValue()==null){
                        entry.setValue("");
                    }
                }
            }
        }
    }

}