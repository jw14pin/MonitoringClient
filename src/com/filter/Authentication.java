package com.filter;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Enumeration;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.json.JSONClient;

public class Authentication implements Filter {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpSession session = ((HttpServletRequest)request).getSession();
		
		System.out.println(((HttpServletRequest)request).getRequestURI());
		
		if(!(session.getAttribute("authenticated") != null && session.getAttribute("authenticated").equals("true"))) {
			//forward to view
			((HttpServletResponse)response).sendRedirect("/MonitoringClient/login");
		} else {
			JSONClient client = new JSONClient();
			
			String uri = "";
			//take the parameters to pass to the register service
			
			Enumeration<Object> parameterNames = request.getParameterNames();
			
			while(parameterNames.hasMoreElements()) {
				String name = (String)parameterNames.nextElement();
				uri += "&"+name+"="+URLEncoder.encode(request.getParameter(name),"UTF-8").replace(" ", "%20");
			}
			
			System.out.println(uri);
			
			try {
				System.out.println("REQUEST::"+uri);
				
				if(client.post((HttpServletRequest)request, (HttpServletResponse)response, "hello", uri).equals("InvalidKey")) {
					((HttpServletResponse)response).sendRedirect("/MonitoringClient/login");
				} else {
					chain.doFilter(request, response);
				}
			} catch (Exception e) {
				e.printStackTrace();
				throw new ServletException("Could not pass request!");
			}
		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}
	
}
