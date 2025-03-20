package com;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet Filter implementation class authFilter
 */
@WebFilter(urlPatterns = {"/admin/*", "/finance/*", "/employee/*","/manager/*"})
public class authFilter extends HttpFilter implements Filter {
       
    /**
     * @see HttpFilter#HttpFilter()
     */
    public authFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here

		 HttpServletRequest httpRequest = (HttpServletRequest) request;
		    HttpServletResponse httpResponse = (HttpServletResponse) response;

		    HttpSession session = httpRequest.getSession(false);
		    String userRole = (session != null) ? (String) session.getAttribute("user") : null;
		    
		    //System.out.println("user: "+userRole);

		    String uri = httpRequest.getRequestURI();
		    //System.out.println("uri: "+uri);
		    
		    String contextPath = httpRequest.getContextPath();
		    //System.out.println("contextpath: "+contextPath);

		    // Define accessible directories for each role
		    boolean isAuthorized = false;

		    if (userRole == null) {
		        // Redirect to login if user is not authenticated
		        httpResponse.sendRedirect(contextPath + "/index.jsp");
		        return;
		    }

		    if (uri.startsWith(contextPath + "/common/")) {
		        // Allow access to common files for all users
		        isAuthorized = true;
		    } else if (userRole.equals("admin") && uri.startsWith(contextPath + "/admin/")) {
		        isAuthorized = true;
		    } else if (userRole.equals("finance") && uri.startsWith(contextPath + "/finance/")) {
		        isAuthorized = true;
		    }  else if (userRole.equals("employee") && uri.startsWith(contextPath + "/employee/")) {
		        isAuthorized = true;
		    }else if (userRole.equals("manager")&& uri.startsWith(contextPath + "/manager/")) {
		        isAuthorized = true;
		    }

		    if (!isAuthorized) {
		        // Redirect to unauthorized page
		        //httpResponse.sendRedirect(contextPath + "/unauthorized.jsp");
		    	
		    	httpResponse.sendRedirect(contextPath + "/index.jsp");
		        return;
		    }

		    // Proceed if authorized
		    chain.doFilter(request, response);
		}

	

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
