<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.clinique.domain.*" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier un Utilisateur - Admin</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f7fafc;
            color: #2d3748;
        }

        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 260px;
            background: linear-gradient(180deg, #2d3748 0%, #1a202c 100%);
            color: white;
            padding: 20px;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
        }

        .sidebar-header {
            padding: 20px 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            margin-bottom: 30px;
        }

        .sidebar-header h2 {
            font-size: 22px;
            font-weight: 600;
        }

        .sidebar-header .role-badge {
            display: inline-block;
            background: #e53e3e;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            margin-top: 8px;
        }

        .nav-menu {
            list-style: none;
        }

        .nav-item {
            margin-bottom: 8px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 12px 16px;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s;
        }

        .nav-link:hover,
        .nav-link.active {
            background: rgba(255, 255, 255, 0.1);
            color: white;
        }

        .nav-icon {
            margin-right: 12px;
            font-size: 18px;
        }

        .logout-btn {
            position: absolute;
            bottom: 20px;
            left: 20px;
            right: 20px;
            padding: 12px;
            background: #e53e3e;
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 8px;
            transition: background 0.3s;
        }

        .logout-btn:hover {
            background: #c53030;
        }

        .main-content {
            flex: 1;
            margin-left: 260px;
            padding: 30px;
            min-height: 100vh;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            color: #4a5568;
            text-decoration: none;
            font-size: 14px;
            margin-bottom: 20px;
            padding: 8px 12px;
            border-radius: 6px;
            transition: all 0.3s;
        }

        .back-link:hover {
            background: #e2e8f0;
            color: #2d3748;
        }

        h1 {
            font-size: 32px;
            color: #2d3748;
            margin-bottom: 30px;
            font-weight: 600;
        }

        .alert {
            padding: 16px 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            font-size: 15px;
            animation: slideIn 0.3s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert-error {
            background: #fff5f5;
            border-left: 4px solid #e53e3e;
            color: #742a2a;
        }

        .info-box {
            background: linear-gradient(135deg, #ebf4ff 0%, #e9d8fd 100%);
            padding: 16px 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            font-size: 14px;
            color: #2d3748;
            border-left: 4px solid #667eea;
        }

        .form-container {
            background: white;
            border-radius: 12px;
            padding: 40px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .form-section {
            margin-bottom: 35px;
            padding-bottom: 35px;
            border-bottom: 2px solid #e2e8f0;
        }

        .form-section:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .section-title {
            font-size: 18px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-group {
            margin-bottom: 24px;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 8px;
        }

        .required::after {
            content: " *";
            color: #e53e3e;
        }

        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group input[type="date"],
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s;
            outline: none;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .help-text {
            font-size: 13px;
            color: #718096;
            margin-top: 6px;
        }

        .role-specific-fields {
            display: none;
            animation: fadeIn 0.4s ease-in;
        }

        .role-specific-fields.active {
            display: block;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .form-actions {
            display: flex;
            gap: 12px;
            margin-top: 30px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
        }

        .btn-warning {
            background: #ed8936;
            color: white;
        }

        .btn-warning:hover {
            background: #dd6b20;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(237, 137, 54, 0.4);
        }

        .btn-secondary {
            background: #718096;
            color: white;
        }

        .btn-secondary:hover {
            background: #4a5568;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                position: relative;
                height: auto;
            }

            .main-content {
                margin-left: 0;
                padding: 15px;
            }

            .form-container {
                padding: 25px;
            }

            h1 {
                font-size: 24px;
            }

            .form-row {
                grid-template-columns: 1fr;
            }

            .form-actions {
                flex-direction: column;
            }

            .form-actions .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <aside class="sidebar">
        <div class="sidebar-header">
            <h2>Clinique Digitale</h2>
            <span class="role-badge">ADMINISTRATEUR</span>
        </div>

        <ul class="nav-menu">
            <li class="nav-item">
                <a href="<%= request.getContextPath() %>/admin/dashboard" class="nav-link">
                    <span class="nav-icon">📊</span>
                    Tableau de bord
                </a>
            </li>
            <li class="nav-item">
                <a href="<%= request.getContextPath() %>/admin/users" class="nav-link active">
                    <span class="nav-icon">👥</span>
                    Gestion des utilisateurs
                </a>
            </li>
            <li class="nav-item">
                <a href="<%= request.getContextPath() %>/admin/departments" class="nav-link">
                    <span class="nav-icon">🏥</span>
                    Départements
                </a>
            </li>
            <li class="nav-item">
                <a href="<%= request.getContextPath() %>/admin/specialties" class="nav-link">
                    <span class="nav-icon">🎓</span>
                    Spécialités
                </a>
            </li>
        </ul>

        <a href="<%= request.getContextPath() %>/logout" class="logout-btn">Se déconnecter</a>
    </aside>

    <main class="main-content">
        <div class="container">
            <a href="<%= request.getContextPath() %>/admin/users" class="back-link">← Retour à la liste</a>

            <h1>✏️ Modifier l'Utilisateur</h1>

            <%
                String error = (String) request.getAttribute("error");
                if (error != null) {
            %>
            <div class="alert alert-error"><%= error %></div>
            <% } %>

            <%
                User user = (User) request.getAttribute("user");
                Doctor doctor = (Doctor) request.getAttribute("doctor");
                Patient patient = (Patient) request.getAttribute("patient");

                if (user != null) {
            %>
            <div class="info-box">
                <strong>ID:</strong> #<%= user.getId() %> |
                <strong>Créé le:</strong> <%= user.getCreatedAt() != null ? user.getCreatedAt().toString().substring(0, 10) : "N/A" %>
            </div>

            <div class="form-container">
                <form method="post" action="<%= request.getContextPath() %>/admin/users/edit" id="userForm">
                    <input type="hidden" name="id" value="<%= user.getId() %>">

                    <!-- Section: Informations de base -->
                    <div class="form-section">
                        <h3 class="section-title">👤 Informations de Base</h3>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="firstName" class="required">Prénom</label>
                                <input type="text" id="firstName" name="firstName"
                                       value="<%= user.getFirstName() %>" required>
                            </div>

                            <div class="form-group">
                                <label for="lastName" class="required">Nom</label>
                                <input type="text" id="lastName" name="lastName"
                                       value="<%= user.getLastName() %>" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="email" class="required">Email</label>
                            <input type="email" id="email" name="email"
                                   value="<%= user.getEmail() %>" required>
                        </div>

                        <div class="form-group">
                            <label for="role" class="required">Rôle</label>
                            <select id="role" name="role" required>
                                <option value="">-- Sélectionner un rôle --</option>
                                <option value="ADMIN" <%= "ADMIN".equals(user.getRole().name()) ? "selected" : "" %>>👑 Administrateur</option>
                                <option value="DOCTOR" <%= "DOCTOR".equals(user.getRole().name()) ? "selected" : "" %>>👨‍⚕️ Docteur</option>
                                <option value="STAFF" <%= "STAFF".equals(user.getRole().name()) ? "selected" : "" %>>👔 Personnel</option>
                                <option value="PATIENT" <%= "PATIENT".equals(user.getRole().name()) ? "selected" : "" %>>🧑 Patient</option>
                            </select>
                        </div>
                    </div>

                    <!-- Section: Informations Docteur -->
                    <div id="doctorFields" class="form-section role-specific-fields <%= user.getRole().name().equals("DOCTOR") ? "active" : "" %>">
                        <h3 class="section-title">👨‍⚕️ Informations Docteur</h3>

                        <div class="form-group">
                            <label for="registrationNumber" class="required">Numéro d'Enregistrement</label>
                            <input type="text" id="registrationNumber" name="registrationNumber"
                                   value="<%= doctor != null ? doctor.getRegistrationNumber() : "" %>">
                        </div>

                        <div class="form-group">
                            <label for="title" class="required">Titre</label>
                            <input type="text" id="title" name="title"
                                   value="<%= doctor != null ? doctor.getTitle() : "" %>">
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="specialtyId" class="required">Spécialité</label>
                                <select id="specialtyId" name="specialtyId">
                                    <option value="">-- Sélectionner une spécialité --</option>
                                    <%
                                        List<Specialty> specialties = (List<Specialty>) request.getAttribute("specialties");
                                        if (specialties != null) {
                                            for (Specialty specialty : specialties) {
                                                boolean isSelected = doctor != null &&
                                                        doctor.getSpecialty() != null &&
                                                        doctor.getSpecialty().getId().equals(specialty.getId());
                                    %>
                                    <option value="<%= specialty.getId() %>" <%= isSelected ? "selected" : "" %>>
                                        <%= specialty.getName() %>
                                    </option>
                                    <%
                                            }
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="departmentId" class="required">Département</label>
                                <select id="departmentId" name="departmentId">
                                    <option value="">-- Sélectionner un département --</option>
                                    <%
                                        List<Department> departments = (List<Department>) request.getAttribute("departments");
                                        if (departments != null) {
                                            for (Department department : departments) {
                                                boolean isSelected = doctor != null &&
                                                        doctor.getDepartment() != null &&
                                                        doctor.getDepartment().getId().equals(department.getId());
                                    %>
                                    <option value="<%= department.getId() %>" <%= isSelected ? "selected" : "" %>>
                                        <%= department.getName() %>
                                    </option>
                                    <%
                                            }
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Section: Informations Patient -->
                    <div id="patientFields" class="form-section role-specific-fields <%= user.getRole().name().equals("PATIENT") ? "active" : "" %>">
                        <h3 class="section-title">🧑 Informations Patient</h3>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="cin" class="required">CIN</label>
                                <input type="text" id="cin" name="cin"
                                       value="<%= patient != null ? patient.getCin() : "" %>">
                            </div>

                            <div class="form-group">
                                <label for="birthDay" class="required">Date de Naissance</label>
                                <input type="date" id="birthDay" name="birthDay"
                                       value="<%= patient != null ? patient.getBirthDay() : "" %>">
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="gender" class="required">Genre</label>
                                <select id="gender" name="gender">
                                    <option value="">-- Sélectionner --</option>
                                    <option value="M" <%= patient != null && "M".equals(patient.getGender()) ? "selected" : "" %>>Masculin</option>
                                    <option value="F" <%= patient != null && "F".equals(patient.getGender()) ? "selected" : "" %>>Féminin</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="phoneNumber" class="required">Numéro de Téléphone</label>
                                <input type="text" id="phoneNumber" name="phoneNumber"
                                       pattern="[0-9]{10}" maxlength="10"
                                       value="<%= patient != null ? patient.getPhoneNumber() : "" %>">
                                <div class="help-text">10 chiffres</div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="adresse" class="required">Adresse</label>
                            <textarea id="adresse" name="adresse"><%= patient != null ? patient.getAdresse() : "" %></textarea>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-warning">✓ Enregistrer les modifications</button>
                        <a href="<%= request.getContextPath() %>/admin/users" class="btn btn-secondary">Annuler</a>
                    </div>
                </form>
            </div>
            <% } else { %>
            <div class="alert alert-error">Utilisateur introuvable.</div>
            <a href="<%= request.getContextPath() %>/admin/users" class="btn btn-secondary">Retour à la liste</a>
            <% } %>
        </div>
    </main>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const roleSelect = document.getElementById('role');
        const doctorFields = document.getElementById('doctorFields');
        const patientFields = document.getElementById('patientFields');

        function toggleRoleFields(selectedRole) {
            doctorFields.classList.remove('active');
            patientFields.classList.remove('active');

            setRequiredFields(doctorFields, false);
            setRequiredFields(patientFields, false);

            if (selectedRole === 'DOCTOR') {
                doctorFields.classList.add('active');
                setRequiredFields(doctorFields, true);
            } else if (selectedRole === 'PATIENT') {
                patientFields.classList.add('active');
                setRequiredFields(patientFields, true);
            }
        }

        function setRequiredFields(container, isRequired) {
            const inputs = container.querySelectorAll('input, select, textarea');
            inputs.forEach(input => {
                if (isRequired) {
                    const label = container.querySelector(`label[for="${input.id}"]`);
                    if (label && label.classList.contains('required')) {
                        input.setAttribute('required', 'required');
                    }
                } else {
                    input.removeAttribute('required');
                }
            });
        }

        roleSelect.addEventListener('change', function() {
            toggleRoleFields(this.value);
        });

        // Initialiser l'affichage au chargement
        toggleRoleFields(roleSelect.value);
    });
</script>
</body>
</html>