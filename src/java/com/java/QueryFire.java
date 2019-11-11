/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.java;

import dbservice.Service;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

/**
 *
 * @author Rafiqul Islam
 */
public class QueryFire extends HttpServlet {

    Service s;

    public QueryFire() {
        //System.out.println("QueryFire() called.........");
        s = new Service();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String sql = request.getParameter("sql");
        //System.out.println("SQL : " + sql);
        if (sql.startsWith("select")) {

            String r = s.executeQuery(sql);

            if (r.startsWith("Error")) {
                response.getWriter().write(r);
            } else {
                response.setContentType("application/json");
                response.getWriter().write(r);
            }

            System.out.println("RESULT : " + r);

        } else {
            System.out.println(sql);
            String val = s.execute(sql);

            response.getWriter().write(val);

           // System.out.println("EXE QUERY : " + val);
        }

    }

}
