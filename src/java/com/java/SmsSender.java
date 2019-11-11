/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.java;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


import static java.awt.SystemColor.text;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import static javafx.css.StyleOrigin.USER_AGENT;

public class SmsSender {
    
    private static String apiurl = "http://api.greenweb.com.bd/api.php?token=8227fc415aca5b5d344cf6a5c9aa1b7a&to=";
                public static void Sms(String mobile, String text)throws Exception {
               //System.out.println("success");
		StringBuilder url = new StringBuilder(apiurl)
                        .append(mobile)
                        .append("&message=")
                        .append(text);
            
		

		URL obj = new URL(url.toString().replaceAll(" ", "+"));
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();

		// optional default is GET
		con.setRequestMethod("GET");

		//add request header
		con.setRequestProperty("User-Agent", "google Chrome");

		int responseCode = con.getResponseCode();
		System.out.println("\nSending 'GET' request to URL : " + url);
		System.out.println("Response Code : " + responseCode);

		BufferedReader in = new BufferedReader(
		        new InputStreamReader(con.getInputStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();

		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();

		//print result
		System.out.println(response.toString());

	
                    

         }
}

