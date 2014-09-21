<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Vrije Basisschool De Kleine Prins - Kluizen</title>
    <link rel="stylesheet" href="<c:url value='/css/styles.css' />" type="text/css"/>
</head>
<body>
<jsp:include page="/WEB-INF/NavBar.jsp"></jsp:include>
<style type="text/css">
    body {
        padding-top: 60px;
        padding-bottom: 40px;
    }
</style>
<div class="container">
    <div class="jumbotron text-center">
        Vrije Basisschool "De Kleine Prins" Kluizen</br>
        WEB Toepassingen
    </div>
</div>
<script src="<c:url value='/js/jquery.min.js' />"></script>
<script src="<c:url value='/js/bootstrap.min.js' />"></script>
</body>
</html>