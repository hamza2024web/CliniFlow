<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Choisir une spécialité</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            max-width: 600px;
            width: 100%;
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #4299e1 0%, #3182ce 100%);
            padding: 40px 30px;
            text-align: center;
            color: white;
        }

        .header h1 {
            font-size: 28px;
            margin-bottom: 10px;
        }

        .header p {
            font-size: 14px;
            opacity: 0.9;
        }

        .progress-bar {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
        }

        .progress-step {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.3);
        }

        .progress-step.active {
            background: white;
        }

        .content {
            padding: 40px 30px;
        }

        .form-group {
            margin-bottom: 30px;
        }

        .form-label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 12px;
        }

        .specialty-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
        }

        .specialty-card {
            position: relative;
        }

        .specialty-card input[type="radio"] {
            position: absolute;
            opacity: 0;
            width: 0;
            height: 0;
        }

        .specialty-label {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 25px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;
        }

        .specialty-card input[type="radio"]:checked + .specialty-label {
            border-color: #4299e1;
            background: #ebf8ff;
        }

        .specialty-label:hover {
            border-color: #4299e1;
            transform: translateY(-3px);
            box-shadow: 0 4px 12px rgba(66, 153, 225, 0.2);
        }

        .specialty-icon {
            font-size: 40px;
            margin-bottom: 10px;
        }

        .specialty-name {
            font-size: 14px;
            font-weight: 600;
            color: #2d3748;
        }

        .btn-container {
            display: flex;
            gap: 15px;
            margin-top: 30px;
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
            .specialty-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>🏥 Prendre rendez-vous</h1>
        <p>Étape 1 sur 4 : Choisissez une spécialité</p>
        <div class="progress-bar">
            <div class="progress-step active"></div>
            <div class="progress-step"></div>
            <div class="progress-step"></div>
            <div class="progress-step"></div>
        </div>
    </div>

    <div class="content">
        <form method="post" action="${pageContext.request.contextPath}/patient/appointment/book-appointment">
            <div class="form-group">
                <label class="form-label">Sélectionnez la spécialité médicale</label>
                <div class="specialty-grid">
                    <c:forEach var="specialty" items="${specialties}">
                        <div class="specialty-card">
                            <input type="radio" name="specialtyId" id="specialty_${specialty.id}" value="${specialty.id}" required>
                            <label for="specialty_${specialty.id}" class="specialty-label">
                                <span class="specialty-icon">🩺</span>
                                <span class="specialty-name">${specialty.name}</span>
                            </label>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <div class="btn-container">
                <a href="${pageContext.request.contextPath}/patient/dashboard" class="btn btn-secondary" style="text-decoration: none; text-align: center; line-height: 1.5;">Annuler</a>
                <button type="submit" class="btn btn-primary">Suivant →</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>