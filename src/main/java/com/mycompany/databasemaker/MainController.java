package com.mycompany.databasemaker;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.CheckBox;
import javafx.scene.control.TextField;

/**
 * Created by iseverin on 16.10.17.
 */
public class MainController {
    @FXML
    public TextField pathToCompiled, dbUserName, dbUserPassword, fileName, newDbName;

    @FXML
    public CheckBox check;

    public void doneBtnClicked(ActionEvent actionEvent) {
        String userName = dbUserName.getText();
        String userPassword = dbUserPassword.getText();
        String path = pathToCompiled.getText();
        String file = fileName.getText();
        String dbName = newDbName.getText();


        DBManager dbManager = new DBManager(ConnectionManager.getConnection(userName,userPassword));

        dbManager.createDataBases(dbName, userName, userPassword);

        dbManager.createAndFillTables(dbName, path, file);

        if(check.isSelected()){
            dbManager.fillXmldaTable(dbName+"_engine");
        }else{
            System.out.println("OPC is not using");
        }

    }
}
