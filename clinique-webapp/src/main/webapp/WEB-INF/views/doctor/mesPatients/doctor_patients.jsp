<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes Patients - Docteur</title>
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
            margin-bottom: 10px;
        }

        .page-header p {
            color: #718096;
            font-size: 14px;
        }

        .search-bar {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            margin-bottom: 20px;
        }

        .search-input {
            width: 100%;
            padding: 12px 20px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s;
        }

        .search-input:focus {
            outline: none;
            border-color: #319795;
            box-shadow: 0 0 0 3px rgba(49, 151, 149, 0.1);
        }

        .patients-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }

        .patients-grid {
            display: grid;
            gap: 1px;
            background: #e2e8f0;
        }

        .patient-card {
            background: white;
            padding: 20px;
            display: grid;
            grid-template-columns: 60px 1fr;
            gap: 20px;
            align-items: center;
            transition: all 0.3s;
            cursor: pointer;
        }

        .patient-card:hover {
            background: #f0fdfa;
            transform: translateX(5px);
        }

        .patient-avatar {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #319795 0%, #2c7a7b 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            font-weight: 600;
        }

        .patient-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }

        .info-group {
            display: flex;
            flex-direction: column;
        }

        .info-label {
            font-size: 12px;
            color: #718096;
            text-transform: uppercase;
            font-weight: 600;
            margin-bottom: 4px;
        }

        .info-value {
            font-size: 14px;
            color: #2d3748;
            font-weight: 500;
        }

        .patient-header {
            background: #319795;
            color: white;
            padding: 15px 20px;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .no-patients {
            padding: 60px 20px;
            text-align: center;
            color: #718096;
        }

        .no-patients-icon {
            font-size: 64px;
            margin-bottom: 20px;
        }

        .no-patients-text {
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

            .patient-card {
                grid-template-columns: 1fr;
                text-align: center;
            }

            .patient-avatar {
                margin: 0 auto;
            }

            .patient-info {
                grid-template-columns: 1fr;
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
                <a href="${pageContext.request.contextPath}/doctor/agenda" class="nav-link">
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
                <a href="${pageContext.request.contextPath}/doctor/mes_patients" class="nav-link active">
                    <span class="nav-icon">👥</span>
                    Mes patients
                </a>
            </li>
            <li class="nav-item">
                <a href="<%= request.getContextPath() %>/doctor/medical-notes" class="nav-link">
                    <span class="nav-icon">📝</span>
                    Notes médicales
                </a>
            </li>
        </ul>

        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Se déconnecter</a>
    </aside>

    <main class="main-content">
        <div class="page-header">
            <h1>👥 Mes Patients</h1>
            <p>Liste complète de vos patients suivis</p>
        </div>

        <div class="search-bar">
            <input type="text"
                   class="search-input"
                   id="searchInput"
                   placeholder="🔍 Rechercher un patient par nom, prénom, CIN, email ou téléphone...">
        </div>

        <div class="patients-container">
            <c:choose>
                <c:when test="${not empty patients}">
                    <div class="patient-header">
                            ${patients.size()} patient(s) au total
                    </div>

                    <div class="patients-grid" id="patientsGrid">
                        <c:forEach var="patient" items="${patients}">
                            <div class="patient-card"
                                 data-patient='<c:out value="${patient.user.lastName} ${patient.user.firstName} ${patient.cin} ${patient.user.email} ${patient.phoneNumber}"/>'>
                                <div class="patient-avatar">
                                    <c:choose>
                                        <c:when test="${not empty patient.user.lastName}">
                                            ${patient.user.lastName.substring(0,1).toUpperCase()}
                                        </c:when>
                                        <c:otherwise>
                                            ?
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="patient-info">
                                    <div class="info-group">
                                        <span class="info-label">Nom & Prénom</span>
                                        <span class="info-value">
                                            <c:choose>
                                                <c:when test="${not empty patient.user}">
                                                    ${patient.user.lastName} ${patient.user.firstName}
                                                </c:when>
                                                <c:otherwise>
                                                    Non renseigné
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                    <div class="info-group">
                                        <span class="info-label">CIN</span>
                                        <span class="info-value">
                                            <c:choose>
                                                <c:when test="${not empty patient.cin}">
                                                    ${patient.cin}
                                                </c:when>
                                                <c:otherwise>
                                                    Non renseigné
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                    <div class="info-group">
                                        <span class="info-label">Email</span>
                                        <span class="info-value">
                                            <c:choose>
                                                <c:when test="${not empty patient.user.email}">
                                                    ${patient.user.email}
                                                </c:when>
                                                <c:otherwise>
                                                    Non renseigné
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                    <div class="info-group">
                                        <span class="info-label">Téléphone</span>
                                        <span class="info-value">
                                            <c:choose>
                                                <c:when test="${not empty patient.phone_number}">
                                                    ${patient.phone_number}
                                                </c:when>
                                                <c:otherwise>
                                                    Non renseigné
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                    <div class="info-group">
                                        <span class="info-label">Date de naissance</span>
                                        <span class="info-value">
                                            <c:choose>
                                                <c:when test="${not empty patient.user.birthDay}">
                                                    ${patient.user.birthDay}
                                                </c:when>
                                                <c:otherwise>
                                                    Non renseignée
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                    <div class="info-group">
                                        <span class="info-label">Adresse</span>
                                        <span class="info-value">
                                            <c:choose>
                                                <c:when test="${not empty patient.address}">
                                                    ${patient.address}
                                                </c:when>
                                                <c:otherwise>
                                                    Non renseignée
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-patients">
                        <div class="no-patients-icon">👤</div>
                        <p class="no-patients-text">Aucun patient trouvé</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
</div>

<script>
    const searchInput = document.getElementById('searchInput');
    const patientCards = document.querySelectorAll('.patient-card');

    if (searchInput && patientCards.length > 0) {
        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase().trim();

            patientCards.forEach(card => {
                const patientData = card.getAttribute('data-patient');
                if (patientData) {
                    if (patientData.toLowerCase().includes(searchTerm)) {
                        card.style.display = 'grid';
                    } else {
                        card.style.display = 'none';
                    }
                }
            });
        });
    }
</script>
</body>
</html>