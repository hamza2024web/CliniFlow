package com.clinique.webapp.servlet.admin;

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
import java.util.List;

@WebServlet("/admin/users")
public class UserList extends HttpServlet {

    @Inject
    private UserService userService;

    @Override
    protected void doGet(HttpServletRequest request , HttpServletResponse response) throws ServletException, IOException {
        try {
             List<User> users = userService.findAll();

             List<UserDTO> userDTOs = UserMapper.toDTOList(users);

             request.setAttribute("users", userDTOs);

             request.getRequestDispatcher("/WEB-INF/views/admin/users/list.jsp").forward(request , response);
        } catch (Exception e){
            System.err.println("Erreur dans UserListServlet : " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors du chargement des utilisateurs : " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/users/list.jsp").forward(request, response);
        }
    }
}
