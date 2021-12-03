package com.example.finalproject;

import com.example.finalproject.dbConnection;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

public class Book {
    public static ArrayList<HashMap<String,String>> getBook(int page) throws IOException, SQLException { //판매완료 책 arrayList
        ArrayList<HashMap<String,String>> bookList=new ArrayList<HashMap<String,String>>();
        int start=(page-1)*8;
        int end=page*8;
        Connection con= dbConnection.connect();
        String query="select * from BOOK where SOLD=0 order by DATE desc limit ?,? ";
        PreparedStatement ps=con.prepareStatement(query);
        ps.setInt(1,start);
        ps.setInt(2,end);
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
        int start=(page-1)*8;
        int end=page*8;
        Connection con=dbConnection.connect();
        String query="select * from BOOK where SOLD=0 AND CATEGORY=? order by DATE desc limit ?,?";
        PreparedStatement ps=con.prepareStatement(query);
        ps.setString(1,category);
        ps.setInt(2,start);
        ps.setInt(3,end);
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
        int start=(page-1)*8;
        int end=page*8;
        Connection con= dbConnection.connect();
        String query="select * from BOOK where SOLD=0 AND "+target+" like ? order by DATE desc limit ?,?";
        PreparedStatement ps=con.prepareStatement(query);
        ps.setString(1,'%'+search+'%');
        ps.setInt(2,start);
        ps.setInt(3,end);
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
        int start=(page-1)*8;
        int end=page*8;
        Connection con=dbConnection.connect();
        String query="select * from BOOK where SOLD=0 AND CATEGORY=? AND "+target+" like ? order by DATE desc limit ?,?";
        PreparedStatement ps=con.prepareStatement(query);
        ps.setString(1,category);
        ps.setString(2,'%'+search+'%');
        ps.setInt(3,start);
        ps.setInt(4,end);
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
        String query="select count(*) as count from BOOK where CATEGORY=? and "+target+" like ? AND SOLD=0";
        Connection con=dbConnection.connect();
        PreparedStatement ps=con.prepareStatement(query);
        ps.setString(1,category);
        ps.setString(2,'%'+search+'%');
        ResultSet rs=ps.executeQuery();
        if(rs.next()){
            count=rs.getInt(1);
        }

        return count;
    }

    public static void bookBuy(int num) throws IOException, SQLException {
        String query="update BOOK set SOLD=1 where NUMBER=?";
        Connection con=dbConnection.connect();
        PreparedStatement ps=con.prepareStatement(query);
        ps.setInt(1,num);
        ps.executeUpdate();
    }

    public static int isBookSold(int num) throws IOException, SQLException {
        int sold=0;
        String query="select SOLD from BOOK where NUMBER=?";
        Connection con=dbConnection.connect();
        PreparedStatement ps=con.prepareStatement(query);
        ps.setInt(1,num);
        ResultSet rs=ps.executeQuery();
        if(rs.next()){
            sold=rs.getInt(1);
        }
        return sold;
    }


}