/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package test.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author HERO
 */
public class DBConnection {
    public static Connection getConn() throws SQLException{
        Connection con=null;
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/capstone?serverTimezone=Asia/Seoul";
            con=DriverManager.getConnection(url,"p1","p1");
            return con;
        }catch(ClassNotFoundException ce){
            System.out.println(ce.getMessage());
            return null;
        }
    }
}
