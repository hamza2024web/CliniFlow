<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tableau de Bord - Patient</title>
</head>
<body>
<h1>Tableau de Bord Patient</h1>
<p>Bienvenue, <strong>${sessionScope.user.nom}</strong> !</p>
<p>Email : ${sessionScope.user.email}</p>
<p>Rôles : ${sessionScope.user.roles}</p>

<h2>Mes Actions</h2>
<ul>
    <li>Prendre rendez-vous</li>
    <li>Consulter mes rendez-vous</li>
    <li>Annuler un rendez-vous</li>
    <li>Consulter mon historique médical</li>
</ul>

<a href="${pageContext.request.contextPath}/logout">Se déconnecter</a>
</body>
</html>