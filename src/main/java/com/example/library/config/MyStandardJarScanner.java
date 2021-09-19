package com.example.library.config;

import org.apache.catalina.Context;
import org.apache.tomcat.util.scan.StandardJarScanner;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @Author Summer_DM
 * @Summary TODO  专门用来处理SpringBoot应用集成poi 5.0.0启动报错java.io.FileNotFoundException,
 * TODO 因为使用poi 5.0.0解析excel，会有一些找不到jar包的问题，但是去maven仓库查看发现jar包都在，所以可以不必理会
 *   TODO  java.io.FileNotFoundException: E:\software\apache\maven\maven-repository\library_repo\org\apache\xmlgraphics\batik-ttf2svg\1.13\lib\batik-i18n-1.13.jar (系统找不到指定的路径。)
 * @Version 1.0
 * @Date 2021/9/18 下午 09:29
 **/
@Configuration
public class MyStandardJarScanner {
    @Bean
    public TomcatServletWebServerFactory tomcatFactory() {
        return new TomcatServletWebServerFactory() {
            @Override
            protected void postProcessContext(Context context) {
                ((StandardJarScanner) context.getJarScanner()).setScanManifest(false);
            }
        };
    }
}
