<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.css'/>" media="screen">
    <link rel="stylesheet" href="<c:url value='/css/showmonthp.css'/>" media="print">
    <link rel="stylesheet" href="<c:url value='/css/showmonths.css'/>" media="screen">
    <link rel="stylesheet" href="<c:url value='/css/font-awesome.min.css'/>">
    <%--<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0-wip/css/bootstrap.min.css">--%>
    <title></title>

</head>
<body>
<div class="container">
    <!-- titel voor afdrukken -->
    <div class="row text-center hidden">
        <h2>Vrije Basisschool De Kleine Prins - Kluizen</h2>
    </div>
    <!-- einde titel afdrukken -->

    <!-- toon navigation menu -->
    <c:choose>
        <c:when test="${navbar == '1'}">
            <jsp:include page="NavBar.jsp"></jsp:include>
            <style type="text/css">
                body {
                    padding-top: 60px;
                    padding-bottom: 40px;
                }
            </style>
        </c:when>
        <c:otherwise>
        </c:otherwise>
    </c:choose>

    <!-- bovenset print knop -->
    <c:if test="${view == 'full'}">
        <div id="printknop" class="noPrint text-center" style="margin-bottom: 10px; margin-top: 10px">
            <a href="#" class="btn btn-danger">
                Afdrukken&nbsp;&nbsp;<i class="icon-print icon-large"></i></a>
        </div>
    </c:if>
    <!-- start rij met maand en jaar navigatie -->
    <div class="row">
        <table class="table " style="width: 100%">
            <col style="width:33%">
            <col style="width:33%">
            <col style="width:33%">
            <tbody>
            <tr>
                <td>
                    <div class="btn-group noPrint">
                        <button class="btn btn-warning dropdown-toggle" type="button" data-toggle="dropdown">
                            ${maandenVanHetJaar[requestScope.month - 1]}&nbsp;&nbsp;<span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu">
                            <li><a href="<c:url value='/getmonth?action=show&year=${year}&month=1&navbar=${navbar}'/>">januari</a>
                            </li>
                            <li><a href="<c:url value='/getmonth?action=show&year=${year}&month=2&navbar=${navbar}'/>">februari</a>
                            </li>
                            <li><a href="<c:url value='/getmonth?action=show&year=${year}&month=3&navbar=${navbar}'/>">maart</a></li>
                            <li><a href="<c:url value='/getmonth?action=show&year=${year}&month=4&navbar=${navbar}'/>">april</a></li>
                            <li><a href="<c:url value='/getmonth?action=show&year=${year}&month=5&navbar=${navbar}'/>">mei</a></li>
                            <li><a href="<c:url value='/getmonth?action=show&year=${year}&month=6&navbar=${navbar}'/>">juni</a></li>
                            <li><a href="<c:url value='/getmonth?action=show&year=${year}&month=7&navbar=${navbar}'/>">juli</a></li>
                            <li><a href="<c:url value='/getmonth?action=show&year=${year}&month=8&navbar=${navbar}'/>">augustus</a>
                            </li>
                            <li><a href="<c:url value='/getmonth?action=show&year=${year}&month=9&navbar=${navbar}'/>">september</a>
                            </li>
                            <li><a href="<c:url value='/getmonth?action=show&year=${year}&month=10&navbar=${navbar}'/>">oktober</a>
                            </li>
                            <li><a href="<c:url value='/getmonth?action=show&year=${year}&month=11&navbar=${navbar}'/>">november</a>
                            </li>
                            <li><a href="<c:url value='/getmonth?action=show&year=${year}&month=12&navbar=${navbar}'/>">december</a>
                            </li>
                        </ul>
                    </div>
                </td>
                <td>
                    <h4 style="text-align: center">${maandenVanHetJaar[requestScope.month - 1]} ${year}</h4>
                </td>
                <td>
                    <div class="btn-group pull-right noPrint">
                        <button class="btn btn-info dropdown-toggle" type="button" data-toggle="dropdown">
                            ${year}&nbsp;&nbsp;<span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="<c:url value='/getmonth?action=show&year=${year - 2}&month=${month}&navbar=${navbar}'/>">${year - 2}</a>
                            </li>
                            <li>
                                <a href="<c:url value='/getmonth?action=show&year=${year - 1}&month=${month}&navbar=${navbar}'/>">${year - 1}</a>
                            </li>
                            <li><a href="<c:url value='/getmonth?action=show&year=${year}&month=${month}&navbar=${navbar}'/>">${year}</a>
                            </li>
                            <li>
                                <a href="<c:url value='/getmonth?action=show&year=${year + 1}&month=${month}&navbar=${navbar}'/>">${year + 1}</a>
                            </li>
                            <li>
                                <a href="<c:url value='/getmonth?action=show&year=${year + 2}&month=${month}&navbar=${navbar}'/>">${year + 2}</a>
                            </li>
                        </ul>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
    <!-- end rij met maand en jaar navigatie -->

    <!-- start rij  tabel met maandoverzicht  -->
    <div class="row" id="maandkal" style="margin-top: -5px">
        <div id="maandkalender"
                <c:if test="${view != 'full'}">
                    <%--class="table-bordered" style="max-height: 282px;overflow-y:scroll;overflow-x:hidden"--%>
                    class="table-bordered"
                </c:if>
                >
            <!-- end class row-fluid -->
            <table class="table table-bordered table-condensed" style="margin-bottom: 0px">
                <col style="width:4%">
                <col style="width:4%; text-align: center">
                <col style="width:92%">
                <tbody>
                <c:set var="tetonendag" value="${day}"></c:set>
                <c:forEach var="dag" items="${dagenVanMaand}">
                <c:set var="dezedag" value="${dag.dagNummer}"></c:set>
                <c:if test="${tetonendag == dezedag}">
                </tbody>
            </table>
            <div id="tetonendag"></div>
            <table class="table table-bordered table-condensed" style="margin-top: -1px">
                <col style="width:4%">
                <col style="width:4%">
                <col style="width:92%">
                <tbody>
                </c:if>
                <tr
                        <c:choose>
                            <c:when test="${dag.dagNaam == 'Za'}">style="background: #d3d3d3"
                            </c:when>
                            <c:when test="${dag.dagNaam == 'Zo'}">style="background: #d3d3d3"
                            </c:when>
                        </c:choose>
                        >
                    <td>${dag.dagNaam}</td>
                    <td style="text-align: center">${dag.dagNummer}</td>
                    <td style="padding-left: 10px;" class="nobottom"><c:out value="${dag.dagActiviteit}" escapeXml="false"/></td>
                </tr>
                </c:forEach>

                </tbody>
            </table>
            <div id="einde"></div>
        </div>
    </div>
    <!-- einde rij met tabel -->

    <!-- printknop -->
    <c:choose>
        <c:when test="${view != 'full'}">
            <div class="row">
                <!-- knop full screen -->
                <div class="pull-right" style="margin-top: 10px;margin-right: 10px">
                    <a href="<c:url value='/getmonth?action=show&year=${year}&month=${month}&view=full'/>"
                       target="_blank"
                       class="btn btn-default pull-right">Afdrukken&nbsp;&nbsp;<i
                            class="icon-external-link"></i>
                    </a>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div id="printknop2" class="noPrint text-center">
                </br>
                <a href="#" class="btn btn-danger text-center">
                    Afdrukken&nbsp;&nbsp;<i class="icon-print icon-large"></i></a>
            </div>
        </c:otherwise>
    </c:choose>
    <!-- einde print knop -->

</div>
<!-- einde class container -->
<script src="<c:url value='/js/jquery.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
<%--<script src="<c:url value='/js/jquery.scrollTo.min.js'/>"></script>--%>
<script src="<c:url value='/js/showmonth.js'/>"></script>

</body>
</html>