package com.clinique.webapp.servlet.admin.users;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.Interface.UserService;

import java.io.IOException;

@WebServlet("/admin/users/toggle-status")
public class UserToggleStatusServlet extends HttpServlet {

    @Inject
    private UserService userService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");

            if (idParam == null || idParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/users?error=missing_id");
                return;
            }

            Long userId = Long.parseLong(idParam);

            userService.toggleUserStatus(userId);

            response.sendRedirect(request.getContextPath() + "/admin/users?success=status_updated");
        } catch (Exception e){
            System.err.println("Erreur dans UserToggleStatusServlet : " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/users?error=toggle_failed");
        }
    }
}
