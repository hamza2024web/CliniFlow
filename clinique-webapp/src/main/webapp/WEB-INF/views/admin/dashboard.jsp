<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tableau de Bord - Administrateur</title>
</head>
<body>
<h1>Tableau de Bord Administrateur</h1>
<p>Bienvenue, <strong>${sessionScope.user.nom}</strong> !</p>
<p>Email : ${sessionScope.user.email}</p>
<p>Rôles : ${sessionScope.user.roles}</p>

<h2>Actions Administrateur</h2>
<ul>
    <li>Gestion des utilisateurs</li>
    <li>Gestion des départements et spécialités</li>
    <li>Configuration système</li>
    <li>Statistiques globales</li>
</ul>

<a href="${pageContext.request.contextPath}/logout">Se déconnecter</a>
</body>
</html>