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
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/join")
public class JoinServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("/join.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("utf-8");
        PrintWriter writer= response.getWriter();
        String id=request.getParameter("id");
        String pwd=request.getParameter("pwd");
        String pwdCheck=request.getParameter("pwdCheck");
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
        try {
            if(User.isIdValid(id)==1){
                if(pwd.equals(pwdCheck)){
                    String query = "INSERT INTO USER(USERNAME, NAME, PWD, PHONE, SEX, BIRTH,NICKNAME) VALUES (?,?,?,?,?,?,?)";
                    Connection conn=null;
                    PreparedStatement pst=null;

                    request.setCharacterEncoding("UTF-8");
                    response.setCharacterEncoding("UTF-8");
                    response.setContentType("text/html;charset=utf-8");


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
                else{
                    writer.println("<script>alert('Check Password!'); location.href='/join.jsp';</script>");
                }
            }
            else{
                writer.println("<script>alert('Already Used Id'); location.href='/join.jsp';</script>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }


    }
}
