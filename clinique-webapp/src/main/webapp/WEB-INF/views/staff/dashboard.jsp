<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tableau de Bord - Personnel</title>
</head>
<body>
<h1>Tableau de Bord Personnel</h1>
<p>Bienvenue, <strong>${sessionScope.user.nom}</strong> !</p>
<p>Email : ${sessionScope.user.email}</p>
<p>Rôles : ${sessionScope.user.roles}</p>

<h2>Mes Actions</h2>
<ul>
    <li>Gérer les plannings</li>
    <li>Créer des rendez-vous pour les patients</li>
    <li>Gérer les listes d'attente</li>
    <li>Consulter les disponibilités des docteurs</li>
</ul>

<a href="${pageContext.request.contextPath}/logout">Se déconnecter</a>
</body>
</html>