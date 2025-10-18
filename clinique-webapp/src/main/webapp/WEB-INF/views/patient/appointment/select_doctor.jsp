<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sélection du médecin</title>
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
            max-width: 800px;
            margin: 0 auto;
        }

        .page-header {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
        }

        .page-header h2 {
            font-size: 28px;
            color: #2d3748;
            margin-bottom: 10px;
        }

        .specialty-badge {
            display: inline-block;
            background: linear-gradient(135deg, #4299e1 0%, #3182ce 100%);
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
        }

        .form-container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .form-label {
            display: block;
            font-size: 16px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 15px;
        }

        .doctor-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin-bottom: 30px;
        }

        .doctor-card {
            position: relative;
        }

        .doctor-card input[type="radio"] {
            position: absolute;
            opacity: 0;
            width: 0;
            height: 0;
        }

        .doctor-label {
            display: flex;
            align-items: center;
            padding: 20px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .doctor-card input[type="radio"]:checked + .doctor-label {
            border-color: #4299e1;
            background: #ebf8ff;
        }

        .doctor-label:hover {
            border-color: #4299e1;
            transform: translateX(5px);
            box-shadow: 0 4px 12px rgba(66, 153, 225, 0.2);
        }

        .doctor-avatar {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #4299e1 0%, #3182ce 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            font-weight: 600;
            margin-right: 20px;
            flex-shrink: 0;
        }

        .doctor-info h3 {
            font-size: 18px;
            color: #2d3748;
            margin-bottom: 5px;
        }

        .doctor-info p {
            font-size: 14px;
            color: #718096;
        }

        .btn-container {
            display: flex;
            gap: 15px;
        }

        .btn {
            flex: 1;
            padding: 15px;
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
            background: #f7fafc;
            color: #2d3748;
            border: 2px solid #e2e8f0;
        }

        .btn-secondary:hover {
            background: #edf2f7;
        }

        @media (max-width: 600px) {
            .page-header {
                padding: 20px;
            }

            .form-container {
                padding: 20px;
            }

            .doctor-avatar {
                width: 50px;
                height: 50px;
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="page-header">
        <h2>👨‍⚕️ Choisissez votre médecin</h2>
        <span class="specialty-badge">${specialty.nom}</span>
    </div>

    <div class="form-container">
        <form method="post" action="${pageContext.request.contextPath}/select-doctor">
            <input type="hidden" name="specialtyId" value="${specialtyId}" />

            <label class="form-label">Sélectionnez un médecin disponible</label>
            <div class="doctor-list">
                <c:forEach var="doctor" items="${doctors}">
                    <div class="doctor-card">
                        <input type="radio" name="doctorId" id="doctor_${doctor.id}" value="${doctor.id}" required>
                        <label for="doctor_${doctor.id}" class="doctor-label">
                            <div class="doctor-avatar">${doctor.nom.substring(0,1)}</div>
                            <div class="doctor-info">
                                <h3>Dr. ${doctor.nom} ${doctor.prenom}</h3>
                                <p>${specialty.nom}</p>
                            </div>
                        </label>
                    </div>
                </c:forEach>
            </div>

            <div class="btn-container">
                <button type="button" onclick="history.back()" class="btn btn-secondary">← Retour</button>
                <button type="submit" class="btn btn-primary">Suivant →</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>