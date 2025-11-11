<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.clinique.domain.Specialty" %>
<%@ page import="com.clinique.domain.Department" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Créer un Utilisateur - Admin</title>
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
        .form-group input[type="password"],
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

        .radio-group {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 12px;
        }

        .radio-item {
            display: flex;
            align-items: center;
            padding: 14px 18px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            transition: all 0.3s;
            cursor: pointer;
        }

        .radio-item:hover {
            border-color: #cbd5e0;
            background: #f7fafc;
        }

        .radio-item input[type="radio"] {
            width: 20px;
            height: 20px;
            cursor: pointer;
            margin-right: 10px;
        }

        .radio-item label {
            cursor: pointer;
            margin: 0;
            font-weight: 500;
            font-size: 14px;
        }

        .radio-item:has(input:checked) {
            border-color: #667eea;
            background: linear-gradient(135deg, #ebf4ff 0%, #e9d8fd 100%);
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

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
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

            .radio-group {
                grid-template-columns: 1fr;
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

            <h1>➕ Créer un Nouvel Utilisateur</h1>

            <%
                String error = (String) request.getAttribute("error");
                if (error != null) {
            %>
            <div class="alert alert-error"><%= error %></div>
            <% } %>

            <div class="form-container">
                <form method="post" action="<%= request.getContextPath() %>/admin/users/create" id="userForm">

                    <!-- Section: Informations de base -->
                    <div class="form-section">
                        <h3 class="section-title">👤 Informations de Base</h3>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="firstName" class="required">Prénom</label>
                                <input type="text" id="firstName" name="firstName"
                                       value="<%= request.getAttribute("firstName") != null ? request.getAttribute("firstName") : "" %>"
                                       required>
                            </div>

                            <div class="form-group">
                                <label for="lastName" class="required">Nom</label>
                                <input type="text" id="lastName" name="lastName"
                                       value="<%= request.getAttribute("lastName") != null ? request.getAttribute("lastName") : "" %>"
                                       required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="email" class="required">Email</label>
                            <input type="email" id="email" name="email"
                                   value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                                   required>
                            <div class="help-text">L'email servira d'identifiant de connexion</div>
                        </div>

                        <div class="form-group">
                            <label for="password" class="required">Mot de passe</label>
                            <input type="password" id="password" name="password" required minlength="6">
                            <div class="help-text">Minimum 6 caractères</div>
                        </div>

                        <div class="form-group">
                            <label class="required">Rôle</label>
                            <div class="radio-group">
                                <div class="radio-item">
                                    <input type="radio" id="role-admin" name="role" value="ADMIN" required>
                                    <label for="role-admin">👑 Administrateur</label>
                                </div>
                                <div class="radio-item">
                                    <input type="radio" id="role-doctor" name="role" value="DOCTOR">
                                    <label for="role-doctor">👨‍⚕️ Docteur</label>
                                </div>
                                <div class="radio-item">
                                    <input type="radio" id="role-staff" name="role" value="STAFF">
                                    <label for="role-staff">👔 Personnel</label>
                                </div>
                                <div class="radio-item">
                                    <input type="radio" id="role-patient" name="role" value="PATIENT">
                                    <label for="role-patient">🧑 Patient</label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Section: Informations Docteur -->
                    <div id="doctorFields" class="form-section role-specific-fields">
                        <h3 class="section-title">👨‍⚕️ Informations Docteur</h3>

                        <div class="form-group">
                            <label for="registrationNumber" class="required">Numéro d'Enregistrement</label>
                            <input type="text" id="registrationNumber" name="registrationNumber" maxlength="50"
                                   value="<%= request.getAttribute("registrationNumber") != null ? request.getAttribute("registrationNumber") : "" %>">
                            <div class="help-text">Numéro d'ordre du médecin</div>
                        </div>

                        <div class="form-group">
                            <label for="title" class="required">Titre</label>
                            <input type="text" id="title" name="title" maxlength="100" placeholder="Ex: Dr., Pr., Docteur"
                                   value="<%= request.getAttribute("title") != null ? request.getAttribute("title") : "" %>">
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
                                    %>
                                    <option value="<%= specialty.getId() %>"><%= specialty.getName() %></option>
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
                                    %>
                                    <option value="<%= department.getId() %>"><%= department.getName() %></option>
                                    <%
                                            }
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Section: Informations Patient -->
                    <div id="patientFields" class="form-section role-specific-fields">
                        <h3 class="section-title">🧑 Informations Patient</h3>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="cin" class="required">CIN</label>
                                <input type="text" id="cin" name="cin" maxlength="20">
                                <div class="help-text">Carte d'Identité Nationale</div>
                            </div>

                            <div class="form-group">
                                <label for="birthDay" class="required">Date de Naissance</label>
                                <input type="date" id="birthDay" name="birthDay">
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="gender" class="required">Genre</label>
                                <select id="gender" name="gender">
                                    <option value="">-- Sélectionner --</option>
                                    <option value="M">Masculin</option>
                                    <option value="F">Féminin</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="phoneNumber" class="required">Numéro de Téléphone</label>
                                <input type="text" id="phoneNumber" name="phoneNumber"
                                       pattern="[0-9]{10}" maxlength="10"
                                       placeholder="0612345678">
                                <div class="help-text">10 chiffres</div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="adresse" class="required">Adresse</label>
                            <textarea id="adresse" name="adresse" maxlength="200"></textarea>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">✓ Créer l'utilisateur</button>
                        <a href="<%= request.getContextPath() %>/admin/users" class="btn btn-secondary">Annuler</a>
                    </div>
                </form>
            </div>
        </div>
    </main>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const roleRadios = document.querySelectorAll('input[name="role"]');
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

        roleRadios.forEach(radio => {
            radio.addEventListener('change', function() {
                toggleRoleFields(this.value);
            });
        });

        const selectedRole = document.querySelector('input[name="role"]:checked');
        if (selectedRole) {
            toggleRoleFields(selectedRole.value);
        }
    });
</script>
</body>
</html>