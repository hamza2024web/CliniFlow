<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            padding: 30px;
            min-height: 100vh;
        }

        .container {
            max-width: 800px;
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

        /* Alert Messages */
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

        /* Form Container */
        .form-container {
            background: white;
            border-radius: 12px;
            padding: 40px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
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
        .form-group input[type="password"] {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s;
            outline: none;
        }

        .form-group input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .help-text {
            font-size: 13px;
            color: #718096;
            margin-top: 6px;
        }

        /* Radio Group */
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

        /* Form Actions */
        .form-actions {
            display: flex;
            gap: 12px;
            margin-top: 30px;
            flex-wrap: wrap;
        }

        /* Buttons */
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

        /* Responsive */
        @media (max-width: 768px) {
            body {
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
        <form method="post" action="<%= request.getContextPath() %>/admin/users/create">
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
                <div class="help-text">Sélectionnez un rôle</div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">✓ Créer l'utilisateur</button>
                <a href="<%= request.getContextPath() %>/admin/users" class="btn btn-secondary">Annuler</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
