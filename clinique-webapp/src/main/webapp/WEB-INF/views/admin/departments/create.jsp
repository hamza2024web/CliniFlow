<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head><title>Créer un Département</title></head>
<body>
<h1>Créer un Département</h1>
<% String error = (String)request.getAttribute("error"); if(error!=null){ %>
<div style="color:red;"><%=error%></div>
<% } %>
<form method="post">
    <label>Nom: <input type="text" name="name" required/></label><br/>
    <label>Code: <input type="text" name="code" required/></label><br/>
    <button type="submit">Créer</button>
</form>
<a href="<%=request.getContextPath()%>/admin/departments">Annuler</a>
</body>
</html>