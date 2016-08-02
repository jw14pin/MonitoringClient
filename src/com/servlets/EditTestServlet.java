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
public class EditTestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditTestServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {			
			JSONClient client = new JSONClient();
			
			String uri = "&id="+request.getParameter("test_id");
			
			//get all the test info
			request.setAttribute("testInfo", client.post(request, response, "test/info", uri));
			
			//forward to view
			request.setAttribute("commands", Constants.commands);
			request.setAttribute("body", "/WEB-INF/edit/edit.jsp");
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
		
		//this below is a WORKAROUND (for now until can use the GET directly)
		if(request.getParameter("test_id") != null) {
			doGet(request, response);
		} else {
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
				
				//get all the test names
				String responseInfo = client.post(request, response, "test/update", uri);
				
				if(!new Boolean(responseInfo)) {
					throw new Exception("Unable to update. "+responseInfo);
				}
				
				//forward to monitor page after to run test
				response.sendRedirect("manage");
				//request.getRequestDispatcher("manage").forward(request, response);
			} catch(Exception e) {
				request.setAttribute("errormessage", e.getMessage());
				//forward to view
				request.setAttribute("body", "/WEB-INF/error/error.jsp");
				request.getRequestDispatcher("/WEB-INF/includes/template.jsp").forward(request, response);
			}
		}
	}
	
}
