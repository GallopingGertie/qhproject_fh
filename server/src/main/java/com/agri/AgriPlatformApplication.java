package com.agri;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.agri.*.mapper")
public class AgriPlatformApplication {
    public static void main(String[] args) {
        SpringApplication.run(AgriPlatformApplication.class, args);
    }
}
