
package com.java;

import com.sun.xml.ws.tx.at.v10.types.PrepareResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Rafiqul Islam
 */
@WebServlet(name = "Verificate", urlPatterns = {"/Verificate"})
public class Verificate extends HttpServlet {

    
         
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        String code2 = (String)request.getSession().getAttribute("code");
        
        String uname = (String)request.getSession().getAttribute("uname");
        String pass = (String)request.getSession().getAttribute("pass");
        String phone = (String)request.getSession().getAttribute("phone");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        //System.out.println("Code1: "+code+" code2: "+code2);
        if(code.equals(code2)){
            try {
//               
                Connection conn = DbConnection.getConnection();
                PreparedStatement statement = conn.prepareStatement("insert into username values('"+uname+"','"+pass+"','"+phone+"');");
                statement.execute();
                
                out.println("Verified your account...");
                
                
                //System.out.println("Verified User");
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        } else{
            out.println("Not verified");
        }
       
    }

}
