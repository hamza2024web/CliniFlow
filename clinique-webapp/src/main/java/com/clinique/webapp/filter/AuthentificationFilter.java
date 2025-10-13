package com.clinique.webapp.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthentificationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);

        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();

        boolean isLoginPage = requestURI.equals(contextPath + "/login")
                || requestURI.equals(contextPath + "/login/")
                || requestURI.endsWith("/login.jsp");

        boolean isPublicResource = requestURI.startsWith(contextPath + "/public/")
                || requestURI.startsWith(contextPath + "/assets/")
                || requestURI.startsWith(contextPath + "/resources/");

        boolean isRoot = requestURI.equals(contextPath + "/");

        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);

        if (isLoggedIn || isLoginPage || isPublicResource || isRoot) {
            chain.doFilter(request, response);
        } else {
            response.sendRedirect(contextPath + "/login");
        }
    }
}
