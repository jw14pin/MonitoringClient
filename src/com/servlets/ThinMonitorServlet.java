package com.servlets;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.json.JSONClient;

/**
 * Servlet implementation class MonitorServlet
 */
public class ThinMonitorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    //private String resourcePath = "http://localhost:8080/MonitoringService/rest/monitor?m=yes";
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ThinMonitorServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			JSONClient client = new JSONClient();
			
			String uri = "";
			
//			String[] machines = request.getParameterValues("machine") != null ? request.getParameterValues("machine") : new String[0];
//			for(String machine:machines) {
//				uri += "&machine="+machine;
//			}
			
			Enumeration<Object> parameterNames = request.getParameterNames();
			
			while(parameterNames.hasMoreElements()) {
				String name = (String)parameterNames.nextElement();
				
				String[] values = request.getParameterValues(name);
				
				for(String value:values) {
					uri += "&"+name+"="+value;
				}
			}
			
			System.out.println(uri);
			
			//format output
			request.setAttribute("raw", client.post(request, response, "monitor", uri));
			
			//forward to view
			request.setAttribute("body", "/WEB-INF/monitor/monitor.jsp");
			request.getRequestDispatcher("/WEB-INF/includes/template.jsp").forward(request, response);
		} catch(Exception e) {
			request.setAttribute("errormessage", e.getMessage());
			//forward to view
			request.setAttribute("body", "/WEB-INF/error/error.jsp");
			request.getRequestDispatcher("/WEB-INF/includes/template.jsp").forward(request, response);
		}
	}
	
}
