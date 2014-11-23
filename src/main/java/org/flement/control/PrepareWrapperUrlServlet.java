package org.flement.control;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet(name = "PrepareWrapperUrlServlet", urlPatterns = "/preparewrapurl")
public class PrepareWrapperUrlServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String year = request.getParameter("year");
        String month = request.getParameter("month");
        String day = request.getParameter("day");
        try {
            // get a connection
            String dbURL = "jdbc:mysql://localhost:3306/pprinsappss";
            String username = "pprinsappss";
            String password = "pprinsappss";
            try {
                //Class.forName("com.mysql.jdbc.driver");
                Class.forName("org.gjt.mm.mysql.Driver");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
            // create connection
            Connection connection = DriverManager.getConnection(
                    dbURL, username, password);
            // create a statement
            Statement statement = connection.createStatement();
            String sqlStatement = "update parameters  set year="+year+
                                   ",month="+month+
                                   ",day="+day+ ";";

            int rowsUpdated = statement.executeUpdate(sqlStatement);
            statement.close();
            connection.close();
//            String site = new String("http://www.vb-dekleineprins.be/index.php?option=com_wrapper&Itemid=270");
            String site = new String("http://www.vb-dekleineprins.be/maandkalender");
//            String site = new String("/getmonth?action=wrapped");
            response.sendRedirect(site);
        } catch (SQLException e) {
            String DBerror = e.getMessage();
            request.setAttribute("DBError", DBerror);
            String url = "/WEB-INF/DBError.jsp";
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
            dispatcher.forward(request, response);
        }
    }
}
