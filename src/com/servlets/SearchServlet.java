package com.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.json.JSONClient;
import com.models.MachineStatus;

/**
 * Servlet implementation class MonitorServlet
 */
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			JSONClient client = new JSONClient();
			
			//get all the machine names
			request.setAttribute("machineNames", client.post(request, response, "monitor/machinelist", ""));
			
			//get all the test names
			request.setAttribute("testNames", client.post(request, response, "monitor/testnamelist", ""));
				
			//forward to view
			request.setAttribute("body", "/WEB-INF/monitor/search.jsp");
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
			request.getRequestDispatcher("monitor").forward(request, response);
		} catch(Exception e) {
			request.setAttribute("errormessage", e.getMessage());
			//forward to view
			request.setAttribute("body", "/WEB-INF/error/error.jsp");
			request.getRequestDispatcher("/WEB-INF/includes/template.jsp").forward(request, response);
		}
	}
	
}
