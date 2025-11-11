<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.clinique.domain.Specialty" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Spécialités</title>
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
        }

        .page-header {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-header h1 {
            font-size: 28px;
            color: #2d3748;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .page-header .icon {
            font-size: 32px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 24px;
            border-radius: 8px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-weight: 500;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
        }

        .table-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }

        .table-header {
            padding: 20px 30px;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .table-header h2 {
            font-size: 18px;
            color: #2d3748;
            font-weight: 600;
        }

        .search-box {
            display: flex;
            align-items: center;
            background: #f7fafc;
            padding: 8px 16px;
            border-radius: 8px;
            gap: 8px;
        }

        .search-box input {
            border: none;
            background: transparent;
            outline: none;
            font-size: 14px;
            width: 250px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: #f7fafc;
        }

        th {
            padding: 16px 30px;
            text-align: left;
            font-weight: 600;
            font-size: 13px;
            color: #718096;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        td {
            padding: 20px 30px;
            border-top: 1px solid #e2e8f0;
            font-size: 14px;
        }

        tbody tr {
            transition: background 0.2s;
        }

        tbody tr:hover {
            background: #f7fafc;
        }

        .badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .badge-code {
            background: #ebf4ff;
            color: #3182ce;
        }

        .badge-department {
            background: #f0fff4;
            color: #38a169;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .btn-edit {
            padding: 8px 16px;
            background: #edf2f7;
            color: #4a5568;
            border: none;
            border-radius: 6px;
            font-size: 13px;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .btn-edit:hover {
            background: #667eea;
            color: white;
        }

        .btn-delete {
            padding: 8px 16px;
            background: #fff5f5;
            color: #e53e3e;
            border: none;
            border-radius: 6px;
            font-size: 13px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-delete:hover {
            background: #e53e3e;
            color: white;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #718096;
        }

        .empty-state .icon {
            font-size: 64px;
            margin-bottom: 20px;
            opacity: 0.5;
        }

        .empty-state h3 {
            font-size: 20px;
            margin-bottom: 10px;
            color: #2d3748;
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

            .page-header {
                flex-direction: column;
                gap: 20px;
                align-items: flex-start;
            }

            .search-box input {
                width: 150px;
            }

            table {
                font-size: 12px;
            }

            th, td {
                padding: 12px 15px;
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
                <a href="<%=request.getContextPath()%>/admin/dashboard" class="nav-link">
                    <span class="nav-icon">📊</span>
                    Tableau de bord
                </a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/admin/users" class="nav-link">
                    <span class="nav-icon">👥</span>
                    Gestion des utilisateurs
                </a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/admin/departments" class="nav-link">
                    <span class="nav-icon">🏥</span>
                    Départements
                </a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/admin/specialties" class="nav-link active">
                    <span class="nav-icon">🎓</span>
                    Spécialités
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">
                    <span class="nav-icon">⚙️</span>
                    Configuration
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">
                    <span class="nav-icon">📈</span>
                    Statistiques
                </a>
            </li>
        </ul>

        <a href="<%=request.getContextPath()%>/logout" class="logout-btn">Se déconnecter</a>
    </aside>

    <main class="main-content">
        <div class="page-header">
            <h1>
                <span class="icon">🎓</span>
                Gestion des Spécialités
            </h1>
            <a href="<%=request.getContextPath()%>/admin/specialties/create" class="btn-primary">
                ➕ Créer une spécialité
            </a>
        </div>

        <div class="table-container">
            <div class="table-header">
                <h2>Liste des spécialités</h2>
                <div class="search-box">
                    <span>🔍</span>
                    <input type="text" placeholder="Rechercher..." id="searchInput">
                </div>
            </div>

            <%
                List<Specialty> specialties = (List<Specialty>) request.getAttribute("specialties");
                if (specialties != null && !specialties.isEmpty()) {
            %>
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Nom de la spécialité</th>
                    <th>Code</th>
                    <th>Département</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (Specialty s : specialties) {
                %>
                <tr>
                    <td><strong>#<%= s.getId() %></strong></td>
                    <td><%= s.getName() %></td>
                    <td><span class="badge badge-code"><%= s.getCode() %></span></td>
                    <td>
                        <% if(s.getDepartment() != null) { %>
                        <span class="badge badge-department"><%= s.getDepartment().getName() %></span>
                        <% } else { %>
                        <span style="color: #a0aec0;">Non assigné</span>
                        <% } %>
                    </td>
                    <td>
                        <div class="action-buttons">
                            <a href="<%=request.getContextPath()%>/admin/specialties/edit?id=<%= s.getId() %>" class="btn-edit">✏️ Modifier</a>
                            <form action="<%=request.getContextPath()%>/admin/specialties/delete" method="post" style="display:inline;">
                                <input type="hidden" name="id" value="<%=s.getId()%>"/>
                                <button type="submit" class="btn-delete" onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette spécialité ?');">🗑️ Supprimer</button>
                            </form>
                        </div>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
            <%
            } else {
            %>
            <div class="empty-state">
                <div class="icon">🎓</div>
                <h3>Aucune spécialité trouvée</h3>
                <p>Commencez par créer votre première spécialité</p>
            </div>
            <%
                }
            %>
        </div>
    </main>
</div>

<script>
    document.getElementById('searchInput').addEventListener('keyup', function() {
        const searchValue = this.value.toLowerCase();
        const rows = document.querySelectorAll('tbody tr');

        rows.forEach(row => {
            const text = row.textContent.toLowerCase();
            row.style.display = text.includes(searchValue) ? '' : 'none';
        });
    });
</script>
</body>
</html>