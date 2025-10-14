package com.clinique.webapp.servlet.admin.department;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import service.Interface.DepartmentService;

import java.io.IOException;

@WebServlet("/admin/departments/create")
public class DepartmentCreateServlet extends HttpServlet {
    @Inject
    private DepartmentService departmentService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/admin/departments/create.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String code = req.getParameter("code");
        try {
            departmentService.createDepartment(name, code);
            resp.sendRedirect(req.getContextPath() + "/admin/departments?success=created");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/admin/departments/create.jsp").forward(req, resp);
        }
    }
}