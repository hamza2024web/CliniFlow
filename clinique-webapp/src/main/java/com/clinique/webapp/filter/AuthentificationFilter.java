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
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig);
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);

        String requestURI = request.getRequestURI();

        boolean isLoginPage = requestURI.endsWith("/login");
        boolean isPublicRessource = requestURI.startsWith(request.getContextPath() + "/public/");
        boolean isRoot = requestURI.equals(request.getContextPath() + "/");

        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);

        if (isLoggedIn || isLoginPage || isPublicRessource || isRoot){
            chain.doFilter(request , response);
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {
        Filter.super.destroy();
    }
}
