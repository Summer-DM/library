package com.example.library.commonResult;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.Serializable;

/**
 * @Author Summer_DM
 * @Summary TODO  公共返回结果封装
 * @Version 1.0
 * @Date 2021/8/13 下午 02:27
 **/
public class CommonDateResult<T> implements Serializable{
    private static final long serialVersionUID = 1L;
    private static final Logger log= LoggerFactory.getLogger(CommonDateResult.class);
    /**
     * 返回状态--默认是true
     */
    private Boolean status=true;
    /**
     * 状态码
     */
    private String code;
    /**
     * 业务码
     */
    private String type;
    /**
     * 状态说明
     */
    private String message;
    /**
     * 返回数据
     */
    private T data;

    public Boolean getStatus() {
        return status;
    }
    public void setStatus(Boolean status) {
        this.status = status;
    }
    public String getCode() {
        return code;
    }
    public void setCode(String code) {
        this.code = code;
    }
    public String getMessage() {
        return message;
    }
    public void setMessage(String message) {
        this.message = message;
    }
    public T getData() {
        return data;
    }
    public void setData(T data) {
        this.data = data;
    }
    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }
    /**
     * 返回成功
     * @param type 业务码
     * @param message 错误说明
     * @param data 数据
     */
    public CommonDateResult(String type, String message, T data) {
        this.status=true;
        this.code ="0";
        this.type=type;
        this.message = message;
        this.data=data;
    }
    public CommonDateResult() {
        this.status=true;
        this.code ="0";
    }
}
