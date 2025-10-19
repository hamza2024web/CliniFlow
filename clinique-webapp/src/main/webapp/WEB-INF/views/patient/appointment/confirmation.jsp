<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirmation du rendez-vous</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f7fafc;
            min-height: 100vh;
            padding: 40px 20px;
        }

        .container {
            max-width: 700px;
            margin: 0 auto;
        }

        .success-header {
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
            padding: 50px 30px;
            border-radius: 12px;
            text-align: center;
            color: white;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(72, 187, 120, 0.3);
        }

        .error-header {
            background: linear-gradient(135deg, #f56565 0%, #e53e3e 100%);
            padding: 50px 30px;
            border-radius: 12px;
            text-align: center;
            color: white;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(245, 101, 101, 0.3);
        }

        .success-icon {
            font-size: 80px;
            margin-bottom: 20px;
            animation: scaleIn 0.5s ease-out;
        }

        @keyframes scaleIn {
            0% {
                transform: scale(0) rotate(-180deg);
            }
            50% {
                transform: scale(1.2) rotate(10deg);
            }
            100% {
                transform: scale(1) rotate(0deg);
            }
        }

        .success-header h2,
        .error-header h2 {
            font-size: 32px;
            margin-bottom: 10px;
        }

        .success-header p,
        .error-header p {
            font-size: 16px;
            opacity: 0.95;
        }

        .info-box {
            background: #ebf8ff;
            border-left: 4px solid #4299e1;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 25px;
        }

        .info-box p {
            font-size: 14px;
            color: #2d3748;
            line-height: 1.6;
        }

        .details-card {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            margin-bottom: 25px;
        }

        .detail-row {
            display: flex;
            align-items: center;
            padding: 18px 0;
            border-bottom: 1px solid #e2e8f0;
        }

        .detail-row:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }

        .detail-row:first-child {
            padding-top: 0;
        }

        .detail-icon {
            font-size: 28px;
            margin-right: 20px;
            width: 50px;
            text-align: center;
        }

        .detail-content {
            flex: 1;
        }

        .detail-label {
            font-size: 12px;
            color: #718096;
            text-transform: uppercase;
            font-weight: 600;
            margin-bottom: 5px;
            letter-spacing: 0.5px;
        }

        .detail-value {
            font-size: 17px;
            color: #2d3748;
            font-weight: 600;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        .status-badge.confirmed {
            background: #c6f6d5;
            color: #22543d;
        }

        .status-badge.pending {
            background: #feebc8;
            color: #7c2d12;
        }

        .btn-container {
            display: flex;
            gap: 15px;
        }

        .btn {
            flex: 1;
            padding: 16px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            text-align: center;
            display: inline-block;
        }

        .btn-primary {
            background: linear-gradient(135deg, #4299e1 0%, #3182ce 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(66, 153, 225, 0.4);
        }

        .btn-secondary {
            background: white;
            color: #2d3748;
            border: 2px solid #e2e8f0;
        }

        .btn-secondary:hover {
            background: #f7fafc;
            border-color: #cbd5e0;
        }

        .error-content {
            background: white;
            padding: 40px 30px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            text-align: center;
        }

        .error-content p {
            font-size: 16px;
            color: #718096;
            margin-bottom: 30px;
            line-height: 1.6;
        }

        @media (max-width: 600px) {
            .success-header,
            .error-header {
                padding: 40px 20px;
            }

            .details-card {
                padding: 20px;
            }

            .btn-container {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <c:choose>
        <c:when test="${not empty appointment}">
            <div class="success-header">
                <div class="success-icon">✓</div>
                <h2>Rendez-vous confirmé !</h2>
                <p>Votre rendez-vous a été réservé avec succès</p>
            </div>

            <div class="info-box">
                <p>💡 <strong>Important :</strong> Un email de confirmation vous a été envoyé. Veuillez vous présenter 10 minutes avant l'heure du rendez-vous avec votre carte d'identité et vos documents médicaux.</p>
            </div>

            <div class="details-card">
                <div class="detail-row">
                    <div class="detail-icon">👨‍⚕️</div>
                    <div class="detail-content">
                        <div class="detail-label">Médecin</div>
                        <div class="detail-value">
                            Dr. ${appointment.doctor.user.firstName} ${appointment.doctor.user.lastName}
                        </div>
                    </div>
                </div>

                <div class="detail-row">
                    <div class="detail-icon">📅</div>
                    <div class="detail-content">
                        <div class="detail-label">Date</div>
                        <div class="detail-value">
                            <fmt:formatDate value="${appointment.appointmentDateTime}" pattern="dd/MM/yyyy" />
                        </div>
                    </div>
                </div>

                <div class="detail-row">
                    <div class="detail-icon">⏰</div>
                    <div class="detail-content">
                        <div class="detail-label">Heure de début</div>
                        <div class="detail-value">
                            <fmt:formatDate value="${appointment.appointmentDateTime}" pattern="HH:mm" />
                        </div>
                    </div>
                </div>

                <div class="detail-row">
                    <div class="detail-icon">🏥</div>
                    <div class="detail-content">
                        <div class="detail-label">Type de consultation</div>
                        <div class="detail-value">
                            <c:choose>
                                <c:when test="${appointment.appointmentType == 'CONSULTATION'}">Consultation standard</c:when>
                                <c:when test="${appointment.appointmentType == 'SPECIALIZED'}">Consultation spécialisée</c:when>
                                <c:when test="${appointment.appointmentType == 'EMERGENCY'}">Urgence</c:when>
                                <c:otherwise>${appointment.appointmentType}</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <div class="detail-row">
                    <div class="detail-icon">📊</div>
                    <div class="detail-content">
                        <div class="detail-label">Statut</div>
                        <div class="detail-value">
                            <span class="status-badge confirmed">${appointment.status}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="btn-container">
                <a href="${pageContext.request.contextPath}/patient/appointment/appointments" class="btn btn-secondary">📋 Mes rendez-vous</a>
                <a href="${pageContext.request.contextPath}/patient/dashboard" class="btn btn-primary">🏠 Retour à l'accueil</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="error-header">
                <div class="success-icon">✗</div>
                <h2>Erreur de réservation</h2>
                <p>Impossible de traiter votre demande</p>
            </div>

            <div class="error-content">
                <p>Nous sommes désolés, une erreur s'est produite lors de la réservation de votre rendez-vous. Veuillez réessayer ou contacter notre service client si le problème persiste.</p>
                <div class="btn-container">
                    <a href="${pageContext.request.contextPath}/patient/appointment/book-appointment" class="btn btn-primary">🔄 Réessayer</a>
                    <a href="${pageContext.request.contextPath}/patient/dashboard" class="btn btn-secondary">🏠 Retour à l'accueil</a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>