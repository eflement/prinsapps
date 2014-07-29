<%@ page import="org.flement.model.EmailAddress" %>
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
    <form role="form" class="form-horizontal" action="<c:url value='/ContactFormulierSending'/>" method="post"
          id="contactform">
        <p class="text-warning" style="padding-bottom: 0px">Uw ip-adres ter verificatie van de aanvrager:&nbsp;
            <%
                out.print(request.getRemoteAddr());
            %>
        </p>
        <!-- we geven hier het ip addres mee -->
        <input type="hidden" name="ipAddress" value='<c:out value="${pageContext.request.remoteAddr}"/>'>
        <input type="hidden" name="TO" value='<c:out value="${TO}"/>'>

        <div class="panel panel-warning">
            <div class="panel-heading">
                <%--<h3 class="panel-title">Neem contact op met : <strong>${TO}</strong> </h3>--%>
                <h3 class="panel-title">Neem contact op met : <strong>
                    <%--${TO}--%>
                    <%
                        out.print(EmailAddress.get(request.getParameter("TO") + "_naam"));
                    %>
                </strong></h3>
            </div>
            <div class="panel-body">
                <%--Naam verzender --%>
                <div class="form-group">
                    <label class="col-xs-3 control-label" for="naamVerzender">Uw naam :</label>

                    <div class="col-xs-9">
                        <input type="text" id="naamVerzender" class="col-xs-12" name="naamVerzender"
                               required="required">
                    </div>
                </div>
                <%-- E-mail verzender --%>
                <div class="form-group">
                    <label class="col-xs-3 control-label" for="emailVerzender">E-mail adres :</label>

                    <div class="col-xs-9">
                        <input type="email" id="emailVerzender" class="col-xs-12" name="emailVerzender">
                    </div>
                </div>
                <%-- telefoon verzender --%>
                <div class="form-group">
                    <label class="col-xs-3 control-label" for="telefoonVerzender">Telefoonnummer :</label>

                    <div class="col-xs-9">
                        <input type="text" id="telefoonVerzender" class="col-xs-12" name="telefoonVerzender">
                    </div>
                </div>
                <!--boodschap-->
                <div class="form-group">
                    <label class="col-xs-3 control-label" for="boodschap">Boodschap :</label>

                    <div class="col-xs-9">
                        <textarea id="boodschap" class="col-xs-12" name="boodschap" rows="5"
                                  required="required"></textarea>
                    </div>
                </div>
                <!--kopie van mail-->
                <div class="form-group">
                    <div class="col-xs-3 control-label"></div>

                    <div class="checkbox col-xs-9" style="padding-left: 35px">
                        <label>
                            <input type="checkbox" name="kopijMail"><strong>Stuur een kopij naar mijn e-mail adres</strong>
                        </label>
                    </div>
                </div>

            </div>
        </div>


        <p style="padding-bottom: 0px"></p>

        <div id="knoppen">
            <%--<button type="reset" class="btn btn-danger pull-left" form="inschrijvingsform">Reset</button>--%>
            <button type="submit" class="btn btn-info pull-right " form="contactform">Verzend</button>
        </div>
    </form>
</div>
<script src="<c:url value='/js/bootstrap.js' />"></script>
</body>
</html>
