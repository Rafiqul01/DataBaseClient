/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbconnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.List;

/**
 *
 * @author Rafiqul Islam
 */
public class DBConnection {

    private static Statement stm;

    public DBConnection() throws Exception
    {
        String url = "jdbc:mysql://localhost:3306/databaseclient?autoReconnect=true&useSSL=false";
        String username = "root";
        String password = "rafiqul";
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection(url, username, password);
        //System.out.println("Build successfully...");
        stm = connection.createStatement();
        
    }
    
    public Statement getStatement(){
        return stm;
    }

}
