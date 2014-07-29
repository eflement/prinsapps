package org.flement.control;

import org.flement.model.EmailAddress;
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


@WebServlet(name = "/ContactFormulierSendingServlet", urlPatterns = "/ContactFormulierSending")
public class ContactFormulierSendingServlet extends HttpServlet {
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
        String subject = "Mail via het Contactformulier";
        String content = "";
        Enumeration paramNames = request.getParameterNames();
        Map<String, String> paramNameValueMap = new HashMap<String, String>();

        while (paramNames.hasMoreElements()) {
            String paramName = (String) paramNames.nextElement();
            paramNameValueMap.put(paramName, request.getParameter(paramName));
        }

        String resultMessage1 = "";
        String resultMessage2 = "";
        String recipient1 = "";
        String recipient2 = "";
        String recipient3 = "webmaster@vb-dekleineprins.be";
        String kopijMail = "";
        String to = paramNameValueMap.get("TO");
//        EmailAddress emailAddress;
        recipient1 = EmailAddress.get(to);
        recipient2 = paramNameValueMap.get("emailVerzender");
        kopijMail = paramNameValueMap.get("kopijMail");

        content = content + "Ip address = " + paramNameValueMap.get("ipAddress");
        content = content + "\nNaam = " + paramNameValueMap.get("naamVerzender");
        content = content + "\nEmail = " + paramNameValueMap.get("emailVerzender");
        content = content + "\nTelefoon = " + paramNameValueMap.get("telefoonVerzender");
        content = content + "\nBoodschap = \n" + paramNameValueMap.get("boodschap");

        //kopij van verzonden formulier naar webmaster
        try {
            EmailUtility.sendEmail(host, port, user, pass, recipient3, subject,
                    content);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        // indien check box geselecteerd , stuur kopij naar indiener
        if ("on".equals(kopijMail)) {
            try {
                EmailUtility.sendEmail(host, port, user, pass, recipient2, subject,
                        content);
                resultMessage1 = "Er werd een kopij van het bericht verzonden naar " + recipient2;
            } catch (Exception ex) {
                ex.printStackTrace();
                resultMessage1 = "Er is een fout opgetreden bij het versturen naar: " + recipient2 + "\n" + ex.getMessage();
            }
        }
        // verzend sowieso naar bestemmeling
        try {
            EmailUtility.sendEmail(host, port, user, pass, recipient1, subject,
                    content);
            resultMessage2 = "Het formulier is met succes verzonden naar " + EmailAddress.get(to+"_naam");
        } catch (Exception ex) {
            ex.printStackTrace();
            resultMessage2 = "Er is een fout opgetreden: " + ex.getMessage();
        } finally {
            request.setAttribute("Message1", resultMessage1);
            request.setAttribute("Message2", resultMessage2);
            getServletContext().getRequestDispatcher("/WEB-INF/Result.jsp").forward(
                    request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
