package com.clinique.webapp.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;



public class AuthentificationFilter implements Filter {

    private static final java.util.logging.Logger LOGGER =
            java.util.logging.Logger.getLogger(AuthentificationFilter.class.getName());

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String requestURI = request.getRequestURI();
        String method = request.getMethod();

        LOGGER.info("=== FILTER START ===");
        LOGGER.info("Method: " + method);
        LOGGER.info("RequestURI: " + requestURI);
        LOGGER.info("ContextPath: " + request.getContextPath());
        LOGGER.info("ServletPath: " + request.getServletPath());
        LOGGER.info("QueryString: " + request.getQueryString());

        HttpSession session = request.getSession(false);
        LOGGER.info("Session exists: " + (session != null));
        if (session != null) {
            LOGGER.info("Session ID: " + session.getId());
            LOGGER.info("User in session: " + (session.getAttribute("user") != null));
        }

        String contextPath = request.getContextPath();

        boolean isLoginPage = requestURI.equals(contextPath + "/login")
                || requestURI.equals(contextPath + "/login/")
                || requestURI.endsWith("/login.jsp");

        boolean isPublicResource = requestURI.startsWith(contextPath + "/public/")
                || requestURI.startsWith(contextPath + "/assets/")
                || requestURI.startsWith(contextPath + "/resources/")
                || requestURI.endsWith(".css")
                || requestURI.endsWith(".js")
                || requestURI.endsWith(".png")
                || requestURI.endsWith(".jpg")
                || requestURI.endsWith(".ico");

        boolean isRoot = requestURI.equals(contextPath + "/")
                || requestURI.equals(contextPath);

        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);

        LOGGER.info("isLoginPage: " + isLoginPage);
        LOGGER.info("isPublicResource: " + isPublicResource);
        LOGGER.info("isRoot: " + isRoot);
        LOGGER.info("isLoggedIn: " + isLoggedIn);

        if (isLoggedIn || isLoginPage || isPublicResource || isRoot) {
            LOGGER.info("Allowing request through");
            chain.doFilter(request, response);
            LOGGER.info("=== FILTER END (passed through) ===");
        } else {
            LOGGER.info("Redirecting to login");
            response.sendRedirect(contextPath + "/login");
            LOGGER.info("=== FILTER END (redirected) ===");
        }
    }
}