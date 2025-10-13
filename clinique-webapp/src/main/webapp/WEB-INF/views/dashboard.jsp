<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tableau de Bord</title>
</head>
<body>
<h1>Bienvenue sur votre tableau de bord, ${sessionScope.user.nom} !</h1>
<p>Votre email : ${sessionScope.user.email}</p>
<p>Vos rôles : ${sessionScope.user.roles}</p>

<a href="${pageContext.request.contextPath}/logout">Se déconnecter</a>
</body>
</html>