package com.example.finalproject;

import com.example.finalproject.dbConnection;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

public class Book {
    public static ArrayList<HashMap<String,String>> getBook(int page) throws IOException, SQLException { //판매완료 책 arrayList
        ArrayList<HashMap<String,String>> bookList=new ArrayList<HashMap<String,String>>();
        Connection con= dbConnection.connect();
        String query="select * from BOOK where SOLD=0";
        PreparedStatement ps=con.prepareStatement(query);
        System.out.println(ps.toString());
        ResultSet rs=ps.executeQuery();
        while(rs.next()){
            HashMap<String,String> book=new HashMap<String,String>();
            String title=rs.getString(1);
            String price= String.valueOf(rs.getInt(2));
            String number= String.valueOf(rs.getInt(10));
            book.put("title",title);
            book.put("price",price);
            book.put("number",number);
            bookList.add(book);
        }
        ps.close();
        con.close();
        return bookList;
    }
    public static ArrayList<HashMap<String,String>> getCategoryBook(String category,int page) throws IOException, SQLException { //판매완료 책 arrayList
        ArrayList<HashMap<String,String>> categoryBookList=new ArrayList<HashMap<String,String>>();
        Connection con=dbConnection.connect();
        String query="select * from BOOK where SOLD=0 AND CATEGORY=?";
        PreparedStatement ps=con.prepareStatement(query);
        ps.setString(1,category);
        System.out.println(ps.toString());
        ResultSet rs=ps.executeQuery();
        while(rs.next()){
            HashMap<String,String> book=new HashMap<String,String>();
            String title=rs.getString(1);
            String price= String.valueOf(rs.getInt(2));
            String number= String.valueOf(rs.getInt(10));
            book.put("title",title);
            book.put("price",price);
            book.put("number",number);
            categoryBookList.add(book);
        }
        ps.close();
        con.close();
        return categoryBookList;
    }

    public static ArrayList<HashMap<String,String>> getBookSearch(String search,String target,int page) throws IOException, SQLException { //판매완료 책 arrayList
        ArrayList<HashMap<String,String>> bookList=new ArrayList<HashMap<String,String>>();
        Connection con= dbConnection.connect();
        String query="select * from BOOK where SOLD=0 AND "+target+" like ?";
        PreparedStatement ps=con.prepareStatement(query);
        ps.setString(1,'%'+search+'%');
        System.out.println(ps.toString());
        ResultSet rs=ps.executeQuery();
        while(rs.next()){
            HashMap<String,String> book=new HashMap<String,String>();
            String title=rs.getString(1);
            String price= String.valueOf(rs.getInt(2));
            String number= String.valueOf(rs.getInt(10));
            book.put("title",title);
            book.put("price",price);
            book.put("number",number);
            bookList.add(book);
        }
        ps.close();
        con.close();
        return bookList;
    }

    public static ArrayList<HashMap<String,String>> getCategoryBookSearch(String category,String search,String target,int page) throws IOException, SQLException { //판매완료 책 arrayList
        ArrayList<HashMap<String,String>> categoryBookList=new ArrayList<HashMap<String,String>>();
        Connection con=dbConnection.connect();
        String query="select * from BOOK where SOLD=0 AND CATEGORY=? AND "+target+" like ?";
        PreparedStatement ps=con.prepareStatement(query);
        ps.setString(1,category);
        ps.setString(2,'%'+search+'%');
        System.out.println(ps.toString());
        ResultSet rs=ps.executeQuery();
        while(rs.next()){
            HashMap<String,String> book=new HashMap<String,String>();
            String title=rs.getString(1);
            String price= String.valueOf(rs.getInt(2));
            String number= String.valueOf(rs.getInt(10));
            book.put("title",title);
            book.put("price",price);
            book.put("number",number);
            categoryBookList.add(book);
        }
        ps.close();
        con.close();
        return categoryBookList;
    }

    public static int getBookCount() throws IOException, SQLException {
        int count=0;
        String query="select count(*) as count from BOOK where SOLD=0";
        Connection con=dbConnection.connect();
        Statement st=con.createStatement();
        ResultSet rs=st.executeQuery(query);
        if(rs.next()){
            count=rs.getInt(1);
        }

        return count;
    }

    public static int getCategoryBookCount(String category) throws IOException, SQLException {
        int count=0;
        String query="select count(*) as count from BOOK where CATEGORY=? AND SOLD=0";
        Connection con=dbConnection.connect();
        PreparedStatement ps=con.prepareStatement(query);
        ps.setString(1,category);
        ResultSet rs=ps.executeQuery();
        if(rs.next()){
            count=rs.getInt(1);
        }
        return count;
    }

    public static int getBookSearchCount(String target,String search) throws IOException, SQLException {
        int count=0;
        String query="select count(*) as count from BOOK where "+target+" like ? AND SOLD=0";

        Connection con=dbConnection.connect();
        PreparedStatement ps=con.prepareStatement(query);
        ps.setString(1,search);
        ResultSet rs=ps.executeQuery();
        if(rs.next()){
            count=rs.getInt(1);
        }

        return count;
    }

    public static int getCategoryBookSearchCount(String category,String target,String search) throws IOException, SQLException {
        int count =0;
        String query="select count(*) as count from BOOK where CATEGORY=? and "+target+" like ? AMD SOLD=0";
        Connection con=dbConnection.connect();
        PreparedStatement ps=con.prepareStatement(query);
        ps.setString(1,category);
        ps.setString(2,search);
        ResultSet rs=ps.executeQuery();
        if(rs.next()){
            count=rs.getInt(1);
        }

        return count;
    }
}
