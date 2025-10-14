package com.clinique.webapp.servlet.admin.department;

import com.clinique.domain.Department;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import service.Interface.DepartmentService;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/departments")
public class DepartmentListServlet extends HttpServlet {
    @Inject
    private DepartmentService departmentService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Department> departments = departmentService.getAllDepartments();
        req.setAttribute("departments", departments);
        req.getRequestDispatcher("/WEB-INF/views/admin/departments/list.jsp").forward(req, resp);
    }
}