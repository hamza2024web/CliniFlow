package com.clinique.webapp.servlet.admin.users;

import com.clinique.domain.*;
import com.clinique.domain.Enum.Role;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.Interface.*;

import java.io.IOException;

@WebServlet("/admin/users/create")
public class UserCreateServlet extends HttpServlet {

    @Inject
    private UserService userService;

    @Inject
    private DoctorService doctorService;

    @Inject
    private PatientService patientService;

    @Inject
    private SpecialtyService specialtyService;

    @Inject
    private DepartmentService departmentService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        loadFormData(request);
        request.getRequestDispatcher("/WEB-INF/views/admin/users/create.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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

                request.setAttribute("error", "Tous les champs de base sont obligatoires.");
                preserveFormData(request);
                loadFormData(request);
                request.getRequestDispatcher("/WEB-INF/views/admin/users/create.jsp")
                        .forward(request, response);
                return;
            }

            Role role;
            try {
                role = Role.valueOf(roleParam.toUpperCase());
            } catch (IllegalArgumentException e) {
                request.setAttribute("error", "Rôle invalide.");
                preserveFormData(request);
                loadFormData(request);
                request.getRequestDispatcher("/WEB-INF/views/admin/users/create.jsp")
                        .forward(request, response);
                return;
            }

            User newUser = userService.createUser(
                    firstName.trim(),
                    lastName.trim(),
                    email.trim(),
                    password,
                    role
            );

            if (role == Role.DOCTOR) {
                createDoctorProfile(request, newUser);
            } else if (role == Role.PATIENT) {
                createPatientProfile(request, newUser);
            }

            response.sendRedirect(request.getContextPath() + "/admin/users?success=created");

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            preserveFormData(request);
            loadFormData(request);
            request.getRequestDispatcher("/WEB-INF/views/admin/users/create.jsp")
                    .forward(request, response);
        } catch (Exception e) {
            System.err.println("Erreur dans UserCreateServlet : " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Erreur inattendue. Veuillez réessayer.");
            preserveFormData(request);
            loadFormData(request);
            request.getRequestDispatcher("/WEB-INF/views/admin/users/create.jsp").forward(request, response);
        }
    }

    private void createDoctorProfile(HttpServletRequest request, User user) {
        String registrationNumber = request.getParameter("registrationNumber");
        String title = request.getParameter("title");
        String specialtyIdStr = request.getParameter("specialtyId");
        String departmentIdStr = request.getParameter("departmentId");

        // Validation des champs docteur
        if (registrationNumber == null || registrationNumber.trim().isEmpty()) {
            throw new IllegalArgumentException("Le numéro d'enregistrement est obligatoire.");
        }
        if (title == null || title.trim().isEmpty()) {
            throw new IllegalArgumentException("Le titre est obligatoire.");
        }
        if (specialtyIdStr == null || specialtyIdStr.trim().isEmpty()) {
            throw new IllegalArgumentException("La spécialité est obligatoire.");
        }
        if (departmentIdStr == null || departmentIdStr.trim().isEmpty()) {
            throw new IllegalArgumentException("Le département est obligatoire.");
        }

        try {
            Long specialtyId = Long.parseLong(specialtyIdStr);
            Long departmentId = Long.parseLong(departmentIdStr);

            // Récupération de la spécialité
            Specialty specialty = specialtyService.getSpecialtyById(specialtyId);

            // Récupération du département
            Department department = departmentService.getDepartmentById(departmentId);

            Doctor doctor = new Doctor(
                    registrationNumber.trim(),
                    title.trim(),
                    specialty,
                    department,
                    user
            );

            doctorService.save(doctor);

        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("ID de spécialité ou département invalide.");
        }
    }

    private void createPatientProfile(HttpServletRequest request, User user) {
        String cin = request.getParameter("cin");
        String birthDay = request.getParameter("birthDay");
        String gender = request.getParameter("gender");
        String phoneNumber = request.getParameter("phoneNumber");
        String adresse = request.getParameter("adresse");

        if (cin == null || cin.trim().isEmpty()) {
            throw new IllegalArgumentException("Le CIN est obligatoire.");
        }
        if (birthDay == null || birthDay.trim().isEmpty()) {
            throw new IllegalArgumentException("La date de naissance est obligatoire.");
        }
        if (gender == null || gender.trim().isEmpty()) {
            throw new IllegalArgumentException("Le genre est obligatoire.");
        }
        if (!gender.equals("M") && !gender.equals("F")) {
            throw new IllegalArgumentException("Le genre doit être M ou F.");
        }
        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            throw new IllegalArgumentException("Le numéro de téléphone est obligatoire.");
        }
        if (!phoneNumber.matches("^[0-9]{10}$")) {
            throw new IllegalArgumentException("Le numéro de téléphone doit contenir 10 chiffres.");
        }
        if (adresse == null || adresse.trim().isEmpty()) {
            throw new IllegalArgumentException("L'adresse est obligatoire.");
        }

        // Création du patient
        Patient patient = new Patient(
                cin.trim(),
                birthDay.trim(),
                gender,
                adresse.trim(),
                phoneNumber.trim(),
                user
        );

        patientService.save(patient);
    }

    private void preserveFormData(HttpServletRequest request) {
        // Données de base
        request.setAttribute("firstName", request.getParameter("firstName"));
        request.setAttribute("lastName", request.getParameter("lastName"));
        request.setAttribute("email", request.getParameter("email"));
        request.setAttribute("role", request.getParameter("role"));

        // Données docteur
        request.setAttribute("registrationNumber", request.getParameter("registrationNumber"));
        request.setAttribute("title", request.getParameter("title"));
        request.setAttribute("specialtyId", request.getParameter("specialtyId"));
        request.setAttribute("departmentId", request.getParameter("departmentId"));

        // Données patient
        request.setAttribute("cin", request.getParameter("cin"));
        request.setAttribute("birthDay", request.getParameter("birthDay"));
        request.setAttribute("gender", request.getParameter("gender"));
        request.setAttribute("phoneNumber", request.getParameter("phoneNumber"));
        request.setAttribute("adresse", request.getParameter("adresse"));
    }

    private void loadFormData(HttpServletRequest request) {
        try {
            request.setAttribute("specialties", specialtyService.getAllSpecialties());
            request.setAttribute("departments", departmentService.getAllDepartments());
        } catch (Exception e) {
            System.err.println("Erreur lors du chargement des données : " + e.getMessage());
            e.printStackTrace();
        }
    }
}