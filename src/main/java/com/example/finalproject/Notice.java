package com.example.finalproject;

import java.io.IOException;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;

public class Notice {
    public static ArrayList<HashMap<String,String>> getIndexNotice() throws IOException, SQLException {
        ArrayList<HashMap<String,String>> noticeList=new ArrayList<HashMap<String,String>>();
        Connection con=dbConnection.connect();
        Statement st = con.createStatement();
        ResultSet rs=st.executeQuery("select * from NOTICE");
        int num=0;
        String title="";
        int i=0;
        while (rs.next()) {
            if(i<7){
                i+=1;
                HashMap<String,String> notice=new HashMap<String,String>();
                title = rs.getString(1);
                num=rs.getInt(3);
                notice.put("title",title);
                notice.put("num", String.valueOf(num));
                noticeList.add(notice);
            }
        }
        return noticeList;
    }

    public static ArrayList<HashMap<String,String>> getNotice(int page) throws IOException, SQLException {
        ArrayList<HashMap<String,String>> noticeList=new ArrayList<HashMap<String,String>>();
        int start=(page-1)*10;
        int end=(page)*10;
        Connection con=dbConnection.connect();
        Statement st = con.createStatement();
        PreparedStatement ps=con.prepareStatement("select * from NOTICE limit ?,?");
        ps.setInt(1,start);
        ps.setInt(2,end);
        ResultSet rs=ps.executeQuery();
        int num=0;
        String title="";
        String date="";
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
        int i=0;
        while (rs.next()) {
            HashMap<String,String> notice=new HashMap<String,String>();
            title = rs.getString(1);
            num=rs.getInt(3);
            Timestamp ts=rs.getTimestamp(4);
            date=df.format(ts);
            notice.put("title",title);
            notice.put("num", String.valueOf(num));
            notice.put("date", date);
            noticeList.add(notice);
        }
        return noticeList;
    }

    public static ArrayList<HashMap<String,String>> getSearchNotice(int page,String search,String target) throws IOException, SQLException {
        ArrayList<HashMap<String,String>> searchNoticeList=new ArrayList<HashMap<String,String>>();
        int start=(page-1)*10;
        int end=(page)*10;
        Connection con=dbConnection.connect();
        PreparedStatement ps=con.prepareStatement("select * from NOTICE where "+target+" like ? limit ?,?");
        ps.setString(1,'%'+search+'%');
        ps.setInt(2,start);
        ps.setInt(3,end);;
        ResultSet rs=ps.executeQuery();
        int num=0;
        String title="";
        String date="";
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
        int i=0;
        while (rs.next()) {
            HashMap<String,String> notice=new HashMap<String,String>();
            title = rs.getString(1);
            num=rs.getInt(3);
            Timestamp ts=rs.getTimestamp(4);
            date=df.format(ts);
            notice.put("title",title);
            notice.put("num", String.valueOf(num));
            notice.put("date", date);
            searchNoticeList.add(notice);
        }

        return searchNoticeList;
    }

    public static int getNoticeCount() throws IOException, SQLException {
        int count=0;

        Connection con=dbConnection.connect();
        Statement st = con.createStatement();
        ResultSet rs=st.executeQuery("select count(*) as count from NOTICE");
        if(rs.next()){
            count=rs.getInt(1);
        }
        return count;
    }

    public static int getSearchNoticeCount(String target,String search) throws IOException, SQLException {
        int count=0;

        Connection con=dbConnection.connect();
        PreparedStatement ps=con.prepareStatement("select count(*) as count from NOTICE where "+target+" like ?");
        ps.setString(1,'%'+search+'%');
        ResultSet rs=ps.executeQuery();
        if(rs.next()){
            count=rs.getInt(1);
        }
        return count;
    }
}
