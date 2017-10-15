/*
 Main class for application
 */
package com.mycompany.databasemaker;

import java.io.*;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

/**
 *
 * @author Desk1nd
 */
public class TheMagic {
    
    public static void main(String args[]) throws IOException, SQLException, URISyntaxException{
        BufferedReader br = null;
        InputStream in = null;
        Properties properties = null;
        Connection connection = null;
        DBManager dbManager = new DBManager(ConnectionManager.getConnection("root", ""));


        //Reader for getting user input from console
        br = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("Enter name for pro and engine databases without _pro and _engine postfixes \n");
//        String dbName = br.readLine();
        String dbName = "slonim_pns_enka";

        System.out.print("Enter name as it is in proman folder without _pro and _engine prefixes \n");
//        String fileName = br.readLine();
        String fileName = "Слоним ПНС ЭНКА";

        System.out.print("Do you planning to use OPC servers????? (y/n) \n");
        String useOpc = br.readLine();

        //Get values from properties file
        properties = new Properties();
        in = TheMagic.class.getClassLoader().getResourceAsStream("database_credentials.properties");
        properties.load(in);
        String user = properties.getProperty("user");
        String password = properties.getProperty("password");
        String pathForFillingTables = properties.getProperty("pathForFillingTables");



        //Asking DatabaseManager to create two databases
        dbManager.createDataBases(dbName, user,password);

        //Asking DataBaseManager to create tables by executing sql file from sources folder of project
        dbManager.createAndFillTables(dbName, pathForFillingTables, fileName);

        //Asking DBManager to fill xmlda_item table if user says "y"
        if(useOpc.equals("y")){
            System.out.println("OPC Server gonna be used! Enter project name on english lang.");
            String projectName = br.readLine();
            System.out.println("Enter object name on english lang.");
            String objectName = br.readLine();
            dbManager.fillXmldaTable(dbName+"_engine", projectName, objectName);
        }else{
            System.out.println("OPC is not using");
        }

    }
}









