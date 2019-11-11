/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.java;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Rafiqul Islam
 */
@WebServlet(name = "Varification", urlPatterns = {"/Varification"})
public class Varification extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String uname = request.getParameter("username");
        String pass = request.getParameter("psw");
        String Rpass = request.getParameter("pswRepeat");
        String PhoneNo = request.getParameter("phnNo");
        // String phone = request.getParameter("phnNo");
        //System.out.println(pass + " "+ Rpass);
        if (pass.equals(Rpass)) {
            Random rand = new Random();

            int randNo = rand.nextInt(1000000);
            String code1 = Integer.toString(randNo);
            //System.out.println(randNo);

       // request.setAttribute("code", code1);
            //request.getRequestDispatcher("Verificate").forward(request, response);
            System.out.println("Generated code: " + code1);

            try {
                SmsSender.Sms(PhoneNo, code1);
            } catch (Exception ex) {
                Logger.getLogger(Varification.class.getName()).log(Level.SEVERE, null, ex);
            }
            HttpSession session = request.getSession();
            session.setAttribute("code", code1);
            session.setAttribute("uname", uname);
            session.setAttribute("pass", pass);
            session.setAttribute("phone", PhoneNo);

            request.getRequestDispatcher("varification.jsp").forward(request, response);
        } else {

            out.println("Repeat password doesn't match...");
            //response.sendRedirect("createAcc.jsp");
        }

    }
}
