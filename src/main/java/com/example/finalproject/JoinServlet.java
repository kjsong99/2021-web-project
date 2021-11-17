package com.example.finalproject;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "JoinServlet", value = "/join")
public class JoinServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("/join.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id=request.getParameter("id");
        String pwd=request.getParameter("pwd");
        String name=request.getParameter("name");
        String phone=request.getParameter("phone1")+"-"+
                request.getParameter("phone2")+"-"+
                request.getParameter("phone3");
        String sex=request.getParameter("sex");
        String birth=request.getParameter("birth1")+"-"+
                request.getParameter("birth2")+"-"+
                request.getParameter("birth3");
        String nickname=request.getParameter("nickname");

        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        Date dateBirth= null;
        try {
            dateBirth = df.parse(birth);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        java.sql.Date sqlBirth=new java.sql.Date(dateBirth.getTime());

        String query = "INSERT INTO USER(USERNAME, NAME, PWD, PHONE, SEX, BIRTH,NICKNAME) VALUES (?,?,?,?,?,?,?)";
        Connection conn=null;
        PreparedStatement pst=null;

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8");
        PrintWriter writer= response.getWriter();

        try {
            conn = dbConnection.connect();
            System.out.println(name);
            pst=conn.prepareStatement(query);
            pst.setString(1,id);
            pst.setString(2,name);
            pst.setString(3,pwd);
            pst.setString(4,phone);
            pst.setString(5,sex);
            pst.setDate(6, sqlBirth);
            pst.setString(7,nickname);

            if(pst.executeUpdate()>0){
                writer.println("회원가입 성공<br>");
                writer.println("<a href='/'>홈</a>");
            }


        } catch (Exception e) {
            writer.println("회원가입 실패<br>");
            writer.println("<a href='/join.jsp'>재시도</a>");
            System.out.println(e);
        } finally {
            try {
                if (pst != null)
                    pst.close();

                if (conn != null)
                    conn.close();
            } catch (Exception e) {
                System.out.println(e);
            }
        }
    }
}
