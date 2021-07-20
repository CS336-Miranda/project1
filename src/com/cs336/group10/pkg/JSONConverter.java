package com.cs336.group10.pkg;

import java.sql.ResultSet;

import org.json.JSONArray;
import org.json.JSONObject;

public class JSONConverter {

	public String convertToJSON(ResultSet resultSet) throws Exception {
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
