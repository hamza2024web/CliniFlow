<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Choix de la date et du type de rendez-vous</title>
</head>
<body>
<h2>Choisissez la date et le type de rendez-vous</h2>
<form method="post" action="${pageContext.request.contextPath}/select-date-type">
    <input type="hidden" name="doctorId" value="${doctorId}" />
    <input type="hidden" name="specialtyId" value="${specialtyId}" />
    <label for="date">Date :</label>
    <input type="date" name="date" required /><br/>
    <label for="appointmentType">Type de rendez-vous :</label>
    <select name="appointmentType" required>
        <option value="CONSULTATION">Consultation</option>
        <option value="SPECIALIZED">Spécialisé</option>
        <option value="EMERGENCY">Urgence</option>
    </select>
    <button type="submit">Voir les créneaux</button>
</form>
</body>
</html>