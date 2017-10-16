package com.mycompany.databasemaker;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by iseverin on 04.10.17.
 */
public class QueryManager {
    public void queryForMe(Connection connection, String query) {
        try {
            connection.createStatement().executeUpdate(query);
            System.out.println("Query executed successfully!!!");
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Query manager is saying that something wrong with connection!!!");
        }
    }

    public void wannaUse(Connection connection, String dbName) {
        try {
            connection.createStatement().executeQuery("USE " + dbName);
            System.out.println(dbName + " in use!!!!!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ResultSet executeSelect(Connection connection, String selectString) {
        ResultSet rs = null;
        try {
            rs = connection.createStatement().executeQuery(selectString);
        } catch (SQLException e) {
            System.out.println("Can't execute select statement to get project name");
            e.printStackTrace();
        }
        return rs;
    }

}
