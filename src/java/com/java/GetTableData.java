/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.java;

import static com.java.DbConnection.getConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.*;



/**
 *
 * @author Rafiqul Islam
 */
public class GetTableData extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String val[] = request.getParameter("dbtbl_name").split(",");
            String sql = request.getParameter("sql");

           // System.out.println("DB Name  : " + val[0]);
            //System.out.println("Tbl Name  : " + val[1]);

            Statement stm = DbConnection.getConnection().createStatement();
            stm.execute("use " + val[0]);

           // ResultSet rs = stm.executeQuery("select * from " + val[1]);
            ResultSet rs = stm.executeQuery(sql);
            ResultSetMetaData rsm = rs.getMetaData();

            
            int cmc = rsm.getColumnCount();

//            for (int i = 1; i <= cmc; i++) {
//                System.out.println("CMN : " + rsm.getColumnName(i));
//            }
            int kid=0;
           
            JSONObject job = new JSONObject();
            while (rs.next()) {
                kid++;
                JSONObject ob = new JSONObject();
                for (int i = 1; i <= cmc; i++) {

                    ob.put(""+rsm.getColumnName(i), rs.getString(rsm.getColumnName(i)));
                    //data += rs.getString(rsm.getColumnName(i)) + ",";
                    //System.out.println("CMN : " + rs.getString(rsm.getColumnName(i)));

                }
                
                
                job.put(""+kid, ob);
            }

          
           //  System.out.println("JOB : \n"+job);
         
            response.setContentType("application/json");
            response.getWriter().write(job.toString());

        
            
        } catch (Exception ex) {
            Logger.getLogger(GetTableData.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
       
        
    }

    /*
     @Override
     protected void doPost(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException {
     processRequest(request, response);
     }
     */
}
