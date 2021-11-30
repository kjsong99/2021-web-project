package com.example.finalproject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet(name = "PasswordChangeServlet", value = "/passwordChange")
public class PasswordChangeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usernmae= String.valueOf(request.getSession().getAttribute("id"));
        String originPwd1=request.getParameter("originPwd1");
        String originPwd2=request.getParameter("originPwd2");
        String newPwd1=request.getParameter("newPwd1");
        String newPwd2=request.getParameter("newPwd2");

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();



        if(originPwd1.equals(originPwd2)){
            if(newPwd1.equals(newPwd2)) {
                try {
                    User.passwordChange(usernmae,newPwd1);
                    out.println("<script>alert('변경 성공'); location.href='/';</script>");
                    out.flush();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }else{

                out.println("<script>alert('새로운 비밀번호가 일치하지 않습니다.'); location.href='./password_change.jsp';</script>");
                out.flush();
            }
        }
        else{
            out.println("<script>alert('현재 비밀번호가 일치하지 않습니다.'); location.href='./password_change.jsp';</script>");
            out.flush();
        }
    }
}
