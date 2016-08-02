package com.servlets;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.json.JSONClient;
import com.models.MachineStatus;

/**
 * Servlet implementation class MonitorServlet
 */
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {				
			//forward to view
			request.setAttribute("body", "/WEB-INF/login/login.jsp");
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
			//using a plain text ultimate-eye-rolling-noob version
			if(!(request.getParameter("username").equals("admin") && request.getParameter("password").equals("h2u9s6vx04lksna"))) {
				throw new Exception("Invalid username or password.");
			}
			
			//print out request information			
			Enumeration<Object> parameterNames = request.getHeaderNames();
			
			while(parameterNames.hasMoreElements()) {
				String name = (String)parameterNames.nextElement();
				
				String value = request.getHeader(name);

				System.out.println("HEADER:"+name+":"+value);
			}
			
			System.out.println("BLA!");
			
			JSONClient client = new JSONClient();
			
			String key = client.post(request, response, "monitor", "&username="+request.getParameter("username")+"&password="+request.getParameter("password"));
			
			HttpSession session = request.getSession();
			
			session.setAttribute("key",key);
			
			session.setAttribute("authenticated", "true");
			
			System.out.println("AUTHENTICATED!");
			
			//forward to view only if authorized
			response.sendRedirect("client/search");
		} catch(Exception e) {
			request.setAttribute("errormessage", e.getMessage());
			//forward to view
			request.setAttribute("body", "/WEB-INF/error/error.jsp");
			request.getRequestDispatcher("/WEB-INF/includes/template.jsp").forward(request, response);
		}
	}
	
}
