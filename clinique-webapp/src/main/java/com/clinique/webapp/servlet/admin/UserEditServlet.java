package com.clinique.webapp.servlet.admin;

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

            if (idParam == null || idParam.trim().isEmpty()){
                response.sendRedirect(request.getContextPath() + "/admin/users?error=missing_id");
                return;
            }

            Long userId = Long.parseLong(idParam);
            Optional<User> userOpt = userService.findById(userId);

            if (userOpt.isEmpty()){
                response.sendRedirect(request.getContextPath() + "/admin/user?error=user_not_found");
            }

            UserDTO userDTO = UserMapper.toDTO(userOpt.get());
            request.setAttribute("user", userDTO);
            request.getRequestDispatcher("/WEB-INF/views/admin/users/edit.jsp").forward(request, response);
        } catch (NumberFormatException e){
            response.sendRedirect(request.getContextPath() + "/admin/users?error=invalid_id");
        } catch (Exception e){
            System.err.println("Erreur dans UserEditServlet (GET) : " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/users?error=server_error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException , IOException {
        try {
            String idParam = request.getParameter("id");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            Role role = Role.valueOf(request.getParameter("role"));

            if (firstName == null || firstName.trim().isEmpty() ||
                    lastName == null || lastName.trim().isEmpty() ||
                    email == null || email.trim().isEmpty() ||
                    role.name().equals("null") ){
                request.setAttribute("error","Tous les champs sont obligatoires.");
                doGet(request , response);
                return;
            }

            Long userId = Long.parseLong(idParam);

            User updatedUser = userService.updateUser(
                    userId,
                    firstName.trim(),
                    lastName.trim(),
                    email.trim(),
                    role
            );

            response.sendRedirect(request.getContextPath() + "/admin/users?success=updated");
        } catch (IllegalArgumentException e){
            request.setAttribute("error",e.getMessage());
            doGet(request,response);
        } catch (Exception e){
            System.err.println("Erreur dans UserEditServlet (POST) : " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Erreur inattendue : " + e.getMessage());
            doGet(request, response);
        }
    }
}
