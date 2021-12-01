package com.example.finalproject;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("/index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id=request.getParameter("id");
        String pwd=request.getParameter("pwd");
        String query = "SELECT * FROM USER WHERE USERNAME=?";
        Connection conn=null;
        PreparedStatement pst=null;
        ResultSet rs=null;
        HttpSession session=request.getSession();

        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8");
        PrintWriter writer= response.getWriter();



        try {
            conn = dbConnection.connect();
            pst=conn.prepareStatement(query);
            System.out.println(id+","+pwd);
            pst.setString(1,id);

            rs = pst.executeQuery();

            if (rs.next()) {

                String name = rs.getString("name");
                String phone = rs.getString("phone");
                String sex = rs.getString("sex");
                String password=rs.getString("pwd");
                int auth=rs.getInt("author");
                System.out.println(password);
                System.out.println(pwd);

                if(pwd.equals(password))
                {
                    session.setAttribute("id", id);
                    session.setAttribute("name", name);
                    session.setAttribute("phone", phone);
                    session.setAttribute("sex", sex);
                    session.setAttribute("auth",auth);
                    response.sendRedirect("/");

                }
                else{
                    writer.println("<script>alert('비밀번호가 틀렸습니다.'); location.href='/';</script>");
                }
            } else {
                writer.println("<script>alert('아이디가 존재하지 않습니다..'); location.href='/';</script>");

            }

        } catch (Exception e) {
            System.out.println(e);
        } finally {
            try {
                if (rs != null)
                    rs.close();

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
