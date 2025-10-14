package com.clinique.webapp.servlet.admin.users;

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
public class UserCreateServlet extends HttpServlet {

    @Inject
    private UserService userService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/admin/users/create.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String roleParam = request.getParameter("role");

            if (firstName == null || firstName.trim().isEmpty() ||
                    lastName == null || lastName.trim().isEmpty() ||
                    email == null || email.trim().isEmpty() ||
                    password == null || password.trim().isEmpty() ||
                    roleParam == null || roleParam.trim().isEmpty()) {
                request.setAttribute("error", "Tous les champs sont obligatoires.");
                preserveFormData(request);
                request.getRequestDispatcher("/WEB-INF/views/admin/users/create.jsp").forward(request, response);
                return;
            }

            Role role;
            try {
                role = Role.valueOf(roleParam.toUpperCase());
            } catch (IllegalArgumentException e) {
                request.setAttribute("error", "Rôle invalide.");
                preserveFormData(request);
                request.getRequestDispatcher("/WEB-INF/views/admin/users/create.jsp").forward(request, response);
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

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            preserveFormData(request);
            request.getRequestDispatcher("/WEB-INF/views/admin/users/create.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Erreur dans UserCreateServlet : " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Erreur inattendue. Veuillez réessayer.");
            request.getRequestDispatcher("/WEB-INF/views/admin/users/create.jsp").forward(request, response);
        }
    }

    private void preserveFormData(HttpServletRequest request) {
        request.setAttribute("firstName", request.getParameter("firstName"));
        request.setAttribute("lastName", request.getParameter("lastName"));
        request.setAttribute("email", request.getParameter("email"));
    }
}
