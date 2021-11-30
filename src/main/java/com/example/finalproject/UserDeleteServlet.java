package com.example.finalproject;



import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "UserDeleteServlet", value = "/userDelete")
public class UserDeleteServlet extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username=request.getParameter("username");
        String query="delete from USER where USERNAME=?";
        Connection con=dbConnection.connect();
        try {
            PreparedStatement ps=con.prepareStatement(query);
            ps.setString(1,username);
            System.out.println(ps.toString());
            ps.executeUpdate();
            System.out.println("Delete Success!");
            request.getSession().removeAttribute("id");
            ps.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        response.sendRedirect("/");


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
