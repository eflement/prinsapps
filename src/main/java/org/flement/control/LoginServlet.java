package org.flement.control;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
@WebServlet(name = "LoginServlet", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final String userID = "mijnapps";
    private final String password = "mijnapps";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // get request parameters for userID and password
        String prinsAppsUser = request.getParameter("prinsAppsUser");
        String prinsAppsPassword = request.getParameter("prinsAppsPassword");
        String app = request.getParameter("application");
        String url = "";
        if (userID.equals(prinsAppsUser) && password.equals(prinsAppsPassword)) {
            Cookie prinsAppsCookie = new Cookie("prinsAppsUser", prinsAppsUser);
            // setting cookie to expiry after one month
            prinsAppsCookie.setMaxAge(60 * 60 * 24 * 30);
            response.addCookie(prinsAppsCookie);
            if ("menucards".equals(app)) url =  request.getContextPath() + "/getmenucard?action=edit";
            if ("activities".equals(app)) url = request.getContextPath() + "/getmonth?action=edit";

            response.sendRedirect(response.encodeRedirectURL(url));
        } else {
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/WEB-INF/Login.jsp");
            PrintWriter out = response.getWriter();
            out.println("<font color=red>Sorry verkeerd wachtwoord...</br>Probeer opnieuw</font>\n");
            rd.include(request, response);
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
