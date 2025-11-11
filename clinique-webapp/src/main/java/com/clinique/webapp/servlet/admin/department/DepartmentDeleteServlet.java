package com.clinique.webapp.servlet.admin.department;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import service.Interface.DepartmentService;

import java.io.IOException;

@WebServlet("/admin/departments/delete")
public class DepartmentDeleteServlet extends HttpServlet {
    @Inject
    private DepartmentService departmentService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        try {
            Long id = Long.parseLong(idStr);
            departmentService.deleteDepartment(id);
            resp.sendRedirect(req.getContextPath() + "/admin/departments?success=deleted");
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/admin/departments?error=delete_failed");
        }
    }
}