package com.java;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.DbWithTable;

public class DbConnection {

    private static List<String> dbList;
    private static Statement stm;

    private static String url = "jdbc:mysql://localhost:3306/databaseclient?autoReconnect=true&useSSL=false";
    private static String username = "root";
    private static String password = "rafiqul";

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection(url, username, password);
        //System.out.println("Build successfully...");
        stm = connection.createStatement();
        return connection;
    }

    public static List<DbWithTable> getDataList() {
        List<DbWithTable> dbWithTables = new ArrayList();

        dbList = new ArrayList<>();

        try {

            DbConnection dbc = new DbConnection();

            stm = getConnection().createStatement();
            //stm.execute("use stocksell");
            ResultSet rs = stm.executeQuery("show databases");

            //System.out.println(rs);
            int i = 0;
            while (rs.next()) {

                String dbName = rs.getString(1);
                //System.out.println("DB : "+dbName);
//                if(dbName.equalsIgnoreCase("sakila") || dbName.equalsIgnoreCase("performance_schema") || dbName.equalsIgnoreCase("mysql") || dbName.equalsIgnoreCase("information_schema") || dbName.equalsIgnoreCase("world"))
//                    continue;
                dbList.add(dbName);

            }

            //System.out.println("List : "+dbList.toString());
            for (String db_name : dbList) {
                DbWithTable obj = new DbWithTable();
                List<String> tbls = new ArrayList<>();
                obj.setDbName(db_name);
                //.out.println("Db_Name : "+db_name);
                stm.execute("use " + db_name);
                ResultSet rs2 = stm.executeQuery("show tables");

                while (rs2.next()) {
                    //System.out.println("Table : "+rs2.getString(1));
                    tbls.add(rs2.getString(1));
                }

                obj.setTblList(tbls);
                dbWithTables.add(obj);
            }

            /*
             for(DbWithTable data : dbWithTables)
             {
             System.out.println("Db_Name : "+data.getDbName()+"\nTable : "+data.getTblList().toString());
            
             }
             */
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return dbWithTables;

    }

    public static void main(String[] args) {

        try {
            getConnection();

//            System.out.println("uyfufio");
//            System.out.println( stm.execute("use practice"));
//            System.out.println(stm.execute("create table tbl (id int)"));
//            
//            
//            
        } catch (Exception ex) {
            Logger.getLogger(DbConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
