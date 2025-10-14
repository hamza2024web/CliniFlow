package com.clinique.webapp.servlet.admin.users;

import com.clinique.domain.Enum.Role;
import com.clinique.domain.User;
import com.clinique.webapp.dto.UserDTO;
import com.clinique.webapp.mapper.UserMapper;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.Interface.UserService;

import java.io.IOException;
import java.util.Optional;

@WebServlet("/admin/users/edit")
public class UserEditServlet extends HttpServlet {

    @Inject
    private UserService userService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");

            if (idParam == null || idParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/users?error=missing_id");
                return;
            }

            Long userId = Long.parseLong(idParam);
            Optional<User> userOpt = userService.findById(userId);

            if (userOpt.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/users?error=user_not_found");
                return; // IMPORTANT: Ajout du return manquant
            }

            UserDTO userDTO = UserMapper.toDTO(userOpt.get());
            request.setAttribute("user", userDTO);
            request.getRequestDispatcher("/WEB-INF/views/admin/users/edit.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/users?error=invalid_id");
        } catch (Exception e) {
            System.err.println("Erreur dans UserEditServlet (GET) : " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/users?error=server_error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Récupération des paramètres
            String idParam = request.getParameter("id");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String roleParam = request.getParameter("role");

            // Debug - à retirer en production
            System.out.println("=== DEBUG POST ===");
            System.out.println("id: " + idParam);
            System.out.println("firstName: " + firstName);
            System.out.println("lastName: " + lastName);
            System.out.println("email: " + email);
            System.out.println("role: " + roleParam);

            // Validation AVANT d'utiliser valueOf()
            if (idParam == null || idParam.trim().isEmpty() ||
                    firstName == null || firstName.trim().isEmpty() ||
                    lastName == null || lastName.trim().isEmpty() ||
                    email == null || email.trim().isEmpty() ||
                    roleParam == null || roleParam.trim().isEmpty()) {
                request.setAttribute("error", "Tous les champs sont obligatoires.");
                doGet(request, response);
                return;
            }

            // Conversion sécurisée
            Long userId = Long.parseLong(idParam);
            Role role = Role.valueOf(roleParam.trim());

            // Mise à jour
            User updatedUser = userService.updateUser(
                    userId,
                    firstName.trim(),
                    lastName.trim(),
                    email.trim(),
                    role
            );

            response.sendRedirect(request.getContextPath() + "/admin/users?success=updated");
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Données invalides : " + e.getMessage());
            doGet(request, response);
        } catch (Exception e) {
            System.err.println("Erreur dans UserEditServlet (POST) : " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Erreur inattendue : " + e.getMessage());
            doGet(request, response);
        }
    }
}