/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.java;

import com.sun.xml.ws.tx.at.v10.types.PrepareResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Rafiqul Islam
 */
@WebServlet(name = "First", urlPatterns = {"/First"})
public class First extends HttpServlet {

    private Object resultSet;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String uname = request.getParameter("uname");
        String pass = request.getParameter("psw");
        System.out.println(uname + " " + pass);
        //int count = 0; 
        Connection conn = null;
        try {
            conn = DbConnection.getConnection();
        } catch (Exception ex) {
            Logger.getLogger(First.class.getName()).log(Level.SEVERE, null, ex);
        }
        PreparedStatement statement = null;
        try {
            statement = conn.prepareStatement("select *from username where uname = '" + uname + "' and password = '" + pass + "';");
        } catch (SQLException ex) {
            Logger.getLogger(First.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {

                request.setAttribute("dataList", DbConnection.getDataList());

                HttpSession session = request.getSession();
                session.setAttribute("username", uname);

                request.getRequestDispatcher("welcome.jsp").forward(request, response);

            } else {
                System.out.println("Unauthorized");
            }
        } catch (SQLException ex) {
            Logger.getLogger(First.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
