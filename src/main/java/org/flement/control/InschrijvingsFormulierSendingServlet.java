package org.flement.control;

import org.flement.util.EmailUtility;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by ef on 24/01/14.
 */
//@WebServlet(name = "/InschrijvingsFormulierSendingServlet",urlPatterns = "/InschrijvingsFormulierSending")
@WebServlet("/InschrijvingsFormulierSendingServlet")
public class InschrijvingsFormulierSendingServlet extends HttpServlet {
    private String host;
    private String port;
    private String user;
    private String pass;

    public void init() {
        // reads SMTP server setting from web.xml file
        ServletContext context = getServletContext();
        host = context.getInitParameter("host");
        port = context.getInitParameter("port");
        user = context.getInitParameter("user");
        pass = context.getInitParameter("pass");
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // reads form fields
//        String recipient = request.getParameter("recipient");
        String recipient = "eddy@flement.org";
//        String subject = request.getParameter("subject");
        String subject = "Elektronische inschrijving";
//        String content = request.getParameter("content");
        String content = "";
        Enumeration paramNames = request.getParameterNames();
        Map<String , String > paramNameValueMap= new HashMap<String, String>();

        while(paramNames.hasMoreElements()) {
            String paramName = (String)paramNames.nextElement();
            paramNameValueMap.put(paramName,request.getParameter(paramName));
        }

        String resultMessage = "";

        content = content + "Naam kind = \t\t\t" + paramNameValueMap.get("naamKind");
        content = content +"\nGeslacht = \t\t\t" + paramNameValueMap.get("geslacht");
        content = content +"\nGeboorteplaats en datum = \t" + paramNameValueMap.get("geboortePlaatsDatum");
        content = content +"\nRijksregisternummer = \t\t" + paramNameValueMap.get("rijksregisternr");
        content = content +"\nStraat = \t\t\t" + paramNameValueMap.get("straat") + "\t\tNr = " + paramNameValueMap.get("straatNr");
        content = content +"\nPostcode = \t\t\t" + paramNameValueMap.get("postcode") + "\t\t\tGemeente = " + paramNameValueMap.get("gemeente");



        try {
            EmailUtility.sendEmail(host, port, user, pass, recipient, subject,
                    content);
            resultMessage = "The e-mail was sent successfully";
        } catch (Exception ex) {
            ex.printStackTrace();
            resultMessage = "There were an error: " + ex.getMessage();
        } finally {
            request.setAttribute("Message", resultMessage);
            getServletContext().getRequestDispatcher("/WEB-INF/Result.jsp").forward(
                    request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
