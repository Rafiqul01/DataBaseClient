/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbservice;

import com.java.GetTableData;
import com.mysql.cj.protocol.Resultset;
import dbconnection.DBConnection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONObject;

/**
 *select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='tableName'
 * @author Rafiqul Islam
 */
public class Service {
    
    private Statement stm;
    
    public Service(){
        try {
            DBConnection dbc = new DBConnection();
            stm = dbc.getStatement();
        } catch (Exception ex) {
            Logger.getLogger(Service.class.getName()).log(Level.SEVERE, null, ex);
            //System.out.println("error!");
        }
    }
    
    public String execute(String sql){
        
        String mgs = "";
        try {
            stm.execute(sql);
            mgs = "Query success";
        } catch (SQLException ex) {
             mgs = "Error : "+ex.getMessage();
            //.getLogger(Service.class.getName()).log(Level.SEVERE, null, ex);
            System.err.println(mgs);
        }
        
        return mgs;
    }
    
    public String executeQuery(String sql){
        
        String result = "";
        
            try {
                ResultSet rs = stm.executeQuery(sql);
                ResultSetMetaData rsm = rs.getMetaData();

                int cmc = rsm.getColumnCount();
                int kid = 0;

                JSONObject job = new JSONObject();
                while (rs.next()) {
                    kid++;
                    JSONObject ob = new JSONObject();
                    for (int i = 1; i <= cmc; i++) {

                        ob.put("" + rsm.getColumnName(i), rs.getString(rsm.getColumnName(i)));
                    }

                    job.put("" + kid, ob);
                }

                result = job.toString();
                //  System.out.println("JOB : \n"+job);
              

            } catch (Exception ex) {
                result = "Error : "+ex.getMessage();
                //Logger.getLogger(GetTableData.class.getName()).log(Level.SEVERE, null, ex);
                
            }

            return  result;
    }
    
    
    
    
    
}
