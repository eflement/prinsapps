<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link rel="stylesheet" href="<c:url value='/css/bootstrap.css' />" type="text/css"/>
<div class="container">
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="<c:url value='/index.jsp'/>">Home</a>
        </div>

        <div class="collapse navbar-collapse navbar-ex1-collapse">
            <ul class="nav navbar-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Kalender<b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="<c:url value='/getmonth?action=show&navbar=1'/>">Toon kalender</a></li>
                        <li><a href="<c:url value='/getmonth?action=edit'/>"> Pas kalender aan</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Menukaarten<b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="<c:url value='/getmenucard?action=show&navbar=1'/>">Toon menukaarten</a></li>
                        <li><a href="<c:url value='/getmenucard?action=edit'/>">Pas menukaarten aan</a></li>
                    </ul>
                </li>
                <li><a href="<c:url value='/minicalendar'/>" target="_blank">Minicalendar</a></li>
                <%--<li><a href="<c:url value='/inschrijvingsFormulier'/>" target="_blank">Formulier</a></li>--%>
                <li><a href="<c:url value='/logout'/>">Log uit</a></li>
            </ul>
        </div>
    </nav>
    <!-- einde navbar -->
</div>
<!-- einde class container -->