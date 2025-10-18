<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Confirmation du rendez-vous</title>
</head>
<body>
<h2>Votre rendez-vous a été réservé !</h2>
<c:if test="${not empty appointment}">
    <p>Médecin : Dr. ${appointment.doctor.nom} ${appointment.doctor.prenom}</p>
    <p>Date : ${appointment.date}</p>
    <p>Heure de début : ${appointment.startTime}</p>
    <p>Type : ${appointment.type}</p>
    <p>Statut : ${appointment.status}</p>
</c:if>
<c:if test="${empty appointment}">
    <p>Erreur lors de la réservation. Veuillez réessayer.</p>
</c:if>
<a href="${pageContext.request.contextPath}/home">Retour accueil</a>
</body>
</html>