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
        //Reader for getting user input from console
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        //Stream for reading resource files
        InputStream in = null;
        Properties properties = new Properties();
        in = TheMagic.class.getClassLoader().getResourceAsStream("database_credentials.properties");
        properties.load(in);

        //Getting properties from file
        String user = properties.getProperty("user");
        String password = properties.getProperty("password");
        String pathForFillingTables = "d:\\AsconXe\\proman\\";
        String dbName = properties.getProperty("dbName");
        String projectName = properties.getProperty("projectName");
        String objectName = properties.getProperty("objectName");

        //Creating dbManager object which performs all interactions with db and other objects
        DBManager dbManager = new DBManager(ConnectionManager.getConnection(user, password));




        System.out.print("Enter name as it is in proman folder without _pro and _engine prefixes \n");
//        String fileName = br.readLine();
        String fileName = "Слоним ПНС ЭНКА";

        System.out.print("Do you planning to use OPC servers????? (y/n) \n");
        String useOpc = br.readLine();


        //Asking DatabaseManager to create two databases
        dbManager.createDataBases(dbName, user,password);

        //Asking DataBaseManager to create tables by executing sql file from sources folder of project
        dbManager.createAndFillTables(dbName, pathForFillingTables, fileName);

        //Asking DBManager to fill xmlda_item table if user says "y"
        if(useOpc.equals("y")){
            dbManager.fillXmldaTable(dbName+"_engine");
        }else{
            System.out.println("OPC is not using");
        }

    }
}









