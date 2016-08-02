package com.servlets;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.constants.Constants;
import com.json.JSONClient;

/**
 * Servlet implementation class MonitorServlet
 */
public class RegisterTestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    //private String resourcePath = "http://localhost:8080/MonitoringService/rest/monitor?m=yes";
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterTestServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//forward to register page for input
			request.setAttribute("commands", Constants.commands);
			request.setAttribute("body", "/WEB-INF/register/register.jsp");
			request.getRequestDispatcher("/WEB-INF/includes/template.jsp").forward(request, response);
		} catch(Exception e) {
			request.setAttribute("errormessage", e.getMessage());
			//forward to view
			request.setAttribute("body", "/WEB-INF/error/error.jsp");
			request.getRequestDispatcher("/WEB-INF/includes/template.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			JSONClient client = new JSONClient();
			
			String uri = "";
			//take the parameters to pass to the register service
			
			Enumeration<Object> parameterNames = request.getParameterNames();
			
			while(parameterNames.hasMoreElements()) {
				String name = (String)parameterNames.nextElement();
				uri += "&"+name+"="+URLEncoder.encode(request.getParameter(name),"UTF-8").replace(" ", "%20");
			}
			
			System.out.println(uri);
			
			if(request.getParameter("type").equals("chain")) {
				String responseInfo = client.post(request ,response, "chain/insert", uri);
				if(!new Boolean(responseInfo)) {
					System.out.println("FAILURE1");
					throw new Exception("Unable to register test. "+responseInfo);
				}
			} else {
				String responseInfo = client.post(request ,response, "test/register", uri);
				if(!new Boolean(responseInfo)) {
					System.out.println("FAILURE2");
					throw new Exception("Unable to register test. "+responseInfo);
				}
			}
			
			//forward to monitor page after to run test
			response.sendRedirect("search");
		} catch(Exception e) {
			request.setAttribute("errormessage", e.getMessage());
			//forward to view
			request.setAttribute("body", "/WEB-INF/error/error.jsp");
			request.getRequestDispatcher("/WEB-INF/includes/template.jsp").forward(request, response);
		}
	}
	
}
