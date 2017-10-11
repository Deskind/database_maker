package com.mycompany.database_maker;

import com.mysql.cj.api.conf.ConnectionPropertiesTransform;
import org.apache.commons.io.FileUtils;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Created by iseverin on 04.10.17.
 */
public class QueryManager {
    public void queryForMe(Connection connection, String query) {
        try {
            connection.createStatement().executeUpdate(query);
            System.out.println("Data base created successfully!!!");
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

}
