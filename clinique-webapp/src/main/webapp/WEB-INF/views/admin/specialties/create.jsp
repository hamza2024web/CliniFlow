<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.clinique.domain.Department" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Créer une Spécialité</title>
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
        }

        .page-header h1 {
            font-size: 28px;
            color: #2d3748;
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 8px;
        }

        .breadcrumb {
            display: flex;
            gap: 8px;
            font-size: 14px;
            color: #718096;
        }

        .breadcrumb a {
            color: #667eea;
            text-decoration: none;
        }

        .breadcrumb a:hover {
            text-decoration: underline;
        }

        .form-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            padding: 40px;
            max-width: 700px;
        }

        .alert {
            padding: 16px 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 14px;
        }

        .alert-error {
            background: #fff5f5;
            color: #c53030;
            border: 1px solid #feb2b2;
        }

        .form-group {
            margin-bottom: 24px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            color: #2d3748;
            font-size: 14px;
        }

        .form-group label .required {
            color: #e53e3e;
        }

        .form-control {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s;
            font-family: inherit;
            background: white;
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-control::placeholder {
            color: #a0aec0;
        }

        select.form-control {
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%234a5568' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 16px center;
            padding-right: 40px;
        }

        .form-help {
            font-size: 13px;
            color: #718096;
            margin-top: 6px;
        }

        .form-actions {
            display: flex;
            gap: 12px;
            margin-top: 32px;
            padding-top: 24px;
            border-top: 1px solid #e2e8f0;
        }

        .btn {
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            border: none;
            text-decoration: none;
            display: inline-block;
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
            background: #edf2f7;
            color: #4a5568;
        }

        .btn-secondary:hover {
            background: #e2e8f0;
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

            .form-container {
                padding: 24px;
            }

            .form-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
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
        </ul>

        <a href="<%=request.getContextPath()%>/logout" class="logout-btn">Se déconnecter</a>
    </aside>

    <main class="main-content">
        <div class="page-header">
            <h1>
                <span>➕</span>
                Créer une nouvelle spécialité
            </h1>
            <div class="breadcrumb">
                <a href="<%=request.getContextPath()%>/admin/dashboard">Accueil</a>
                <span>/</span>
                <a href="<%=request.getContextPath()%>/admin/specialties">Spécialités</a>
                <span>/</span>
                <span>Créer</span>
            </div>
        </div>

        <div class="form-container">
            <% String error = (String)request.getAttribute("error");
                if(error != null) { %>
            <div class="alert alert-error">
                <span>⚠️</span>
                <span><%=error%></span>
            </div>
            <% } %>

            <form method="post">
                <div class="form-group">
                    <label for="name">
                        Nom de la spécialité <span class="required">*</span>
                    </label>
                    <input
                            type="text"
                            class="form-control"
                            id="name"
                            name="name"
                            placeholder="Ex: Chirurgie cardiovasculaire, Neurologie..."
                            required
                            autofocus
                    />
                    <div class="form-help">Entrez le nom complet de la spécialité</div>
                </div>

                <div class="form-group">
                    <label for="code">
                        Code <span class="required">*</span>
                    </label>
                    <input
                            type="text"
                            class="form-control"
                            id="code"
                            name="code"
                            placeholder="Ex: CHIR-CV, NEUR..."
                            required
                            maxlength="10"
                    />
                    <div class="form-help">Code unique pour identifier la spécialité (max 10 caractères)</div>
                </div>

                <div class="form-group">
                    <label for="departmentId">
                        Département <span class="required">*</span>
                    </label>
                    <select class="form-control" id="departmentId" name="departmentId" required>
                        <option value="">Sélectionnez un département...</option>
                        <%
                            List<Department> departments = (List<Department>) request.getAttribute("departments");
                            if(departments != null) {
                                for (Department d : departments) {
                        %>
                        <option value="<%=d.getId()%>"><%=d.getName()%> (<%=d.getCode()%>)</option>
                        <%
                                }
                            }
                        %>
                    </select>
                    <div class="form-help">Sélectionnez le département auquel appartient cette spécialité</div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        ✓ Créer la spécialité
                    </button>
                    <a href="<%=request.getContextPath()%>/admin/specialties" class="btn btn-secondary">
                        ✕ Annuler
                    </a>
                </div>
            </form>
        </div>
    </main>
</div>
</body>
</html>