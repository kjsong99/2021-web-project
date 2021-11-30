package com.example.finalproject;

import oracle.jdbc.proxy.annotation.Pre;

import java.io.IOException;
import java.sql.*;
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

    public static ArrayList<HashMap<String,String>> sellBook(String username) throws IOException, SQLException { //판매중인 책 arrayList
        ArrayList<HashMap<String,String>> sell=new ArrayList<HashMap<String,String>>();
        Connection con=dbConnection.connect();
        String query="select * from BOOK where SOLD=0 AND USERNAME=?";
        PreparedStatement ps=con.prepareStatement(query);
        System.out.println(username);
        ps.setString(1,username);
        System.out.println(ps.toString());
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

    public static ArrayList<HashMap<String,String>> soldBook(String username) throws IOException, SQLException { //판매완료 책 arrayList
        ArrayList<HashMap<String,String>> sold=new ArrayList<HashMap<String,String>>();
        Connection con=dbConnection.connect();
        String query="select * from BOOK where SOLD=1 AND USERNAME=?";
        PreparedStatement ps=con.prepareStatement(query);
        System.out.println(username);
        ps.setString(1,username);
        System.out.println(ps.toString());
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
}
