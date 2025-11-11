<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.clinique.webapp.dto.UserDTO" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Utilisateurs - Admin</title>
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

        /* Sidebar Styles */
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

        /* Main Content Area */
        .main-content {
            flex: 1;
            margin-left: 260px;
            padding: 30px;
        }

        .container {
            max-width: 1400px;
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

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .header h1 {
            font-size: 32px;
            color: #2d3748;
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

        .alert-success {
            background: #f0fff4;
            border-left: 4px solid #38a169;
            color: #22543d;
        }

        .alert-error {
            background: #fff5f5;
            border-left: 4px solid #e53e3e;
            color: #742a2a;
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

        .btn-warning {
            background: #ed8936;
            color: white;
        }

        .btn-warning:hover {
            background: #dd6b20;
        }

        .btn-secondary {
            background: #718096;
            color: white;
        }

        .btn-secondary:hover {
            background: #4a5568;
        }

        .btn-success {
            background: #38a169;
            color: white;
        }

        .btn-success:hover {
            background: #2f855a;
        }

        .btn-danger {
            background: #e53e3e;
            color: white;
        }

        .btn-danger:hover {
            background: #c53030;
        }

        .btn-sm {
            padding: 8px 16px;
            font-size: 13px;
        }

        /* Table Container */
        .table-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        thead th {
            padding: 16px 20px;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
            color: white;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        tbody tr {
            border-bottom: 1px solid #e2e8f0;
            transition: all 0.3s;
        }

        tbody tr:hover {
            background: #f7fafc;
        }

        tbody tr:last-child {
            border-bottom: none;
        }

        tbody td {
            padding: 16px 20px;
            font-size: 14px;
            color: #2d3748;
        }

        /* Badges */
        .badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .badge-admin {
            background: #fed7d7;
            color: #9b2c2c;
        }

        .badge-doctor {
            background: #c6f6d5;
            color: #22543d;
        }

        .badge-patient {
            background: #bee3f8;
            color: #2c5282;
        }

        .badge-staff {
            background: #e9d8fd;
            color: #553c9a;
        }

        /* Status */
        .status {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-active {
            background: #c6f6d5;
            color: #22543d;
        }

        .status-inactive {
            background: #fed7d7;
            color: #9b2c2c;
        }

        /* Actions */
        .actions {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        /* No Data */
        .no-data {
            background: white;
            border-radius: 12px;
            padding: 60px 30px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .no-data p {
            color: #718096;
            font-size: 16px;
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .table-container {
                overflow-x: auto;
            }

            table {
                min-width: 1000px;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                position: relative;
                height: auto;
            }

            .main-content {
                margin-left: 0;
            }

            body {
                padding: 15px;
            }

            .header {
                flex-direction: column;
                align-items: flex-start;
            }

            .header h1 {
                font-size: 24px;
            }

            .actions {
                flex-direction: column;
            }

            .actions .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <!-- Sidebar -->
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
            <li class="nav-item">
                <a href="#" class="nav-link">
                    <span class="nav-icon">📈</span>
                    Statistiques
                </a>
            </li>
        </ul>

        <a href="<%= request.getContextPath() %>/logout" class="logout-btn">Se déconnecter</a>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <a href="<%= request.getContextPath() %>/admin/dashboard" class="back-link">← Retour au Dashboard</a>

            <div class="header">
                <h1>👥 Gestion des Utilisateurs</h1>
                <a href="<%= request.getContextPath() %>/admin/users/create" class="btn btn-primary">
                    ➕ Créer un utilisateur
                </a>
            </div>

            <%
                String success = request.getParameter("success");
                String error = request.getParameter("error");

                if (success != null) {
                    String message = "";
                    switch(success) {
                        case "created": message = "✓ Utilisateur créé avec succès !"; break;
                        case "updated": message = "✓ Utilisateur modifié avec succès !"; break;
                        case "deleted": message = "✓ Utilisateur supprimé avec succès !"; break;
                        case "status_updated": message = "✓ Statut de l'utilisateur modifié !"; break;
                        default: message = "✓ Opération réussie !";
                    }
            %>
            <div class="alert alert-success"><%= message %></div>
            <%
                }

                if (error != null) {
                    String message = "";
                    switch(error) {
                        case "missing_id": message = "❌ ID manquant."; break;
                        case "user_not_found": message = "❌ Utilisateur introuvable."; break;
                        case "invalid_id": message = "❌ ID invalide."; break;
                        case "cannot_delete_self": message = "❌ Vous ne pouvez pas vous supprimer vous-même."; break;
                        case "delete_failed": message = "❌ Échec de la suppression."; break;
                        case "server_error": message = "❌ Erreur serveur."; break;
                        default: message = "❌ Une erreur est survenue.";
                    }
            %>
            <div class="alert alert-error"><%= message %></div>
            <% } %>

            <%
                List<UserDTO> users = (List<UserDTO>) request.getAttribute("users");
                if (users == null || users.isEmpty()) {
            %>
            <div class="no-data">
                <p>Aucun utilisateur trouvé.</p>
            </div>
            <%
            } else {
            %>
            <div class="table-container">
                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nom Complet</th>
                        <th>Email</th>
                        <th>Rôle</th>
                        <th>Statut</th>
                        <th>Date de Création</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for (UserDTO user : users) {
                            String role = user.getRole();
                            String roleDisplay = (role != null) ? role : "N/A";

                            String badgeClass = "badge";
                            if (role != null) {
                                switch(role) {
                                    case "ADMIN":
                                        badgeClass += " badge-admin";
                                        break;
                                    case "DOCTOR":
                                        badgeClass += " badge-doctor";
                                        break;
                                    case "PATIENT":
                                        badgeClass += " badge-patient";
                                        break;
                                    case "STAFF":
                                        badgeClass += " badge-staff";
                                        break;
                                }
                            }
                    %>
                    <tr>
                        <td>#<%= user.getId() %></td>
                        <td><strong><%= user.getFullName() %></strong></td>
                        <td><%= user.getEmail() %></td>
                        <td>
                            <span class="<%= badgeClass %>"><%= roleDisplay %></span>
                        </td>
                        <td>
                            <% if (user.isActive()) { %>
                            <span class="status status-active">Actif</span>
                            <% } else { %>
                            <span class="status status-inactive">Inactif</span>
                            <% } %>
                        </td>
                        <td><%= user.getCreatedAt() != null ? user.getCreatedAt().toString().substring(0, 10) : "N/A" %></td>
                        <td>
                            <div class="actions">
                                <a href="<%= request.getContextPath() %>/admin/users/edit?id=<%= user.getId() %>"
                                   class="btn btn-warning btn-sm" title="Modifier">
                                    ✏️ Modifier
                                </a>

                                <form method="post" action="<%= request.getContextPath() %>/admin/users/toggle-status"
                                      style="display: inline; margin: 0;">
                                    <input type="hidden" name="id" value="<%= user.getId() %>">
                                    <button type="submit"
                                            class="btn <%= user.isActive() ? "btn-secondary" : "btn-success" %> btn-sm"
                                            title="<%= user.isActive() ? "Désactiver" : "Activer" %>">
                                        <%= user.isActive() ? "🚫 Désactiver" : "✓ Activer" %>
                                    </button>
                                </form>

                                <form method="post" action="<%= request.getContextPath() %>/admin/users/delete"
                                      style="display: inline; margin: 0;"
                                      onsubmit="return confirm('⚠️ Êtes-vous sûr de vouloir supprimer <%= user.getFullName() %> ?');">
                                    <input type="hidden" name="id" value="<%= user.getId() %>">
                                    <button type="submit" class="btn btn-danger btn-sm" title="Supprimer">
                                        🗑️ Supprimer
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
            <% } %>
        </div>
    </main>
</div>
</body>
</html>
