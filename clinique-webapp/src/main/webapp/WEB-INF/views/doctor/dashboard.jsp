<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tableau de Bord - Docteur</title>
</head>
<body>
<h1>Tableau de Bord Docteur</h1>
<p>Bienvenue, Dr. <strong>${sessionScope.user.nom}</strong> !</p>
<p>Email : ${sessionScope.user.email}</p>
<p>Rôles : ${sessionScope.user.roles}</p>

<h2>Mes Actions</h2>
<ul>
    <li>Consulter mon agenda</li>
    <li>Gérer mes disponibilités</li>
    <li>Consulter mes rendez-vous</li>
    <li>Rédiger des notes médicales</li>
</ul>

<a href="${pageContext.request.contextPath}/logout">Se déconnecter</a>
</body>
</html>