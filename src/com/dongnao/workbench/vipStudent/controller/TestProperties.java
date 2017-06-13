package com.dongnao.workbench.vipStudent.controller;

import java.io.IOException;
import java.io.InputStream; 
import java.util.Properties;
/**
 * @author Michael
 * @Time   2017年6月8日上午9:46:32
 */
public class TestProperties {
    private static String param1;     
    private static String param2;
	public static String getParam1() {
		return param1;
	}
	public static void setParam1(String param1) {
		TestProperties.param1 = param1;
	}
	public static String getParam2() {
		return param2;
	}
	public static void setParam2(String param2) {
		TestProperties.param2 = param2;
	}    
    
    static {     
        Properties prop = new Properties();     
        InputStream in = TestProperties.class.getResourceAsStream("/conf/properties/config.properties");//文件在同一个包下  
        try {   
            prop.load(in);     
            param1 = prop.getProperty("driverClassName_w").trim();     
            param2 = prop.getProperty("validationQuery_w").trim();      
        } catch (IOException e) {     
            e.printStackTrace();     
        }     
    }  
    
    public static void main(String args[]){     
        System.out.println(getParam1());     
        System.out.println(getParam2());      
    }  
}
