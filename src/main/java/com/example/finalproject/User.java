package com.example.finalproject;

import oracle.jdbc.proxy.annotation.Pre;

import java.io.IOException;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

public class User {
    public static HashMap<String,String> userInfo(String username) throws IOException, SQLException { //유저 정보를 db에서 받아와서 hashmap 리턴
        HashMap<String,String> info=new HashMap<String,String>();
        Connection con=dbConnection.connect();
        String query="select * from USER where USERNAME = ?";
        PreparedStatement ps=con.prepareStatement(query);
        ps.setString(1,username);
        ResultSet rs=ps.executeQuery();
        if(rs.next()){
             String name=rs.getString(2);
             String phone=rs.getString(4);
             String sex=rs.getString(5);
             String birth= String.valueOf(rs.getDate(6));
             String nickname=rs.getString(8);


            info.put("name",name);
            info.put("phone",phone);
            info.put("sex",sex);
            info.put("birth",birth);
            info.put("nickname",nickname);
            System.out.println(info.get("name"));

        }

        return info;
    }

    public static ArrayList<HashMap<String,String>> sellBook(String username,int page) throws IOException, SQLException { //판매중인 책 arrayList
        ArrayList<HashMap<String,String>> sell=new ArrayList<HashMap<String,String>>();
        Connection con=dbConnection.connect();
        int start=(page-1)*8;
        int end=page*8;
        String query="select * from BOOK where SOLD=0 AND USERNAME=? limit ?,?";
        PreparedStatement ps=con.prepareStatement(query);
        ps.setString(1,username);
        ps.setInt(2,start);
        ps.setInt(3,end);
        ResultSet rs=ps.executeQuery();
        while(rs.next()){
            HashMap<String,String> book=new HashMap<String,String>();
            String title=rs.getString(1);
            String price= String.valueOf(rs.getInt(2));
            String writer=rs.getString(3);
            String category=rs.getString(4);
            String date= String.valueOf(rs.getTimestamp(5));
            String company=rs.getString(6);
            String status=rs.getString(7);
            String number= String.valueOf(rs.getInt(10));
            book.put("title",title);
            book.put("price",price);
            book.put("writer",writer);
            book.put("category",category);
            book.put("date",date);
            book.put("company",company);
            book.put("status",status);
            book.put("number",number);
            sell.add(book);
        }
        ps.close();
        con.close();
        return sell;

    }

    public static int sellBookCount(String username) throws IOException, SQLException {
        int count=0;
        Connection con=dbConnection.connect();
        String query="select count(*) as count from BOOK where SOLD=0 AND USERNAME=?";
        PreparedStatement ps=con.prepareStatement(query);
        ps.setString(1,username);
        ResultSet rs=ps.executeQuery();
        if(rs.next()){
            count=rs.getInt(1);
            System.out.println(count);
        }
        return count;
    }

    public static ArrayList<HashMap<String,String>> soldBook(String username,int page) throws IOException, SQLException { //판매완료 책 arrayList
        ArrayList<HashMap<String,String>> sold=new ArrayList<HashMap<String,String>>();
        Connection con=dbConnection.connect();
        int start=(page-1)*8;
        int end=page*8;
        String query="select * from BOOK where SOLD=1 AND USERNAME=? limit ?,?";
        PreparedStatement ps=con.prepareStatement(query);
        ps.setString(1,username);
        ps.setInt(2,start);
        ps.setInt(3,end);
        ResultSet rs=ps.executeQuery();
        while(rs.next()){
            HashMap<String,String> book=new HashMap<String,String>();
            String title=rs.getString(1);
            String price= String.valueOf(rs.getInt(2));
            String writer=rs.getString(3);
            String category=rs.getString(4);
            String date= String.valueOf(rs.getTimestamp(5));
            String company=rs.getString(6);
            String status=rs.getString(7);
            String number= String.valueOf(rs.getInt(10));
            book.put("title",title);
            book.put("price",price);
            book.put("writer",writer);
            book.put("category",category);
            book.put("date",date);
            book.put("company",company);
            book.put("status",status);
            book.put("number",number);
            sold.add(book);
        }
        ps.close();
        con.close();
        return sold;
    }

    public static int soldBookCount(String username) throws IOException, SQLException {
        int count=0;
        Connection con=dbConnection.connect();
        String query="select count(*) as count from BOOK where SOLD=1 AND USERNAME=?";
        PreparedStatement ps=con.prepareStatement(query);
        ps.setString(1,username);
        ResultSet rs=ps.executeQuery();
        if(rs.next()){
            count=rs.getInt(1);
            System.out.println(count);
        }
        return count;
    }

    public static HashMap<String,String> getUser(String username) throws IOException, SQLException {
        HashMap<String,String> user=new HashMap<String,String>();
        Connection con=dbConnection.connect();
        String query="select * from USER where USERNAME=?";
        PreparedStatement ps=con.prepareStatement(query);
        ps.setString(1,username);
        ResultSet rs=ps.executeQuery();
        if(rs.next()){
            String name=rs.getString(2);
            String phone=rs.getString(4);
            String sex=rs.getString(5);
            String birth= String.valueOf(rs.getTimestamp(6));
            String nickname=rs.getString(8);
            user.put("username",username);
            user.put("name",name);
            user.put("phone",phone);
            user.put("sex",sex);
            user.put("birth",birth);
            user.put("nickname",nickname);
        }
        return user;
    }

    public static void passwordChange(String username,String newPwd) throws IOException, SQLException {
        Connection con=dbConnection.connect();
        String query="update USER set PWD=? where USERNAME=?";
        PreparedStatement ps=con.prepareStatement(query);
        ps.setString(1,newPwd);
        ps.setString(2,username);
        ps.executeUpdate();
    }

//    public static void userModify(String username,HashMap<String,String> userInfo) throws ParseException, IOException, SQLException {
//        SimpleDateFormat df1=new SimpleDateFormat("yyyy-MM-dd");
//        String name=userInfo.get("name");
//        String phone=userInfo.get("phone");
//        String sex=userInfo.get("sex");
//        Date birth=df1.parse(userInfo.get("birth"));
//        java.sql.Date sqlDate=new java.sql.Date(birth.getDate());
//        String nickname=userInfo.get("nickname");
//
//        Connection con=dbConnection.connect();
//        String query="update USER set NAME=?, PHONE=?, SEX=?, BIRTH=?, NICKNAME=? where USERNAME=?";
//        PreparedStatement ps=con.prepareStatement(query);
//        ps.setString(1,name);
//        ps.setString(2,phone);
//        ps.setString(3,sex);
//        ps.setDate(4,sqlDate);
//        ps.setString(5,nickname);
//
//        ps.executeUpdate();
//
//    }
}
