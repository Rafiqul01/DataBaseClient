/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.*;

/**
 *
 * @author Rafiqul Islam
 */
public class DbWithTable {
   
    private String dbName;
    private List<String> tblList;

    public DbWithTable() {
    }
    
    public String getDbName() {
        return dbName;
    }

    public void setDbName(String dbName) {
        this.dbName = dbName;
    }

    public List<String> getTblList() {
        return tblList;
    }

    public void setTblList(List<String> tblList) {
        this.tblList = tblList;
    }
    
    
}
