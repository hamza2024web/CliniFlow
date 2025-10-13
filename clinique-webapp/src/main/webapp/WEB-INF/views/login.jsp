<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Connexion - Clinique Digitale</title>
</head>
<body>
<h1>Connexion</h1>

<c:if test="${not empty error}">
    <p style="color: red; font-weight: bold;">${error}</p>
</c:if>

<form method="post" action="${pageContext.request.contextPath}/login">
    <p>
        <label for="email">Email:</label><br/>
        <input type="email" id="email" name="email" required>
    </p>
    <p>
        <label for="password">Mot de passe:</label><br/>
        <input type="password" id="password" name="password" required>
    </p>
    <p>
        <input type="submit" value="Se connecter">
    </p>
</form>
</body>
</html>
