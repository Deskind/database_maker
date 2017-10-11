package com.mycompany.database_maker;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Created by iseverin on 04.10.17.
 */
public class ConnectionManager {
    public static Connection connection;

    public static Connection getConnection(String user, String password){
        Connection conn = null;

        //If connection obj is not existing yet we gonna create it, else just return reference to existing object
        if(connection == null){

            //Trying to load jdbc driver class
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                System.out.println("Can't find JDBC driver class!!!");
            }

            //Trying to get connection to database
            try {
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/?serverTimezone=UTC",user, password);
                System.out.println("Connection to database is successful!!!");
            } catch (SQLException e) {
                e.printStackTrace();
                System.out.println("Can't get connection to database, check your credentials in the database_credendtials.property file!!!");
            }
        }else conn = connection;
        return conn;
    }
}
