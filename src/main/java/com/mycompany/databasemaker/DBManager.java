package com.mycompany.databasemaker;

import java.io.*;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * Created by iseverin on 04.10.17.
 */
public class DBManager {
    private Connection connection;
    QueryManager queryManager = new QueryManager();
    FileProcessor fileProcessor = new FileProcessor();

    public DBManager(Connection connection){
        this.connection = connection;
    }

    //Method for creating tables in the data base
    public void createDataBases(String dbName, String user, String password){

        //Get connection to database from Connection Manager
        connection = ConnectionManager.getConnection(user, password);

        queryManager.queryForMe(connection, "create database if not exists " + dbName + "_pro DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci");
        queryManager.queryForMe(connection, "create database if not exists " + dbName + "_engine DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci");
    }

    //Method for creating tables in databases
    public void createAndFillTables(String dbName, String pathForFillingTables, String fileName) {

        ScriptRunner runner = new ScriptRunner(connection, false, false);
        try {

            //Asking QueryManager to use PRO
            queryManager.wannaUse(connection, dbName+"_pro");

            //Creating tables in pro database
            InputStream in = DBManager.class.getClassLoader().getResourceAsStream("create PRO database.sql");
            runner.runScript(new BufferedReader(new InputStreamReader(in)));
            System.out.println("Tables in pro was created!!!!!");

            //Filling tables in pro database
            File fillProFile = fileProcessor.processFile(new File(pathForFillingTables+"pro_"+fileName+".sql"), ";", runner);
            runner.runScript(new FileReader(fillProFile));
            System.out.println("Table PRO was successfully filled with data!!!");

            //Asking FileProcessorClass to clean temp files
            fileProcessor.cleanTempFiles();



            //Asking QueryManager to use ENGINE
            queryManager.wannaUse(connection, dbName + "_engine");

            //Creating tables in engine database
            in = DBManager.class.getClassLoader().getResourceAsStream("create ENGINE database.sql");
            runner.runScript(new BufferedReader(new InputStreamReader(in)));
            System.out.println("Tables in engine was successfully created!!!");

            //Filling tables in pro database
            File fillEngineFile = fileProcessor.processFile(new File(pathForFillingTables+"engine_"+fileName+".sql"), ";;", runner);

            runner.runScript(new FileReader(fillEngineFile));
            System.out.println("Table ENGINE was successfully filled with data!!!");

            //Asking FileProcessorClass to clean temp files
//            fileProcessor.cleanTempFiles();
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("Can't find sql file for filling pro or engine table");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void fillXmldaTable(String dbName, String projectName) {
        //Use database with xmlda_item table
        queryManager.wannaUse(connection, dbName);
        System.out.println("Database: engine. Ready to process xmlda_item");

        //Filling fk_argument column
        queryManager.queryForMe(connection, "INSERT INTO xmlda_item (fk_argument) SELECT fk_argument FROM cell_argument");

        //Filling name column with values like in fk_argument column
        queryManager.queryForMe(connection, "UPDATE xmlda_item SET xmlda_item.name = xmlda_item.fk_argument;");

        //Modify column name
        queryManager.queryForMe(connection, "UPDATE xmlda_item SET xmlda_item.name = REPLACE(xmlda_item.name, '"+projectName+"."+"', '')");
    }

//    public ScriptRunner getRunner() {
//        return runner;
//    }
}
