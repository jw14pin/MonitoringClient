package com.json;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.constants.Constants;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.api.json.JSONConfiguration;

public class JSONClient {	
	private String resourcePath2 = "/MonitoringService/rest/";  //it is assumed that service and client will be housed on the same server
	
	public String post(HttpServletRequest request, HttpServletResponse response, String url, String uri) throws Exception {
		//get status of all urls, dbs, machines and if alert then, put in separate list		
		ClientConfig clientConfig = new DefaultClientConfig();
		clientConfig.getFeatures().put(JSONConfiguration.FEATURE_POJO_MAPPING, Boolean.TRUE);
		
		HttpSession session = request.getSession();
		
		String resourcePath = "http://"+request.getServerName()+":"+request.getServerPort()+resourcePath2;
		
		Client client = session.getAttribute("JSONClient") == null ? Client.create(clientConfig) : (Client)session.getAttribute("JSONClient");
		
		String url2 = url+"?m=yes";
		
		if(!(uri.contains("&username=") && uri.contains("&password="))) {
		
			String serviceCalls = (String)(session.getAttribute("serviceCall") == null ? "" : session.getAttribute("serviceCall"));
		
			session.setAttribute("serviceCall", serviceCalls+"<br/>"+resourcePath+url2+uri);
		
		}
		
		if(session.getAttribute("key") != null) {
			url += "?key="+session.getAttribute("key");
		} else {
			url += "?m=yes";
		}
		
		System.out.println(resourcePath+url+uri);
		
		WebResource webResource = client.resource(resourcePath+url+uri);
		
		ClientResponse clientResponse = webResource.accept("application/json").get(ClientResponse.class);
		
		session.setAttribute("JSONClient", client);
		
		if (clientResponse.getStatus() != 200) {
			   throw new RuntimeException("Failed : HTTP error code : "
				+ clientResponse.getStatus());
		}
		
		//get output
		String output = clientResponse.getEntity(String.class);
		
		System.out.println("OUTPUT::"+output);
		
		return output;
	}
}
