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
import java.util.Optional;

@WebServlet("/admin/users/edit")
public class UserEditServlet extends HttpServlet {

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
                return;
            }

            User user = userOpt.get();
            request.setAttribute("user", user);

            // Charger les données spécifiques selon le rôle
            if (user.getRole() == Role.DOCTOR) {
                Optional<Doctor> doctorOpt = doctorService.findByUserId(userId);
                doctorOpt.ifPresent(doctor -> request.setAttribute("doctor", doctor));
            } else if (user.getRole() == Role.PATIENT) {
                Optional<Patient> patientOpt = patientService.findByUserId(userId);
                patientOpt.ifPresent(patient -> request.setAttribute("patient", patient));
            }

            // Charger les données pour les selects
            loadFormData(request);

            request.getRequestDispatcher("/WEB-INF/views/admin/users/edit.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/users?error=invalid_id");
        } catch (Exception e) {
            System.err.println("Erreur dans UserEditServlet (GET) : " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/users?error=server_error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String roleParam = request.getParameter("role");

            // Validation de base
            if (idParam == null || idParam.trim().isEmpty() ||
                    firstName == null || firstName.trim().isEmpty() ||
                    lastName == null || lastName.trim().isEmpty() ||
                    email == null || email.trim().isEmpty() ||
                    roleParam == null || roleParam.trim().isEmpty()) {

                request.setAttribute("error", "Tous les champs de base sont obligatoires.");
                preserveFormData(request);
                doGet(request, response);
                return;
            }

            Long userId = Long.parseLong(idParam);
            Role role;
            try {
                role = Role.valueOf(roleParam.toUpperCase());
            } catch (IllegalArgumentException e) {
                request.setAttribute("error", "Rôle invalide.");
                preserveFormData(request);
                doGet(request, response);
                return;
            }

            // Mise à jour de l'utilisateur
            User updatedUser = userService.updateUser(
                    userId,
                    firstName.trim(),
                    lastName.trim(),
                    email.trim(),
                    role
            );

            // Mise à jour des profils spécifiques
            if (role == Role.DOCTOR) {
                updateDoctorProfile(request, updatedUser);
            } else if (role == Role.PATIENT) {
                updatePatientProfile(request, updatedUser);
            }

            response.sendRedirect(request.getContextPath() + "/admin/users?success=updated");

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            preserveFormData(request);
            doGet(request, response);
        } catch (Exception e) {
            System.err.println("Erreur dans UserEditServlet (POST) : " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Erreur inattendue : " + e.getMessage());
            preserveFormData(request);
            doGet(request, response);
        }
    }

    private void updateDoctorProfile(HttpServletRequest request, User user) {
        String registrationNumber = request.getParameter("registrationNumber");
        String title = request.getParameter("title");
        String specialtyIdStr = request.getParameter("specialtyId");
        String departmentIdStr = request.getParameter("departmentId");

        // Validation
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

            Specialty specialty = specialtyService.getSpecialtyById(specialtyId);
            Department department = departmentService.getDepartmentById(departmentId);

            // Chercher ou créer le profil docteur
            Optional<Doctor> existingDoctorOpt = doctorService.findByUserId(user.getId());

            if (existingDoctorOpt.isPresent()) {
                // Mise à jour du profil existant
                Doctor doctor = existingDoctorOpt.get();
                doctor.setRegistrationNumber(registrationNumber.trim());
                doctor.setTitle(title.trim());
                doctor.setSpecialty(specialty);
                doctor.setDepartment(department);
                doctorService.save(doctor);
            } else {
                // Création d'un nouveau profil
                Doctor newDoctor = new Doctor(
                        registrationNumber.trim(),
                        title.trim(),
                        specialty,
                        department,
                        user
                );
                doctorService.save(newDoctor);
            }

        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("ID de spécialité ou département invalide.");
        }
    }

    private void updatePatientProfile(HttpServletRequest request, User user) {
        String cin = request.getParameter("cin");
        String birthDay = request.getParameter("birthDay");
        String gender = request.getParameter("gender");
        String phoneNumber = request.getParameter("phoneNumber");
        String adresse = request.getParameter("adresse");

        // Validation
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

        // Chercher ou créer le profil patient
        Optional<Patient> existingPatientOpt = patientService.findByUserId(user.getId());

        if (existingPatientOpt.isPresent()) {
            // Mise à jour du profil existant
            Patient patient = existingPatientOpt.get();
            patient.setCin(cin.trim());
            patient.setBirthDay(birthDay.trim());
            patient.setGender(gender);
            patient.setAdresse(adresse.trim());
            patient.setPhoneNumber(phoneNumber.trim());
            patientService.save(patient);
        } else {
            // Création d'un nouveau profil
            Patient newPatient = new Patient(
                    cin.trim(),
                    birthDay.trim(),
                    gender,
                    adresse.trim(),
                    phoneNumber.trim(),
                    user
            );
            patientService.save(newPatient);
        }
    }

    private void preserveFormData(HttpServletRequest request) {
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