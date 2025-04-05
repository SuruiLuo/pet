package com.petHis;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

/**
 * 启动程序
 * 
 * @author petHis
 */
@SpringBootApplication(exclude = { DataSourceAutoConfiguration.class })
public class PetHisApplication
{
    public static void main(String[] args)
    {
        // System.setProperty("spring.devtools.restart.enabled", "false");
        SpringApplication.run(PetHisApplication.class, args);
        System.out.println("(♥◠‿◠)ﾉﾞ  精灵爱宠医院启动成功   ლ(´ڡ`ლ)ﾞ  \n" +
                "////////////////////////////////////////////////////////////\n" +
                "//                          /\\_/\\                         //\n" +
                "//                         ( o.o )                        //\n" +
                "//                         >^< >^<                        //\n" +
                "//      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^     //");
    }
}