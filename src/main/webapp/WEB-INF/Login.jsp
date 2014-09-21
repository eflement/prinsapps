<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="<c:url value='/css/styles.css'/>">
    <title>Kalender - Login</title>
</head>
<body>
<div class="container">

    <!-- navigatie menu tonen -->
    <jsp:include page="NavBar.jsp"></jsp:include>
    <style type="text/css">
        body {
            padding-top: 60px;
            padding-bottom: 40px;
        }
    </style>

    <br> <br>
    <div class="well well-sm ">
        <form action="login" method="post">
            <table style="width: 100%">
                <tr>
                    <td style="text-align: right">Gebruikersnaam:</td>
                    <td><input type="text" name="prinsAppsUser"></td>
                </tr>
                <tr>
                    <td style="text-align: right">Wachtwoord:</td>
                    <td><input type="password" name="prinsAppsPassword"></td>
                    <input type="hidden" name="application" value="${param.app}">
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <br> <br>
                        <input type="submit" value="Login">
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
<script src="<c:url value='/js/jquery.min.js' />"></script>
<script src="<c:url value='/js/bootstrap.min.js' />"></script>
</body>
</html>