<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Online inschrijven van uw kind</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.css' />" type="text/css"/>

</head>
<body>
<script src="<c:url value='/js/jquery.js' />"></script>
<div class="container">
<form role="form" class="form-horizontal" action="/InschrijvingsFormulierSendingServlet" method="post" id="inschrijvingsform">
<div class="page-header">
    <h1>
        <small>Online inschrijven van uw kind</small>
    </h1>
</div>
<p class="text-warning">Uw ip-adres ter verificatie van de aanvrager:&nbsp;
    <%
        out.print(request.getRemoteAddr());
//            out.print( request.getRemoteHost() );
    %>
</p>

<%--GEGEVENS KIND--%>
<div class="panel panel-warning">
    <div class="panel-heading">
        <h3 class="panel-title">Gegevens van het kind</h3>
    </div>
    <div class="panel-body">
        <%--naam en voornaam --%>
        <div class="form-group">
            <label class="col-xs-3 control-label" for="naamKind">Naam en voornaam KIND</label>

            <div class="col-xs-9">
                <input type="text" id="naamKind" class="col-xs-12" name="naamKind">
            </div>
        </div>
        <%--geslacht--%>
        <div class="form-group">
            <div class="col-xs-3 control-label"><strong>Geslacht</strong></div>

            <div class="col-xs-9 radio-inline">
                <label class="col-xs-2">
                    <input type="radio" name="geslacht" id="geslacht_m_" value="Jongen">
                    Jongen
                </label>
                <label class="col-xs-2">
                    <input type="radio" name="geslacht" id="geslacht_v" value="Meisje">
                    Meisje
                </label>
            </div>
        </div>
        <%--geboorteplaats en datum--%>
        <div class="form-group">
            <label class="col-xs-3 control-label" for="geboortePlaatsDatum">Geboorteplaats en datum</label>

            <div class="col-xs-9">
                <input type="text" id="geboortePlaatsDatum" class="col-xs-12" name="geboortePlaatsDatum">
            </div>
        </div>
        <%--rijksregisternr--%>
        <div class="form-group">
            <label class="col-xs-3 control-label" for="rijksregisternr">Rijksregisternummer</label>

            <div class="col-xs-9">
                <input type="text" id="rijksregisternr" class="col-xs-12" name="rijksregisternr">
            </div>
        </div>
        <%--straat en nr--%>
        <div class="form-group">
            <label class="col-xs-3 control-label" for="straat">Straat en Nr</label>

            <div class="col-xs-7">
                <input type="text" id="straat" class="col-xs-12" name="straat">
            </div>
            <div class="col-xs-2">
                <input type="text" id="straatNr" class="col-xs-12" name="straatNr">
            </div>
        </div>
        <%--postcode en gemeente--%>
        <div class="form-group">
            <label class="col-xs-3 control-label" for="postcode">Postcode en gemeente</label>

            <div class="col-xs-2">
                <input type="text" id="postcode" class="col-xs-12" name="postcode">
            </div>
            <div class="col-xs-7">
                <input type="text" id="gemeente" class="col-xs-12" name="gemeente">
            </div>
        </div>
    </div>
</div>

<%--GEGEVENS VADER--%>
<div class="panel panel-warning">
    <div class="panel-heading">
        <h3 class="panel-title">Gegevens van de vader</h3>
    </div>
    <div class="panel-body">
        <%--naam vader --%>
        <div class="form-group">
            <label class="col-xs-3 control-label" for="naamVader">Naam</label>

            <div class="col-xs-9">
                <input type="text" id="naamVader" class="col-xs-12" name="naamVader">
            </div>
        </div>
        <%--geboorteplaats en datum vader--%>
        <div class="form-group">
            <label class="col-xs-3 control-label" for="geboortePlaatsDatumVader">Geboorteplaats en datum</label>

            <div class="col-xs-9">
                <input type="text" id="geboortePlaatsDatumVader" class="col-xs-12"
                       name="geboortePlaatsDatumVader">
            </div>
        </div>
        <%--beroep vader--%>
        <div class="form-group">
            <label class="col-xs-3 control-label" for="beroepVader">Beroep</label>

            <div class="col-xs-9">
                <input type="text" id="beroepVader" class="col-xs-12" name="beroepVader">
            </div>
        </div>
        <%--telefoon vader--%>
        <div class="form-group">
            <label class="col-xs-3 control-label" for="telVader">Telefoon</label>

            <div class="col-xs-9">
                <input type="text" id="telVader" class="col-xs-12" name="telVader">
            </div>
        </div>
        <%--straat en nr vader--%>
        <div class="form-group">
            <label class="col-xs-3 control-label" for="straat">Straat en Nr (indien afwijkend)</label>

            <div class="col-xs-7">
                <input type="text" id="straatVader" class="col-xs-12" name="straatVader">
            </div>
            <div class="col-xs-2">
                <input type="text" id="straatNrVader" class="col-xs-12" name="straatNrVader">
            </div>
        </div>
        <%--postcode en gemeente vader--%>
        <div class="form-group">
            <label class="col-xs-3 control-label" for="postcodeVader">Postcode en gemeente</label>

            <div class="col-xs-2">
                <input type="text" id="postcodeVader" class="col-xs-12" name="postcodeVader">
            </div>
            <div class="col-xs-7">
                <input type="text" id="gemeenteVader" class="col-xs-12" name="gemeenteVader">
            </div>
        </div>
        <%--email vader--%>
        <div class="form-group">
            <label class="col-xs-3 control-label" for="emailVader">Email</label>

            <div class="col-xs-9">
                <input type="email" id="emailVader" class="col-xs-12" name="emailVader">
            </div>
        </div>
    </div>
</div>

<%--GEGEVENS MOEDER--%>
<div class="panel panel-warning">
    <div class="panel-heading">
        <h3 class="panel-title">Gegevens van de moeder</h3>
    </div>
    <div class="panel-body">
        <%--naam vader --%>
        <div class="form-group">
            <label class="col-xs-3 control-label" for="naamMoeder">Naam</label>

            <div class="col-xs-9">
                <input type="text" id="naamMoeder" class="col-xs-12" name="naamMoeder">
            </div>
        </div>
        <%--geboorteplaats en datum vader--%>
        <div class="form-group">
            <label class="col-xs-3 control-label" for="geboortePlaatsDatumMoeder">Geboorteplaats en datum</label>

            <div class="col-xs-9">
                <input type="text" id="geboortePlaatsDatumMoeder" class="col-xs-12"
                       name="geboortePlaatsDatumMoeder">
            </div>
        </div>
        <%--beroep vader--%>
        <div class="form-group">
            <label class="col-xs-3 control-label" for="beroepMoeder">Beroep</label>

            <div class="col-xs-9">
                <input type="text" id="beroepMoeder" class="col-xs-12" name="beroepMoeder">
            </div>
        </div>
        <%--telefoon vader--%>
        <div class="form-group">
            <label class="col-xs-3 control-label" for="telMoeder">Telefoon</label>

            <div class="col-xs-9">
                <input type="text" id="telMoeder" class="col-xs-12" name="telMoeder">
            </div>
        </div>
        <%--straat en nr vader--%>
        <div class="form-group">
            <label class="col-xs-3 control-label" for="straatMoeder">Straat en Nr (indien afwijkend)</label>

            <div class="col-xs-7">
                <input type="text" id="straatMoeder" class="col-xs-12" name="straatMoeder">
            </div>
            <div class="col-xs-2">
                <input type="text" id="straatNrMoeder" class="col-xs-12" name="straatNrMoeder">
            </div>
        </div>
        <%--postcode en gemeente vader--%>
        <div class="form-group">
            <label class="col-xs-3 control-label" for="postcodeMoeder">Postcode en gemeente</label>

            <div class="col-xs-2">
                <input type="text" id="postcodeMoeder" class="col-xs-12" name="postcodeMoeder">
            </div>
            <div class="col-xs-7">
                <input type="text" id="gemeenteMoeder" class="col-xs-12" name="gemeenteMoeder">
            </div>
        </div>
        <%--email vader--%>
        <div class="form-group">
            <label class="col-xs-3 control-label" for="emailMoeder">Email</label>

            <div class="col-xs-9">
                <input type="email" id="emailMoeder" class="col-xs-12" name="emailMoeder">
            </div>
        </div>
    </div>
</div>

<div class="panel panel-warning">
    <div class="panel-heading">

        <h3 class="panel-title">Algemeen</h3>
    </div>
    <div class="panel-body">
        <%--eerste inschrijving--%>
        <div class="form-group">
            <div class="col-xs-3 control-label"><strong>Het betreft een eerste inschrijving</strong></div>

            <div class="checkbox col-xs-9" style="padding-left: 35px">
                <label>
                    <input type="checkbox" name="eersteInschrijving">
                </label>
            </div>
        </div>
        <%--verandering van school--%>
        <div class="form-group">
            <div class="col-xs-3 control-label"><strong>Het betreft een schoolverandering</strong></div>

            <div class="checkbox col-xs-9" style="padding-left: 35px">
                <label>
                    <input type="checkbox" name="schoolverandering">
                </label>
            </div>
        </div>
        <%--gezinshoofd--%>
        <div class="form-group">
            <div class="col-xs-3 control-label"><strong>Wie is het gezinshoofd</strong></div>

            <div class="col-xs-9 radio-inline">
                <label class="col-xs-2">
                    <input type="radio" name="gezinshoofd" id="gezinshoofd_m" value="Vader">
                    Vader
                </label>
                <label class="col-xs-2">
                    <input type="radio" name="gezinshoofd" id="gezinshoofd_v" value="Moeder">
                    Moeder
                </label>
            </div>
        </div>
        <%--Huisdokter--%>
        <div class="form-group">
            <label class="col-xs-3 control-label" for="huisdokter">Huisdokter</label>

            <div class="col-xs-9">
                <input type="text" id="huisdokter" class="col-xs-12" name="huisdokter">
            </div>
        </div>
        <%--te verwittigen--%>
        <div class="form-group">
            <label class="col-xs-3 control-label" for="teVerwittigen">Wie te verwittigen bij afwezigheid ouders</label>

            <div class="col-xs-9">
                <input type="text" id="teVerwittigen" class="col-xs-12" name="teVerwittigen">
            </div>
        </div>
    </div>
</div>
<p style="padding-bottom: 0px"></p>

<div id="knoppen">
    <button type="reset" class="btn btn-danger pull-left" form="inschrijvingsform">Reset</button>
    <button type="submit" class="btn  pull-right disabled knop" form="inschrijvingsform">Verzend</button>
</div>
</form>
</div>
<script src="<c:url value='/js/bootstrap.js' />"></script>
</body>
</html>
