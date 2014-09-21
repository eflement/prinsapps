<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="<c:url value='/css/styles.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/font-awesome.min.css'/>">
    <title>Agenda invullen</title>
    <%--<script>--%>
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


    <!-- start rij met maand en jaar navigatie -->
    <div class="row">
        <table class="table">
            <col style="width:33%">
            <col style="width:33%">
            <col style="width:33%">
            <tbody>
            <tr>
                <td>
                    <div class="btn-group">
                        <button class="btn btn-sm btn-warning dropdown-toggle" type="button" data-toggle="dropdown">
                            ${maandenVanHetJaar[requestScope.month - 1]}&nbsp;&nbsp;<span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" style="font-size: 12px">
                            <li><a href="<c:url value='/getmonth?action=edit&year=${year}&month=1'/>">januari</a>
                            </li>
                            <li><a href="<c:url value='/getmonth?action=edit&year=${year}&month=2'/>">februari</a>
                            </li>
                            <li><a href="<c:url value='/getmonth?action=edit&year=${year}&month=3'/>">maart</a></li>
                            <li><a href="<c:url value='/getmonth?action=edit&year=${year}&month=4'/>">april</a></li>
                            <li><a href="<c:url value='/getmonth?action=edit&year=${year}&month=5'/>">mei</a></li>
                            <li><a href="<c:url value='/getmonth?action=edit&year=${year}&month=6'/>">juni</a></li>
                            <li><a href="<c:url value='/getmonth?action=edit&year=${year}&month=7'/>">juli</a></li>
                            <li><a href="<c:url value='/getmonth?action=edit&year=${year}&month=8'/>">augustus</a>
                            </li>
                            <li><a href="<c:url value='/getmonth?action=edit&year=${year}&month=9'/>">september</a>
                            </li>
                            <li><a href="<c:url value='/getmonth?action=edit&year=${year}&month=10'/>">oktober</a>
                            </li>
                            <li><a href="<c:url value='/getmonth?action=edit&year=${year}&month=11'/>">november</a>
                            </li>
                            <li><a href="<c:url value='/getmonth?action=edit&year=${year}&month=12'/>">december</a>
                            </li>
                        </ul>
                    </div>
                </td>
                <td>
                    <h4 class="text-center">${maandenVanHetJaar[requestScope.month - 1]} ${year}</h4>
                </td>
                <td>
                    <div class="btn-group pull-right ">
                        <button class="btn btn-sm btn-info dropdown-toggle" type="button" data-toggle="dropdown">
                            ${year}&nbsp;&nbsp;<span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" style="font-size: 12px">
                            <li>
                                <a href="<c:url value='/getmonth?action=edit&year=${year - 2}&month=${month}'/>">${year - 2}</a>
                            </li>
                            <li>
                                <a href="<c:url value='/getmonth?action=edit&year=${year - 1}&month=${month}'/>">${year - 1}</a>
                            </li>
                            <li>
                                <a href="<c:url value='/getmonth?action=edit&year=${year}&month=${month}'/>">${year}</a>
                            </li>
                            <li>
                                <a href="<c:url value='/getmonth?action=edit&year=${year + 1}&month=${month}'/>">${year + 1}</a>
                            </li>
                            <li>
                                <a href="<c:url value='/updatemonth?action=edit&year=${year + 2}&month=${month}'/>">${year + 2}</a>
                            </li>
                        </ul>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
    <!-- end rij met maand en jaar navigatie -->

    <!-- start rij met form voor invullen van actviteiten -->
    <div class="row">
        <form action="<c:url value='/updatemonth'/>" method="post">
            <table class="table table-bordered">
                <col style="width:3%">
                <col style="width:3%">
                <col style="width:94%">
                <tbody style="font-size: 12px">
                <c:forEach var="dag" items="${dagenVanMaand}">
                    <tr
                            <c:choose>
                                <c:when test="${dag.dagNaam == 'Za'}">style="background: #d3d3d3"
                                </c:when>
                                <c:when test="${dag.dagNaam == 'Zo'}">style="background: #d3d3d3"
                                </c:when>
                            </c:choose>
                            >
                        <td>${dag.dagNaam}</td>
                        <td>${dag.dagNummer}</td>
                        <td>
                            <FCK:editor>
                                <jsp:attribute name="instanceName">d${dag.dagNummer}</jsp:attribute>
                                <jsp:attribute name="height">50</jsp:attribute>
                                <jsp:attribute name="value">${dag.dagActiviteit}</jsp:attribute>
                            </FCK:editor>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <input type="hidden" name="year" value="${year}">
            <input type="hidden" name="month" value="${month}">
            <button type="submit" class="btn btn-info">Pas aan</button>
        </form>
    </div>
    <!-- einde rij met form voor invullen van actviteiten -->
</div>
<!-- einde class container -->
<script src="<c:url value='/js/jquery.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
</body>
</html>