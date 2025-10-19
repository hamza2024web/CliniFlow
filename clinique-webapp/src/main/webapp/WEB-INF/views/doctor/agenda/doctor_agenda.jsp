<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon Agenda - Docteur</title>
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
            background: linear-gradient(180deg, #319795 0%, #2c7a7b 100%);
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
            background: #38b2ac;
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
            margin-bottom: 10px;
        }

        .page-header p {
            color: #718096;
            font-size: 14px;
        }

        .filter-buttons {
            display: flex;
            gap: 10px;
        }

        .filter-btn {
            padding: 10px 20px;
            border: 2px solid #e2e8f0;
            background: white;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .filter-btn:hover,
        .filter-btn.active {
            border-color: #319795;
            background: #f0fdfa;
            color: #319795;
        }

        .appointments-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }

        .appointments-header {
            background: #319795;
            color: white;
            padding: 15px 20px;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .appointments-list {
            display: flex;
            flex-direction: column;
            gap: 1px;
            background: #e2e8f0;
        }

        .appointment-card {
            background: white;
            padding: 25px;
            display: grid;
            grid-template-columns: 80px 1fr auto;
            gap: 25px;
            align-items: center;
            transition: all 0.3s;
        }

        .appointment-card:hover {
            background: #f0fdfa;
            transform: translateX(5px);
        }

        .appointment-time {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 15px;
            background: #f0fdfa;
            border-radius: 10px;
            border: 2px solid #319795;
        }

        .time-hour {
            font-size: 24px;
            font-weight: 700;
            color: #319795;
        }

        .time-date {
            font-size: 12px;
            color: #718096;
            margin-top: 5px;
        }

        .appointment-details {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .patient-name {
            font-size: 18px;
            font-weight: 600;
            color: #2d3748;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .patient-avatar-small {
            width: 35px;
            height: 35px;
            background: linear-gradient(135deg, #319795 0%, #2c7a7b 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 14px;
            font-weight: 600;
        }

        .appointment-info {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 13px;
            color: #718096;
        }

        .info-icon {
            font-size: 16px;
        }

        .appointment-status {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .status-badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-badge.confirmed {
            background: #c6f6d5;
            color: #22543d;
        }

        .status-badge.pending {
            background: #feebc8;
            color: #7c2d12;
        }

        .status-badge.completed {
            background: #bee3f8;
            color: #2c5282;
        }

        .status-badge.cancelled {
            background: #fed7d7;
            color: #742a2a;
        }

        .type-badge {
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .type-badge.consultation {
            background: #e6fffa;
            color: #319795;
        }

        .type-badge.specialized {
            background: #faf5ff;
            color: #805ad5;
        }

        .type-badge.emergency {
            background: #fff5f5;
            color: #e53e3e;
        }

        .no-appointments {
            padding: 60px 20px;
            text-align: center;
            color: #718096;
        }

        .no-appointments-icon {
            font-size: 64px;
            margin-bottom: 20px;
        }

        .no-appointments-text {
            font-size: 18px;
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
                align-items: flex-start;
                gap: 20px;
            }

            .appointment-card {
                grid-template-columns: 1fr;
                text-align: center;
                gap: 15px;
            }

            .appointment-time {
                margin: 0 auto;
            }

            .appointment-status {
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
            <span class="role-badge">DOCTEUR</span>
        </div>

        <ul class="nav-menu">
            <li class="nav-item">
                <a href="<%= request.getContextPath() %>/doctor/dashboard" class="nav-link">
                    <span class="nav-icon">📊</span>
                    Tableau de bord
                </a>
            </li>
            <li class="nav-item">
                <a href="<%= request.getContextPath() %>/doctor/agenda" class="nav-link active">
                    <span class="nav-icon">📅</span>
                    Mon agenda
                </a>
            </li>
            <li class="nav-item">
                <a href="<%= request.getContextPath() %>/doctor/availabilities" class="nav-link">
                    <span class="nav-icon">🕒</span>
                    Mes disponibilités
                </a>
            </li>
            <li class="nav-item">
                <a href="<%= request.getContextPath() %>/doctor/mes_patients" class="nav-link">
                    <span class="nav-icon">👥</span>
                    Mes patients
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">
                    <span class="nav-icon">📝</span>
                    Notes médicales
                </a>
            </li>
        </ul>

        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Se déconnecter</a>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <div class="page-header">
            <div>
                <h1>📅 Mon Agenda</h1>
                <p>Gérez vos rendez-vous et consultations</p>
            </div>
            <div class="filter-buttons">
                <button class="filter-btn active" data-filter="all">Tous</button>
                <button class="filter-btn" data-filter="CONFIRMED">Confirmés</button>
                <button class="filter-btn" data-filter="PENDING">En attente</button>
                <button class="filter-btn" data-filter="COMPLETED">Terminés</button>
            </div>
        </div>

        <div class="appointments-container">
            <div class="appointments-header">
                ${appointments.size()} rendez-vous au total
            </div>

            <c:choose>
                <c:when test="${not empty appointments}">
                    <div class="appointments-list">
                        <c:forEach var="appointment" items="${appointments}">
                            <div class="appointment-card" data-status="${appointment.status}">
                                <div class="appointment-time">
                                    <div class="time-hour">${appointment.startDatetime}</div>
                                    <div class="time-date">${appointment.date}</div>
                                </div>

                                <div class="appointment-details">
                                    <div class="patient-name">
                                        <div class="patient-avatar-small">${appointment.patient.last_name.substring(0,1)}</div>
                                            ${appointment.patient.user.last_name} ${appointment.patient.user.first_name}
                                    </div>
                                    <div class="appointment-info">
                                        <div class="info-item">
                                            <span class="info-icon">📧</span>
                                                ${appointment.patient.email}
                                        </div>
                                        <div class="info-item">
                                            <span class="info-icon">📱</span>
                                                ${appointment.patient.phone_number}
                                        </div>
                                        <div class="info-item">
                                            <span class="type-badge ${appointment.type.toString().toLowerCase()}">
                                                    ${appointment.type}
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <div class="appointment-status">
                                    <span class="status-badge ${appointment.status.toString().toLowerCase()}">
                                            ${appointment.status}
                                    </span>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-appointments">
                        <div class="no-appointments-icon">📅</div>
                        <p class="no-appointments-text">Aucun rendez-vous trouvé</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
</div>

<script>
    const filterButtons = document.querySelectorAll('.filter-btn');
    const appointmentCards = document.querySelectorAll('.appointment-card');

    filterButtons.forEach(button => {
        button.addEventListener('click', function() {
            filterButtons.forEach(btn => btn.classList.remove('active'));
            this.classList.add('active');

            const filterValue = this.getAttribute('data-filter');

            appointmentCards.forEach(card => {
                if (filterValue === 'all' || card.getAttribute('data-status') === filterValue) {
                    card.style.display = 'grid';
                } else {
                    card.style.display = 'none';
                }
            });
        });
    });
</script>
</body>
</html>