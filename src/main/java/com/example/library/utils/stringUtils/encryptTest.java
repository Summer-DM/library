package com.example.library.utils.stringUtils;

import com.alibaba.druid.filter.config.ConfigTools;
import org.jasypt.encryption.StringEncryptor;
import org.jasypt.util.text.BasicTextEncryptor;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @Author Summer_DM
 * @Summary TODO  springboot配置类加密的2种方法
 * @Version 1.0
 * @Date 2021/10/14 上午 09:26
 **/
public class encryptTest {
    /**
     * 方法一  普通加解密
     * 使用Druid数据库密码加密配置
     */
    @Test
    public void druidEncryptTest1() {
        System.out.println("普通加解密，即不含公私钥的加解密方法");
        //加密
        try {
            String username = ConfigTools.encrypt("root");
            String password = ConfigTools.encrypt("root");
            System.out.println("加密后的数据库用户名：" + username + "\n加密后的数据库密码：" + password);
            //解密
            String newUsername = ConfigTools.decrypt(username);
            String newPassword = ConfigTools.decrypt(password);
            System.out.println("解密后的数据库用户名：" + newUsername + "\n解密后的数据库密码：" + newPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 方法一  包含公私钥的加解密
     * 使用Druid数据库密码加密配置
     */
    @Test
    public void druidEncryptTest2() {
        System.out.println("包含公私钥的加解密");
        //加密
        try {
            //密码明文
            String password = "root";
            String username = "root";
            System.out.println("明文用户名: " + username + "\n明文密码：" + password);
            String[] keyPair = ConfigTools.genKeyPair(512);
            //私钥
            String privateKey = keyPair[0];
            //公钥
            String publicKey = keyPair[1];
            System.out.println("私钥privateKey:" + privateKey);
            System.out.println("公钥publicKey:" + publicKey);
            //用私钥加密后的用户名
            username = ConfigTools.encrypt(privateKey, username);
            //用私钥加密后的密码
            password = ConfigTools.encrypt(privateKey, password);

            System.out.println("加密后的数据库用户名：" + username + "\n加密后的数据库密码：" + password);


            //解密
            String newUsername = ConfigTools.decrypt(publicKey, username);
            String newPassword = ConfigTools.decrypt(publicKey, password);
            System.out.println("解密后的数据库用户名：" + newUsername + "\n解密后的数据库密码：" + newPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * 方法二 jasypt 加解密
     */
    @Test
    public void druidEncryptTest3() {
        System.out.println("jasypt加解密方法,同一个字符加密多次结果不一样，解密后是一样的。");
        //加密
        try {
            BasicTextEncryptor textEncryptor = new BasicTextEncryptor();
            //设置固定的 盐 （盐可以写配置文件中，也可以通过访问请求的url写成动态的；类似于上面方法一的公钥）
            textEncryptor.setPassword("EbfYkitulv73I2p0mXI50JMXoaxZTKJ0");
            String url = textEncryptor.encrypt("jdbc:mysql://localhost:3306/library?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8&useSSL=false");
            String username = textEncryptor.encrypt("root");
            String password = textEncryptor.encrypt("root");
            System.out.println("加密后的数据库url：" + url +"\n加密后的数据库用户名：" + username + "\n加密后的数据库密码：" + password);
            //解密
            String newUsername = textEncryptor.decrypt(username);
            String newPassword = textEncryptor.decrypt(password);
            System.out.println("解密后的数据库用户名：" + newUsername + "\n解密后的数据库密码：" + newPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}