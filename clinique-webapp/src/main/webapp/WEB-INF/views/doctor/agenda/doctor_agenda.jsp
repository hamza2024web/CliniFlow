<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            font-family: 'Inter', 'Segoe UI', system-ui, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e9f2 100%);
            color: #2d3748;
            min-height: 100vh;
        }

        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Améliorée */
        .sidebar {
            width: 280px;
            background: linear-gradient(180deg, #0f766e 0%, #115e59 100%);
            color: white;
            padding: 24px;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            box-shadow: 4px 0 20px rgba(0, 0, 0, 0.1);
        }

        .sidebar-header {
            padding: 24px 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.15);
            margin-bottom: 32px;
        }

        .sidebar-header h2 {
            font-size: 24px;
            font-weight: 700;
            letter-spacing: -0.5px;
            margin-bottom: 8px;
        }

        .sidebar-header .role-badge {
            display: inline-block;
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        .nav-menu {
            list-style: none;
        }

        .nav-item {
            margin-bottom: 6px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 14px 16px;
            color: rgba(255, 255, 255, 0.75);
            text-decoration: none;
            border-radius: 12px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-weight: 500;
            font-size: 15px;
        }

        .nav-link:hover {
            background: rgba(255, 255, 255, 0.12);
            color: white;
            transform: translateX(4px);
        }

        .nav-link.active {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .nav-icon {
            margin-right: 14px;
            font-size: 20px;
        }

        .logout-btn {
            position: absolute;
            bottom: 24px;
            left: 24px;
            right: 24px;
            padding: 14px;
            background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 12px;
            transition: all 0.3s;
            font-weight: 600;
            box-shadow: 0 4px 12px rgba(220, 38, 38, 0.3);
        }

        .logout-btn:hover {
            background: linear-gradient(135deg, #b91c1c 0%, #991b1b 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(220, 38, 38, 0.4);
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 40px;
        }

        /* Page Header avec Statistiques */
        .page-header {
            background: white;
            padding: 32px;
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            margin-bottom: 32px;
        }

        .header-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .header-title {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .header-icon {
            width: 56px;
            height: 56px;
            background: linear-gradient(135deg, #14b8a6 0%, #0f766e 100%);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            box-shadow: 0 4px 12px rgba(20, 184, 166, 0.3);
        }

        .page-header h1 {
            font-size: 32px;
            color: #1a202c;
            font-weight: 700;
            margin-bottom: 4px;
        }

        .page-header p {
            color: #718096;
            font-size: 15px;
        }

        /* Statistiques rapides */
        .quick-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 16px;
            margin-top: 24px;
            padding-top: 24px;
            border-top: 2px solid #f0f4f8;
        }

        .stat-card {
            padding: 16px;
            background: linear-gradient(135deg, #f0fdfa 0%, #e6fffa 100%);
            border-radius: 12px;
            border: 1px solid #99f6e4;
        }

        .stat-label {
            font-size: 12px;
            color: #0f766e;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
        }

        .stat-value {
            font-size: 28px;
            color: #0f766e;
            font-weight: 700;
        }

        /* Filtres améliorés */
        .filter-section {
            background: white;
            padding: 24px;
            border-radius: 20px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
            margin-bottom: 24px;
        }

        .filter-buttons {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .filter-btn {
            padding: 12px 24px;
            border: 2px solid #e2e8f0;
            background: white;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            position: relative;
        }

        .filter-btn:hover {
            border-color: #14b8a6;
            background: #f0fdfa;
            color: #0f766e;
            transform: translateY(-2px);
        }

        .filter-btn.active {
            background: linear-gradient(135deg, #14b8a6 0%, #0f766e 100%);
            border-color: #0f766e;
            color: white;
            box-shadow: 0 4px 12px rgba(20, 184, 166, 0.3);
        }

        .filter-btn .count {
            display: inline-block;
            margin-left: 8px;
            padding: 2px 8px;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 10px;
            font-size: 12px;
        }

        .filter-btn.active .count {
            background: rgba(255, 255, 255, 0.25);
        }

        /* Conteneur des rendez-vous par date */
        .appointments-container {
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        .date-section {
            background: white;
            border-radius: 20px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
            overflow: hidden;
            transition: all 0.3s;
        }

        .date-section:hover {
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
        }

        .date-header {
            background: linear-gradient(135deg, #0f766e 0%, #115e59 100%);
            color: white;
            padding: 20px 28px;
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .date-icon {
            width: 48px;
            height: 48px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
        }

        .date-info h3 {
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 4px;
        }

        .date-info p {
            font-size: 13px;
            opacity: 0.9;
        }

        .appointments-list {
            display: flex;
            flex-direction: column;
        }

        /* Carte de rendez-vous améliorée */
        .appointment-card {
            background: white;
            padding: 24px;
            display: grid;
            grid-template-columns: 100px 1fr auto;
            gap: 24px;
            align-items: center;
            transition: all 0.3s;
            border-bottom: 1px solid #f0f4f8;
        }

        .appointment-card:last-child {
            border-bottom: none;
        }

        .appointment-card:hover {
            background: linear-gradient(90deg, #f0fdfa 0%, white 100%);
            transform: translateX(8px);
        }

        .appointment-time {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 16px;
            background: linear-gradient(135deg, #f0fdfa 0%, #ccfbf1 100%);
            border-radius: 16px;
            border: 2px solid #5eead4;
            position: relative;
        }

        .appointment-time::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(135deg, #14b8a6, #0f766e);
            border-radius: 16px;
            z-index: -1;
            opacity: 0;
            transition: opacity 0.3s;
        }

        .appointment-card:hover .appointment-time::before {
            opacity: 1;
        }

        .time-hour {
            font-size: 28px;
            font-weight: 800;
            color: #0f766e;
            line-height: 1;
        }

        .time-period {
            font-size: 11px;
            color: #14b8a6;
            font-weight: 600;
            margin-top: 4px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .appointment-details {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .patient-name {
            font-size: 18px;
            font-weight: 700;
            color: #1a202c;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .patient-avatar-small {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #14b8a6 0%, #0f766e 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 16px;
            font-weight: 700;
            box-shadow: 0 4px 12px rgba(20, 184, 166, 0.3);
        }

        .appointment-info {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            color: #4a5568;
            background: #f7fafc;
            padding: 6px 12px;
            border-radius: 8px;
        }

        .info-icon {
            font-size: 16px;
        }

        .appointment-status {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 10px;
        }

        .status-badge {
            padding: 10px 20px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .status-badge.scheduled {
            background: linear-gradient(135deg, #6ee7b7 0%, #34d399 100%);
            color: #065f46;
        }

        .status-badge.completed {
            background: linear-gradient(135deg, #93c5fd 0%, #60a5fa 100%);
            color: #1e3a8a;
        }

        .status-badge.cancelled {
            background: linear-gradient(135deg, #fca5a5 0%, #f87171 100%);
            color: #7f1d1d;
        }

        .type-badge {
            padding: 8px 16px;
            border-radius: 10px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .type-badge.consultation {
            background: #e0f2fe;
            color: #075985;
            border: 1px solid #bae6fd;
        }

        .type-badge.specialized {
            background: #f3e8ff;
            color: #6b21a8;
            border: 1px solid #e9d5ff;
        }

        .type-badge.emergency {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }

        .no-appointments {
            padding: 80px 40px;
            text-align: center;
            color: #718096;
        }

        .no-appointments-icon {
            font-size: 80px;
            margin-bottom: 24px;
            opacity: 0.4;
        }

        .no-appointments-text {
            font-size: 20px;
            font-weight: 600;
            color: #4a5568;
        }

        /* Animation de chargement */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .date-section {
            animation: fadeIn 0.5s ease-out;
        }

        @media (max-width: 1024px) {
            .sidebar {
                width: 240px;
            }

            .main-content {
                margin-left: 240px;
                padding: 24px;
            }

            .appointment-card {
                grid-template-columns: 80px 1fr;
                gap: 16px;
            }

            .appointment-status {
                grid-column: 2;
                flex-direction: row;
                justify-content: flex-start;
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
                padding: 16px;
            }

            .page-header {
                padding: 24px;
            }

            .header-top {
                flex-direction: column;
                gap: 16px;
                align-items: flex-start;
            }

            .quick-stats {
                grid-template-columns: repeat(2, 1fr);
            }

            .filter-buttons {
                flex-direction: column;
            }

            .filter-btn {
                width: 100%;
            }

            .appointment-card {
                grid-template-columns: 1fr;
                text-align: center;
                gap: 16px;
            }

            .appointment-time {
                margin: 0 auto;
            }

            .appointment-details {
                align-items: center;
            }

            .patient-name {
                justify-content: center;
            }

            .appointment-info {
                justify-content: center;
            }

            .appointment-status {
                align-items: center;
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <aside class="sidebar">
        <div class="sidebar-header">
            <h2>Clinique Digitale</h2>
            <span class="role-badge">DOCTEUR</span>
        </div>

        <ul class="nav-menu">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/doctor/dashboard" class="nav-link">
                    <span class="nav-icon">📊</span>
                    Tableau de bord
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/doctor/agenda" class="nav-link active">
                    <span class="nav-icon">📅</span>
                    Mon agenda
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/doctor/availabilities" class="nav-link">
                    <span class="nav-icon">🕒</span>
                    Mes disponibilités
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/doctor/mes_patients" class="nav-link">
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

    <main class="main-content">
        <div class="page-header">
            <div class="header-top">
                <div class="header-title">
                    <div class="header-icon">📅</div>
                    <div>
                        <h1>Mon Agenda</h1>
                        <p>Gérez vos rendez-vous et consultations</p>
                    </div>
                </div>
            </div>

            <c:if test="${not empty appointments}">
                <div class="quick-stats">
                    <div class="stat-card">
                        <div class="stat-label">Total</div>
                        <div class="stat-value">${appointments.size()}</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-label">Programmés</div>
                        <div class="stat-value" id="scheduledCount">0</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-label">Terminés</div>
                        <div class="stat-value" id="completedCount">0</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-label">Annulés</div>
                        <div class="stat-value" id="cancelledCount">0</div>
                    </div>
                </div>
            </c:if>
        </div>

        <div class="filter-section">
            <div class="filter-buttons">
                <button class="filter-btn active" data-filter="all">
                    Tous <span class="count">${appointments.size()}</span>
                </button>
                <button class="filter-btn" data-filter="SCHEDULED">
                    Programmés <span class="count" id="scheduledFilterCount">0</span>
                </button>
                <button class="filter-btn" data-filter="COMPLETED">
                    Terminés <span class="count" id="completedFilterCount">0</span>
                </button>
                <button class="filter-btn" data-filter="CANCELLED">
                    Annulés <span class="count" id="cancelledFilterCount">0</span>
                </button>
            </div>
        </div>

        <c:choose>
            <c:when test="${not empty appointments}">
                <div class="appointments-container" id="appointmentsContainer">
                    <!-- Les rendez-vous seront groupés par date via JavaScript -->
                </div>
            </c:when>
            <c:otherwise>
                <div class="date-section">
                    <div class="no-appointments">
                        <div class="no-appointments-icon">📅</div>
                        <p class="no-appointments-text">Aucun rendez-vous trouvé</p>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </main>
</div>

<script>
    // Données des rendez-vous
    const appointments = [
        <c:forEach var="appointment" items="${appointments}" varStatus="status">
        {
            id: ${appointment.id},
            date: '<c:out value="${appointment.date}"/>',
            startTime: '<c:out value="${appointment.startDatetime}"/>',
            status: '${appointment.status}',
            type: '<c:out value="${appointment.type}"/>',
            patientName: '<c:out value="${appointment.patient.user.firstName} ${appointment.patient.user.lastName}"/>',
            patientInitial: '<c:out value="${appointment.patient.user.lastName.substring(0,1).toUpperCase()}"/>',
            patientEmail: '<c:out value="${appointment.patient.user.email}"/>',
            patientPhone: '<c:out value="${appointment.patient.phoneNumber}"/>'
        }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    // Compter les rendez-vous par statut
    const counts = {
        scheduled: 0,
        completed: 0,
        cancelled: 0
    };

    appointments.forEach(apt => {
        if (apt.status === 'SCHEDULED') counts.scheduled++;
        else if (apt.status === 'COMPLETED') counts.completed++;
        else if (apt.status === 'CANCELLED') counts.cancelled++;
    });

    // Mettre à jour les compteurs
    document.getElementById('scheduledCount').textContent = counts.scheduled;
    document.getElementById('completedCount').textContent = counts.completed;
    document.getElementById('cancelledCount').textContent = counts.cancelled;
    document.getElementById('scheduledFilterCount').textContent = counts.scheduled;
    document.getElementById('completedFilterCount').textContent = counts.completed;
    document.getElementById('cancelledFilterCount').textContent = counts.cancelled;

    // Grouper les rendez-vous par date
    function groupByDate(appointments) {
        const grouped = {};
        appointments.forEach(apt => {
            if (!grouped[apt.date]) {
                grouped[apt.date] = [];
            }
            grouped[apt.date].push(apt);
        });
        return grouped;
    }

    // Formater la date
    function formatDate(dateStr) {
        if (!dateStr || dateStr === '--/--/----') return { full: 'Date non définie', day: '--', short: 'Non définie' };

        const parts = dateStr.split(/[-\/]/);
        if (parts.length !== 3) return { full: dateStr, day: '--', short: dateStr };

        const date = new Date(parts[0], parts[1] - 1, parts[2]);
        const days = ['Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'];
        const months = ['janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'];

        return {
            full: `${days[date.getDay()]} ${date.getDate()} ${months[date.getMonth()]} ${date.getFullYear()}`,
            day: date.getDate().toString().padStart(2, '0'),
            short: `${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear()}`
        };
    }

    // Obtenir la période de la journée
    function getTimePeriod(timeStr) {
        if (!timeStr || timeStr === '--:--') return '';
        const hour = parseInt(timeStr.split(':')[0]);
        if (hour < 12) return 'Matin';
        if (hour < 18) return 'Après-midi';
        return 'Soir';
    }

    // Obtenir le label du statut en français
    function getStatusLabel(status) {
        const labels = {
            'SCHEDULED': 'Programmé',
            'COMPLETED': 'Terminé',
            'CANCELLED': 'Annulé'
        };
        return labels[status] || status;
    }

    // Obtenir le label du type en français
    function getTypeLabel(type) {
        const labels = {
            'CONSULTATION': 'Consultation',
            'SPECIALIZED': 'Spécialisée',
            'EMERGENCY': 'Urgence'
        };
        return labels[type] || type;
    }

    // Afficher les rendez-vous
    function displayAppointments(filteredAppointments) {
        const container = document.getElementById('appointmentsContainer');
        if (!container) return;

        container.innerHTML = '';

        const grouped = groupByDate(filteredAppointments);
        const sortedDates = Object.keys(grouped).sort();

        if (sortedDates.length === 0) {
            container.innerHTML = `
                <div class="date-section">
                    <div class="no-appointments">
                        <div class="no-appointments-icon">📅</div>
                        <p class="no-appointments-text">Aucun rendez-vous trouvé</p>
                    </div>
                </div>
            `;
            return;
        }

        sortedDates.forEach(date => {
            const dateInfo = formatDate(date);
            const dayAppointments = grouped[date];

            const dateSection = document.createElement('div');
            dateSection.className = 'date-section';

            dateSection.innerHTML = `
                <div class="date-header">
                    <div class="date-icon">${dateInfo.day}</div>
                    <div class="date-info">
                        <h3>${dateInfo.full}</h3>
                        <p>${dayAppointments.length} rendez-vous programmé${dayAppointments.length > 1 ? 's' : ''}</p>
                    </div>
                </div>
                <div class="appointments-list">
                    ${dayAppointments.map(apt => `
                        <div class="appointment-card" data-status="${apt.status}">
                            <div class="appointment-time">
                                <div class="time-hour">${apt.startTime || '--:--'}</div>
                                <div class="time-period">${getTimePeriod(apt.startTime)}</div>
                            </div>

                            <div class="appointment-details">
                                <div class="patient-name">
                                    <div class="patient-avatar-small">${apt.patientInitial || '?'}</div>
                                    <span>${apt.patientName || 'Patient inconnu'}</span>
                                </div>
                                <div class="appointment-info">
                                    ${apt.patientEmail ? `
                                        <div class="info-item">
                                            <span class="info-icon">📧</span>
                                            ${apt.patientEmail}
                                        </div>
                                    ` : ''}
                                    ${apt.patientPhone ? `
                                        <div class="info-item">
                                            <span class="info-icon">📱</span>
                                            ${apt.patientPhone}
                                        </div>
                                    ` : ''}
                                    ${apt.type ? `
                                        <span class="type-badge ${apt.type.toLowerCase()}">
                                            ${getTypeLabel(apt.type)}
                                        </span>
                                    ` : ''}
                                </div>
                            </div>

                            <div class="appointment-status">
                                <span class="status-badge ${apt.status.toLowerCase()}">
                                    ${getStatusLabel(apt.status)}
                                </span>
                            </div>
                        </div>
                    `).join('')}
                </div>
            `;

            container.appendChild(dateSection);
        });
    }

    // Filtrer les rendez-vous
    const filterButtons = document.querySelectorAll('.filter-btn');

    filterButtons.forEach(button => {
        button.addEventListener('click', function() {
            filterButtons.forEach(btn => btn.classList.remove('active'));
            this.classList.add('active');

            const filterValue = this.getAttribute('data-filter');

            let filtered = appointments;
            if (filterValue !== 'all') {
                filtered = appointments.filter(apt => apt.status === filterValue);
            }

            displayAppointments(filtered);
        });
    });

    displayAppointments(appointments);
</script>