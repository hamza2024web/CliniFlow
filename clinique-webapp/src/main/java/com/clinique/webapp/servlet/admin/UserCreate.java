package com.clinique.webapp.servlet.admin;

import com.clinique.domain.Enum.Role;
import com.clinique.domain.User;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.Interface.UserService;

import java.io.IOException;

@WebServlet("/admin/users/create")
public class UserCreate extends HttpServlet {

    @Inject
    private UserService userService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/admin/users/create.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException , IOException {
        try {
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            Role role = Role.valueOf(request.getParameter("role"));

            if (firstName == null || firstName.trim().isEmpty() ||
                    lastName == null || lastName.trim().isEmpty() ||
                    email == null || email.trim().isEmpty() ||
                    password == null || password.trim().isEmpty() ||
                    role.name().equals("null")  ){
                request.setAttribute("error","Tous les champs sont obligatoires .");
                request.getRequestDispatcher("/WEB-INF/views/admin/users/create.jsp").forward(request,response);
                return;
            }

            User newUser = userService.createUser(
                    firstName.trim(),
                    lastName.trim(),
                    email.trim(),
                    password,
                    role
            );

            response.sendRedirect(request.getContextPath() + "/admin/users?success=created");
        } catch (IllegalArgumentException e){
            request.setAttribute("error", e.getMessage());
            request.setAttribute("firstName", request.getParameter("firstName"));
            request.setAttribute("lastName", request.getParameter("lastName"));
            request.setAttribute("email", request.getParameter("email"));
            request.getRequestDispatcher("/WEB-INF/views/admin/users/create.jsp").forward(request, response);
        } catch (Exception e){
            System.err.println("Erreur dans UserCreateServlet : " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Erreur inattendue : " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/users/create.jsp").forward(request, response);
        }
    }
}
