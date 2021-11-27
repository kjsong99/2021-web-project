package com.example.finalproject;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.time.LocalDateTime;

@WebServlet("/bookWrite")
public class BookWriteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response){


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {




        Connection con = null;
        try{

            HttpSession session= request.getSession();
            String fileName = "";
            FileInputStream fis;
            int maxSize = 1024 * 1024 * 100;
            String realPath = session.getServletContext().getRealPath("/upload");
            MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

            String title=multipartRequest.getParameter("title");
            int price= Integer.parseInt(multipartRequest.getParameter("price"));
            String category = multipartRequest.getParameter("category");
            String writer=multipartRequest.getParameter("writer");
            Timestamp date = Timestamp.valueOf(LocalDateTime.now());
            String company = multipartRequest.getParameter("company");
            String status = multipartRequest.getParameter("status");
            String username = (String)session.getAttribute("id");

            File image = multipartRequest.getFile("image");
            fis=new FileInputStream(image);
            int num=0;


            con = dbConnection.connect();
            Statement st = con.createStatement();
            ResultSet rs=st.executeQuery("select nextval('book_seq') as book_seq from dual");
            if(rs.next()){
                num=rs.getInt(1);
            }
            PreparedStatement pre = con.prepareStatement("insert into BOOK (TITLE, PRICE, WRITER,CATEGORY,DATE,COMPANY,STATUS,USERNAME,NUMBER,IMAGE) VALUES (?,?,?,?,?,?,?,?,?,?)");
            pre.setString(1,title);
            pre.setInt(2,price);
            pre.setString(3,writer);
            pre.setString(4,category);
            pre.setTimestamp(5,date);
            pre.setString(6,company);
            pre.setString(7,status);
            pre.setString(8,username);
//            pre.setString(9,fileName);
            pre.setLong(9,num);
            pre.setBinaryStream(10,(InputStream) fis,(int)image.length());

            pre.executeUpdate();
            System.out.println("Inserting Successfully!");
            pre.close();
            con.close();
            response.sendRedirect("/");

        } catch (Exception e){
            System.out.println(e.getMessage());
        }
    }
}
