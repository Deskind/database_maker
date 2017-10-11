package com.mycompany.database_maker;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;

import java.io.*;

/**
 * Created by Deskind on 04.10.17.
 * The Class read file in windows-1251 as butes to String obj.
 * After that bute arr write to new utf8 file.
 * Next read file to String, process the String and write it to file which will be executed by DBManager with ScriptRunner.
 */
public class FileProcessor {
    private BufferedReader tempReader = null;

    private String tempString = "";
    private byte[] arr = null;

    //arguments: file -> the file neds to process; delimiter -> the delimiter for script runner; runnner -> ref to script runner
    public File processFile(File file, String delimiter, ScriptRunner runner) throws IOException {
        File resultFile = new File("result.sql");
        File tempFile = new File("temp.sql");
        //Reading file as bytes and write it to tempFile
        try {
            //read file argument as array of bytes
            arr = IOUtils.toByteArray(new InputStreamReader(new FileInputStream(file), "Windows-1251"));
            //write bytes to temp file (encoding utf8)
            FileUtils.writeByteArrayToFile(tempFile, arr);
            //Reading tempFile to String obj
            tempReader = new BufferedReader(new FileReader(tempFile));

            //Read lines from tempReader
            String strForWhile = "";
            while ((strForWhile = tempReader.readLine()) != null){
                tempString+=strForWhile+"\n";
            }

            //if delimiter is not standard
            if(delimiter != ";"){
                //set delimiter for script runner
                runner.setDelimiter(delimiter, false);
                //Replace characters in string
                tempString = tempString.replace("set names cp1251;", "set names utf8;;");
                tempString = tempString.replace(");", ");;");
                tempString = tempString.replace("]);;", "]);");
                //back default delimiter for script runner
            }


            //Write result string to file
            FileUtils.writeStringToFile(resultFile, tempString);
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("File processor can't find file to process!!!!!");
        }


        FileUtils.writeStringToFile(tempFile, "");
        FileUtils.writeStringToFile(resultFile, "");

       return resultFile;
    }


    public void cleanTempFiles() throws IOException {


    }
}
