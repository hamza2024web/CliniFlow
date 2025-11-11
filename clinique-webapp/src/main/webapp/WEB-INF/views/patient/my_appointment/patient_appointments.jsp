<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes Rendez-vous - Patient</title>
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

        /* Sidebar */
        .sidebar {
            width: 260px;
            background: linear-gradient(180deg, #4299e1 0%, #3182ce 100%);
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
            background: #63b3ed;
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

        /* Main Content */
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

        .page-header h1 .icon {
            font-size: 32px;
        }

        .btn-new-appointment {
            padding: 12px 24px;
            background: linear-gradient(135deg, #4299e1 0%, #3182ce 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
        }

        .btn-new-appointment:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(66, 153, 225, 0.4);
        }

        /* Filter Tabs */
        .filter-tabs {
            background: white;
            padding: 20px 30px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            margin-bottom: 25px;
            display: flex;
            gap: 12px;
        }

        .filter-tab {
            padding: 10px 20px;
            border: 2px solid #e2e8f0;
            background: white;
            color: #718096;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .filter-tab:hover {
            border-color: #4299e1;
            color: #4299e1;
        }

        .filter-tab.active {
            background: #4299e1;
            border-color: #4299e1;
            color: white;
        }

        /* Appointments List */
        .appointments-container {
            display: grid;
            gap: 20px;
        }

        .appointment-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            transition: all 0.3s;
        }

        .appointment-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
        }

        .appointment-card-header {
            padding: 20px 25px;
            border-left: 5px solid #4299e1;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: linear-gradient(90deg, #ebf8ff 0%, white 100%);
        }

        .appointment-card-header.upcoming {
            border-left-color: #4299e1;
            background: linear-gradient(90deg, #ebf8ff 0%, white 100%);
        }

        .appointment-card-header.completed {
            border-left-color: #38a169;
            background: linear-gradient(90deg, #f0fff4 0%, white 100%);
        }

        .appointment-card-header.cancelled {
            border-left-color: #e53e3e;
            background: linear-gradient(90deg, #fff5f5 0%, white 100%);
        }

        .doctor-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .doctor-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #4299e1 0%, #3182ce 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            font-weight: 600;
        }

        .doctor-details h3 {
            font-size: 18px;
            color: #2d3748;
            margin-bottom: 4px;
        }

        .doctor-details p {
            font-size: 14px;
            color: #718096;
        }

        .status-badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-badge.scheduled {
            background: #ebf8ff;
            color: #2c5282;
        }

        .status-badge.completed {
            background: #c6f6d5;
            color: #22543d;
        }

        .status-badge.cancelled {
            background: #fed7d7;
            color: #742a2a;
        }

        .appointment-card-body {
            padding: 25px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .info-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: #f7fafc;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }

        .info-content h4 {
            font-size: 12px;
            color: #718096;
            margin-bottom: 4px;
            font-weight: 500;
            text-transform: uppercase;
        }

        .info-content p {
            font-size: 15px;
            color: #2d3748;
            font-weight: 600;
        }

        .appointment-card-footer {
            padding: 20px 25px;
            background: #f7fafc;
            display: flex;
            justify-content: flex-end;
            gap: 12px;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-cancel {
            background: #fff5f5;
            color: #e53e3e;
            border: 2px solid #fed7d7;
        }

        .btn-cancel:hover {
            background: #e53e3e;
            color: white;
            border-color: #e53e3e;
        }

        .btn-details {
            background: white;
            color: #4299e1;
            border: 2px solid #4299e1;
        }

        .btn-details:hover {
            background: #4299e1;
            color: white;
        }

        /* Empty State */
        .empty-state {
            background: white;
            padding: 60px 30px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            text-align: center;
        }

        .empty-state .empty-icon {
            font-size: 80px;
            margin-bottom: 20px;
            opacity: 0.3;
        }

        .empty-state h3 {
            font-size: 22px;
            color: #2d3748;
            margin-bottom: 10px;
        }

        .empty-state p {
            font-size: 15px;
            color: #718096;
            margin-bottom: 25px;
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

            .filter-tabs {
                flex-wrap: wrap;
            }

            .appointment-card-body {
                grid-template-columns: 1fr;
            }

            .appointment-card-footer {
                flex-direction: column;
            }

            .btn {
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
            <span class="role-badge">PATIENT</span>
        </div>

        <ul class="nav-menu">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/patient/dashboard" class="nav-link">
                    <span class="nav-icon">📊</span>
                    Tableau de bord
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/patient/appointment/book-appointment" class="nav-link">
                    <span class="nav-icon">📅</span>
                    Prendre rendez-vous
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/patient/mes_rendez_vous" class="nav-link active">
                    <span class="nav-icon">📋</span>
                    Mes rendez-vous
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">
                    <span class="nav-icon">📖</span>
                    Historique médical
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">
                    <span class="nav-icon">⚙️</span>
                    Mon profil
                </a>
            </li>
        </ul>

        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Se déconnecter</a>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Page Header -->
        <div class="page-header">
            <h1>
                <span class="icon">📋</span>
                Mes Rendez-vous
            </h1>
            <a href="${pageContext.request.contextPath}/patient/appointment/book-appointment" class="btn-new-appointment">
                <span>➕</span>
                Nouveau rendez-vous
            </a>
        </div>

        <!-- Filter Tabs -->
        <div class="filter-tabs">
            <button class="filter-tab active">Tous</button>
            <button class="filter-tab">À venir</button>
            <button class="filter-tab">Terminés</button>
            <button class="filter-tab">Annulés</button>
        </div>

        <!-- Appointments List -->
        <div class="appointments-container">
            <c:choose>
                <c:when test="${not empty appointments}">
                    <c:forEach var="apt" items="${appointments}">
                        <div class="appointment-card">
                            <div class="appointment-card-header ${apt.status == 'SCHEDULED' ? 'upcoming' : (apt.status == 'COMPLETED' ? 'completed' : 'cancelled')}">
                                <div class="doctor-info">
                                    <div class="doctor-avatar">${apt.doctorInitial}</div>
                                    <div class="doctor-details">
                                        <h3>Dr. ${apt.doctorFirstName} ${apt.doctorLastName}</h3>
                                        <p>Médecin spécialisé en ${apt.specialty}</p>
                                    </div>
                                </div>
                                <span class="status-badge ${apt.status == 'SCHEDULED' ? 'scheduled' : (apt.status == 'COMPLETED' ? 'completed' : 'cancelled')}">
                                        ${apt.status}
                                </span>
                            </div>

                            <div class="appointment-card-body">
                                <div class="info-item">
                                    <div class="info-icon">📅</div>
                                    <div class="info-content">
                                        <h4>Date</h4>
                                        <p>${apt.formattedDate}</p>
                                    </div>
                                </div>

                                <div class="info-item">
                                    <div class="info-icon">⏰</div>
                                    <div class="info-content">
                                        <h4>Horaire</h4>
                                        <p>${apt.formattedStartTime} - ${apt.formattedEndTime}</p>
                                    </div>
                                </div>

                                <div class="info-item">
                                    <div class="info-icon">🏥</div>
                                    <div class="info-content">
                                        <h4>Type</h4>
                                        <p>${apt.typeLabel}</p>
                                    </div>
                                </div>
                            </div>

                            <div class="appointment-card-footer">
                                <button class="btn btn-details">
                                    <span>👁️</span>
                                    Détails
                                </button>
                                <c:if test="${apt.status == 'SCHEDULED'}">
                                    <form method="post" action="${pageContext.request.contextPath}/patient/annuler-rdv" style="display: inline;">
                                        <input type="hidden" name="appointmentId" value="${apt.id}" />
                                        <button type="submit" class="btn btn-cancel" onclick="return confirm('Êtes-vous sûr de vouloir annuler ce rendez-vous ?')">
                                            <span>✗</span>
                                            Annuler
                                        </button>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-icon">📋</div>
                        <h3>Aucun rendez-vous trouvé</h3>
                        <p>Vous n'avez pas encore de rendez-vous programmé.</p>
                        <a href="${pageContext.request.contextPath}/patient/appointment/book-appointment" class="btn-new-appointment">
                            <span>➕</span>
                            Prendre rendez-vous
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
</div>

<script>
    // Filter functionality
    const filterTabs = document.querySelectorAll('.filter-tab');
    filterTabs.forEach(tab => {
        tab.addEventListener('click', function() {
            filterTabs.forEach(t => t.classList.remove('active'));
            this.classList.add('active');
        });
    });
</script>
</body>
</html>