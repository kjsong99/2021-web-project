package com.example.finalproject;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDateTime;

@WebServlet(name = "NotifyWriteServlet", value = "/notice_write")
public class NoticeWriteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection con = null;
        try{

            javax.servlet.http.HttpSession session= request.getSession();

            int num=0;
            String title=request.getParameter("title");
            String username=(String)session.getAttribute("id");
            Timestamp date = Timestamp.valueOf(LocalDateTime.now());
            String content=request.getParameter("content");



            con = dbConnection.connect();
            Statement st = con.createStatement();
            ResultSet rs=st.executeQuery("select nextval('notice_seq') as notice_seq from dual");
            if(rs.next()){
                num=rs.getInt(1);
            }
            PreparedStatement pre = con.prepareStatement("insert into NOTICE (TITLE, USERNAME, NUMBER,DATE,CONTENT) VALUES (?,?,?,?,?)");
            pre.setString(1,title);
            pre.setString(2,username);
            pre.setInt(3,num);
            pre.setTimestamp(4,date);
            pre.setString(5,content);

            pre.executeUpdate();
            System.out.println("Inserting Successfully!");
            pre.close();
            con.close();
        } catch (Exception e){
            System.out.println(e.getMessage());
        }
    }
}
