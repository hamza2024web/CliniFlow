package com.clinique.webapp.servlet.admin.users;

import com.clinique.domain.User;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.Interface.UserService;

import java.io.IOException;

@WebServlet("/admin/users/delete")
public class UserDeleteServlet extends HttpServlet {

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

            User currentUser = (User) request.getSession().getAttribute("user");
            if (currentUser!= null && currentUser.getId().equals(userId)){
                response.sendRedirect(request.getContextPath() + "/admin/users?error=cannot_delete_self");
                return;
            }

            userService.deleteUser(userId);

            response.sendRedirect(request.getContextPath() + "/admin/users?success=deleted");
        } catch(NumberFormatException e){
            response.sendRedirect(request.getContextPath() + "/admin/users?error=invalid_id");
        } catch(Exception e){
            System.err.println("Erreur dans UserDeleteServlet : " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/users?error=delete_failed");
        }
    }
}
