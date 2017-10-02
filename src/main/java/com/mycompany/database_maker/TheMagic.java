/*
 Main class for application
 */
package com.mycompany.database_maker;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URISyntaxException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

/**
 *
 * @author Desk1nd
 */
public class TheMagic {
    
    public static void main(String args[]) throws IOException, SQLException, URISyntaxException{
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("Enter name for pro and engine databases \n");
        String projectName = br.readLine();
//
//      

        InputStream in = TheMagic.class.getClassLoader().getResourceAsStream("database_credentials.properties");
        Properties properties = new Properties();
        properties.load(in);

        String user = properties.getProperty("user");
        String password = properties.getProperty("password");

        System.out.println("user is " + user);
        System.out.println("password is " + password);

        
        
        
        
        
        
        
        
        System.out.println("-------- MySQL JDBC Connection Testing ------------");

	try {
		Class.forName("com.mysql.jdbc.Driver");
	} catch (ClassNotFoundException e) {
		System.out.println("Where is your MySQL JDBC Driver?");
		e.printStackTrace();
		return;
	}

	System.out.println("MySQL JDBC Driver Registered!");
	Connection connection = null;

	try {
		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/?serverTimezone=UTC",user, password);

	} catch (SQLException e) {
		System.out.println("Connection Failed! Check output console");
		e.printStackTrace();
		return;
	}
        
        String createProQuery = "create database if not exists pro_" + projectName + " DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci";
        String useProQuery = "use pro_"+projectName;
        
        Statement createProStatement = connection.createStatement();
        Statement useProQueryStatement = connection.createStatement();
        
        createProStatement.executeUpdate(createProQuery);
        useProQueryStatement.executeQuery(useProQuery);
        
        createProStatement.close();
        createProStatement.close();
        
        ScriptRunner runner = new ScriptRunner(connection, false, false);
        runner.runScript(new BufferedReader(new FileReader(new File(TheMagic.class.getClassLoader().getResource("create PRO database.sql").toURI()))));
//        
        String pathForFilingTables = properties.getProperty("pathForFillingTables");
//        
//        runner.runScript(new BufferedReader(new FileReader(pathForFilingTables+"\\pro_"+projectName+".sql")));
                
        ScriptRunner sr = new ScriptRunner(connection, false, false);
        br = new BufferedReader(new FileReader(pathForFilingTables+"\\pro_"+projectName+".sql"));        
        sr.runScript(br);

	if (connection != null) {
		System.out.println("You made it, take control your database now!");
	} else {
		System.out.println("Failed to make connection!");
	}
        
        connection.close();
    }
}
