package com.cs336.group10.pkg;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

import org.json.JSONArray;
import org.json.JSONObject;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONException;

import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

public class JSONConverter {

	public String convertToJSON(ResultSet resultSet) throws Exception {
		JSONObject jsonObject = new JSONObject();
        JSONArray jsonArray = new JSONArray();
		
		ResultSetMetaData rsmd = resultSet.getMetaData();
        int cols = rsmd.getColumnCount();

        while(resultSet.next()) {

            JSONObject obj = new JSONObject();

            for (int i=1;i<=cols;i++) {

                 String column_name = rsmd.getColumnName(i);
                 if (rsmd.getColumnType(i) == java.sql.Types.ARRAY) {
                     obj.put(column_name, resultSet.getArray(column_name));
                    } else if (rsmd.getColumnType(i) == java.sql.Types.BIGINT) {
                     obj.put(column_name, resultSet.getInt(column_name));
                    } else if (rsmd.getColumnType(i) == java.sql.Types.BOOLEAN) {
                     obj.put(column_name, resultSet.getBoolean(column_name));
                    } else if (rsmd.getColumnType(i) == java.sql.Types.BLOB) {
                     obj.put(column_name, resultSet.getBlob(column_name));
                    } else if (rsmd.getColumnType(i) == java.sql.Types.DOUBLE) {
                     obj.put(column_name, resultSet.getDouble(column_name));
                    } else if (rsmd.getColumnType(i) == java.sql.Types.FLOAT) {
                     obj.put(column_name, resultSet.getFloat(column_name));
                    } else if (rsmd.getColumnType(i) == java.sql.Types.INTEGER) {
                     obj.put(column_name, resultSet.getInt(column_name));
                    } else if (rsmd.getColumnType(i) == java.sql.Types.NVARCHAR) {
                     obj.put(column_name, resultSet.getNString(column_name));
                    } else if (rsmd.getColumnType(i) == java.sql.Types.VARCHAR) {
                    	if(resultSet.getString(column_name) == null) {  					             
                    		obj.put(column_name, "");					      					     
                		} else { 
                			obj.put(column_name, resultSet.getString(column_name));}
                    } else if (rsmd.getColumnType(i) == java.sql.Types.TINYINT) {
                     obj.put(column_name, resultSet.getInt(column_name));
                    } else if (rsmd.getColumnType(i) == java.sql.Types.SMALLINT) {
                     obj.put(column_name, resultSet.getInt(column_name));
                    } else if (rsmd.getColumnType(i) == java.sql.Types.DATE) {
                     obj.put(column_name, resultSet.getDate(column_name));
                    } else if (rsmd.getColumnType(i) == java.sql.Types.TIMESTAMP) {
                     obj.put(column_name, resultSet.getTimestamp(column_name));
                    } else {
                     obj.put(column_name, resultSet.getObject(column_name));
                    }
            }
            jsonArray.put(obj);
        }
         
 		jsonObject.put("d", jsonArray);
        
        return jsonObject.toString();
		
	}
	
	public String convertToJSON_OLD(ResultSet resultSet) throws Exception {
		//Creating a JSONObject object
		 JSONObject jsonObject = new JSONObject();
		 
        JSONArray jsonArray = new JSONArray();
        while (resultSet.next()) {
            int numberOfcolumns = resultSet.getMetaData().getColumnCount();
            JSONObject obj = new JSONObject();
            for (int i = 0; i < numberOfcolumns; i++) {
                obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), resultSet.getObject(i + 1));
            }
          jsonArray.put(obj);
        }
       
		jsonObject.put("d", jsonArray);
               
        return jsonObject.toString();
    }
}
