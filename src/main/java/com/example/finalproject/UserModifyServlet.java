package com.example.finalproject;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "UserModifyServlet", value = "/userModify")
public class UserModifyServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username= String.valueOf(request.getSession().getAttribute("id"));
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

        String query = "update USER set NAME=?,PHONE=?,SEX=?,BIRTH=?,NICKNAME=? where USERNAME=?";
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
            pst.setString(1,name);
            pst.setString(2,phone);
            pst.setString(3,sex);
            pst.setDate(4, sqlBirth);
            pst.setString(5,nickname);
            pst.setString(6,username);

            if(pst.executeUpdate()>0){
                System.out.println("수정 성공");
            }


        } catch (Exception e) {
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
