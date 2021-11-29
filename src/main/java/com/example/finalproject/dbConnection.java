package com.example.finalproject;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class dbConnection {
    public static Connection connect() throws IOException {
        Connection conn=null;
        Properties pro=new Properties();
        String path="/Users/song-gyeongjin/jsp/finalProject/src/main/webapp/config/conn.properties";
        FileInputStream fis=new FileInputStream(path);
        pro.load(new BufferedInputStream(fis));

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
