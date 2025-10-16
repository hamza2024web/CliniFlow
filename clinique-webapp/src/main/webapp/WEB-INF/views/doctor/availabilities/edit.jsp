<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.clinique.domain.Availability" %>
<%@ page import="com.clinique.domain.Enum.DayOfWeek" %>
<!DOCTYPE html>
<html>
<head>
    <title>Modifier une disponibilité</title>
</head>
<body>
<h1>Modifier une disponibilité</h1>
<% String error = (String) request.getAttribute("error"); if (error != null) { %>
<div style="color:red;"><%=error%></div>
<% } %>
<% Availability a = (Availability) request.getAttribute("availability"); %>
<form method="post">
    <input type="hidden" name="id" value="<%=a.getId()%>"/>
    <label for="dayOfWeek">Jour :</label>
    <select name="dayOfWeek" id="dayOfWeek" required>
        <% for (DayOfWeek day : DayOfWeek.values()) { %>
        <option value="<%=day.name()%>" <%= a.getDayOfWeek() == day ? "selected" : "" %>><%=day.name()%></option>
        <% } %>
    </select><br/><br/>

    <label for="startTime">Heure de début :</label>
    <input type="time" id="startTime" name="startTime" value="<%=a.getStartTime()%>" required><br/><br/>

    <label for="endTime">Heure de fin :</label>
    <input type="time" id="endTime" name="endTime" value="<%=a.getEndTime()%>" required><br/><br/>

    <label for="active">Actif :</label>
    <input type="checkbox" id="active" name="active" <%= a.isActive() ? "checked" : "" %>><br/><br/>

    <button type="submit">Enregistrer</button>
    <a href="<%=request.getContextPath()%>/doctor/availabilities">Annuler</a>
</form>
</body>
</html>