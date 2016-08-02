package com.json;

import java.util.HashMap;

public class JSONParser {
	public static HashMap<String,Object> parse(String json) {  //parse json into a list of objects
		HashMap<String,Object> jsonObjects = new HashMap<String,Object>();
		int i = 0;
		while(i < json.length()) {
			if(json.charAt(i) == '{') {  //if find children
				int endIndex = findMatchingBrace(i,json);
				
				HashMap<String,Object> children = new HashMap<String,Object>();
				children.putAll(parse(json.substring(i+1,endIndex)));
				jsonObjects.put("children"+i,children);
				i = endIndex;
			} else if(json.charAt(i) == ':' && json.charAt(i-1) == '"' && json.charAt(i+1) != '{') {
				int lastIndexOfOpenBrace = 0;
				int lastIndexOfComma = json.lastIndexOf(',', i);
				int nextIndexOfComma = json.indexOf(',', i);
				int nextIndexOfCloseBrace = json.length();
				
				String key;
				String value;
				
				if(lastIndexOfOpenBrace < lastIndexOfComma) {
					key = json.substring(lastIndexOfComma+1, i);
					
				} else {
					key = json.substring(0, i);
				}
				
				if(nextIndexOfCloseBrace > nextIndexOfComma && nextIndexOfComma > 0) { //what if nextIndexOfComma == -1
					value = json.substring(i+1, nextIndexOfComma);
				} else {
					value = json.substring(i+1, nextIndexOfCloseBrace);
				}
				
				jsonObjects.put(key, value);
			}
			i++;
		}
		return jsonObjects;
	}
	
	private static int findMatchingBrace(int i, String json) {
		int firstEndBrace = json.indexOf('}', i);
		int firstStartBrace = json.indexOf('{', i+1);
		while(firstStartBrace < firstEndBrace && firstStartBrace != -1) {
			firstEndBrace = json.indexOf('}', firstEndBrace+1);
			firstStartBrace = json.indexOf('{', firstStartBrace+1);
		}
		
		return firstEndBrace;
	}
}
