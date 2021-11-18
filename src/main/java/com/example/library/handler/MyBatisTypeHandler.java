package com.example.library.handler;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.apache.ibatis.type.TypeHandler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

/**
 * @Author Summer_DM
 * @Summary TODO  Mybatis实现自定义TypeHandler
 * TODO 有俩种实现的方法：一、实现TypeHandler接口的实现代码；二、继承BaseTypeHandler
 * TODO 这里只展示第一种。本实例是java中的List类型的数据存入数据库转为varchar类型
 * @Version 1.0
 * @Date 2021/11/3 上午 09:37
 **/
public class MyBatisTypeHandler implements TypeHandler<List<String>> {
    /**
     * 这里表示，我们数据库存储的时候选择用逗号分割开
     * @param preparedStatement
     * @param i
     * @param strings
     * @param jdbcType
     * @throws SQLException
     */
    @Override
    public void setParameter(PreparedStatement preparedStatement, int i, List<String> strings, JdbcType jdbcType) throws SQLException {
        StringBuilder sb = new StringBuilder();
        for(String s : strings){
            sb.append(s).append(",");
        }
        preparedStatement.setString(i,sb.toString().substring(0,sb.toString().length() - 1));
    }

    /**
     * 我们查询数据库时返回结果也需要拼接成一个list
     * @param resultSet
     * @param s
     * @return
     * @throws SQLException
     */
    @Override
    public List<String> getResult(ResultSet resultSet, String s) throws SQLException {
        String[] arr = resultSet.getString(s).split(",");
        return Arrays.asList(arr);
    }
    @Override
    public List<String> getResult(ResultSet resultSet, int i) throws SQLException {
        String[] arr = resultSet.getString(i).split(",");
        return Arrays.asList(arr);
    }
    @Override
    public List<String> getResult(CallableStatement callableStatement, int i) throws SQLException {
        String[] arr = callableStatement.getString(i).split(",");
        return Arrays.asList(arr);
    }
}

//这里是第二种
//public class MyTypeHandler extends BaseTypeHandler<List<String>> {
//    @Override
//    public void setNonNullParameter(PreparedStatement preparedStatement, int i, List<String> list, JdbcType jdbcType) throws SQLException {
//        StringBuffer sb = new StringBuffer();
//        for(String s : list){
//            sb.append(s).append(",");
//        }
//        preparedStatement.setString(i,sb.toString().substring(0,sb.toString().length() - 1));
//    }
//
//    @Override
//    public List<String> getNullableResult(ResultSet resultSet, String s) throws SQLException {
//        String[] arr = resultSet.getString(s).split(",");
//        return Arrays.asList(arr);
//    }
//
//    @Override
//    public List<String> getNullableResult(ResultSet resultSet, int i) throws SQLException {
//        String[] arr = resultSet.getString(i).split(",");
//        return Arrays.asList(arr);
//    }
//
//    @Override
//    public List<String> getNullableResult(CallableStatement callableStatement, int i) throws SQLException {
//        String[] arr = callableStatement.getString(i).split(",");
//        return Arrays.asList(arr);
//    }
//}