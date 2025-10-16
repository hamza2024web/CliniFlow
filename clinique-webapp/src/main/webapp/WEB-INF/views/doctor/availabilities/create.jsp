<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.clinique.domain.Enum.DayOfWeek" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ajouter une disponibilité</title>
</head>
<body>
<h1>Ajouter une disponibilité</h1>
<% String error = (String) request.getAttribute("error"); if (error != null) { %>
<div style="color:red;"><%=error%></div>
<% } %>

<form method="post">
    <label for="dayOfWeek">Jour :</label>
    <select name="dayOfWeek" id="dayOfWeek" required>
        <option value="">Sélectionnez...</option>
        <% for (DayOfWeek day : DayOfWeek.values()) { %>
        <option value="<%=day.name()%>"><%=day.name()%></option>
        <% } %>
    </select><br/><br/>

    <label for="startTime">Heure de début :</label>
    <input type="time" id="startTime" name="startTime" required><br/><br/>

    <label for="endTime">Heure de fin :</label>
    <input type="time" id="endTime" name="endTime" required><br/><br/>

    <button type="submit">Ajouter</button>
    <a href="<%=request.getContextPath()%>/doctor/availabilities">Annuler</a>
</form>
</body>
</html>