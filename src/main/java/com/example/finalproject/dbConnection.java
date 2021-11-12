package com.example.finalproject;

import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class dbConnection {
    public static Connection connect(){
        Connection conn=null;
        Properties pro=new Properties();
        String path="./config/conn.properties";
        ClassLoader classLoader=Thread.currentThread().getContextClassLoader();
        InputStream inputStream=classLoader.getResourceAsStream(path);
        try {
            pro.load(inputStream);
        } catch (IOException e) {
            e.printStackTrace();
        }

        try{
            String user=pro.getProperty("user");
            String password=pro.getProperty("password");
            String url=pro.getProperty("url");
            Class.forName(pro.getProperty("driver"));
            conn = DriverManager.getConnection(url, user, password);
            System.out.println("DB 연결 성공");
        }catch (Exception e){
            System.out.println(e);
        }

        return conn;
    }
}
