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
import java.util.Set;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Inject
    private UserService userService;

    @Override
    protected void doGet(HttpServletRequest request , HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request , response);
    }

    @Override
    protected void doPost(HttpServletRequest request , HttpServletResponse response) throws ServletException, IOException{
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Optional<User> userOptional = userService.authenticate(email, password);

        if (userOptional.isPresent()){
            User user = userOptional.get();
            HttpSession oldSession = request.getSession(false);

            if (oldSession != null){
                oldSession.invalidate();
            }
            HttpSession newSession = request.getSession(true);
            newSession.setAttribute("user",user);

            String targetUrl = determineTargetUrl(user, request.getContextPath());
            response.sendRedirect(targetUrl);
        } else {
            request.setAttribute("error", "Email ou mot de passe incorrect.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request,response);
        }
    }

    private String determineTargetUrl(User user, String contextPath) {
        Role role = user.getRole();

        if (role.name().equals("ADMIN")){
            return contextPath + "/admin/dashboard";
        } else if (role.name().equals("DOCTOR")){
            return contextPath + "/doctor/dashboard";
        } else if (role.name().equals("STAFF")){
            return contextPath + "/staff/dashboard";
        } else if (role.name().equals("PATIENT")){
            return contextPath + "/patient/dashboard";
        } else {
            return contextPath + "/login";
        }
    }
}
