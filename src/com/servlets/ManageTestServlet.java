package com.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.json.JSONClient;

/**
 * Servlet implementation class MonitorServlet
 */
public class ManageTestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManageTestServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			JSONClient client = new JSONClient();
			
			//get all the test names and test ids within the same json structure
			request.setAttribute("testNames", client.post(request, response, "monitor/testnamelist", ""));
				
			//forward to view
			request.setAttribute("body", "/WEB-INF/find/find.jsp");
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
			//forward to view
			request.getRequestDispatcher("edit").forward(request, response);
		} catch(Exception e) {
			request.setAttribute("errormessage", e.getMessage());
			//forward to view
			request.setAttribute("body", "/WEB-INF/error/error.jsp");
			request.getRequestDispatcher("/WEB-INF/includes/template.jsp").forward(request, response);
		}
	}
	
}
