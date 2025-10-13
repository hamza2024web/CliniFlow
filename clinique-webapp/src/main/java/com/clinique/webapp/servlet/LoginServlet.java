package com.clinique.webapp.servlet;

import com.clinique.domain.Enum.Role;
import com.clinique.domain.User;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.Interface.UserService;

import java.io.IOException;
import java.util.Optional;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Inject
    private UserService userService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Optional<User> userOptional = userService.authenticate(email, password);

        if (userOptional.isPresent()) {
            User user = userOptional.get();

            // Invalidate any old session
            HttpSession oldSession = request.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }

            // Create new session
            HttpSession newSession = request.getSession(true);
            newSession.setAttribute("user", user);

            // Redirect based on role
            String targetUrl = determineTargetUrl(user, request.getContextPath());
            response.sendRedirect(targetUrl);
        } else {
            request.setAttribute("error", "Email ou mot de passe incorrect.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }

    private String determineTargetUrl(User user, String contextPath) {
        Role role = user.getRole();

        if (role == Role.ADMIN) {
            return contextPath + "/admin/dashboard";
        } else if (role == Role.DOCTOR) {
            return contextPath + "/doctor/dashboard";
        } else if (role == Role.STAFF) {
            return contextPath + "/staff/dashboard";
        } else if (role == Role.PATIENT) {
            return contextPath + "/patient/dashboard";
        } else {
            return contextPath + "/login";
        }
    }
}
