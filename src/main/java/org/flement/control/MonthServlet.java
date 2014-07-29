package org.flement.control;

import org.flement.model.DagMaandKalender;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;
@WebServlet(name = "MonthServlet", urlPatterns = "/getmonth")
public class MonthServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int year;
        int month;
        int day = 0;
        String action;
        String jaartal;
        boolean hasToLogin = false;

        if (request.getParameter("action") != null) {
            action = request.getParameter("action");
        } else {
            action = "show";
        }


        // we checken of er een coockie bestaat die bewijst dat de gebruiker "ingelogd" is
        if ("edit".equals(action)) {
            String userName = null;
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("prinsAppsUser"))
                        userName = cookie.getValue();
                }
            }
            if (userName == null) {
                hasToLogin = true;

            }
        }

        // we halen de parameters op m.b.t. de kalender
        if ((request.getParameter("year") != null) & (request.getParameter("month") != null)) {
            year = Integer.parseInt(request.getParameter("year"));
            month = Integer.parseInt(request.getParameter("month"));
        } else {
            Calendar datumVanVandaag = new GregorianCalendar();
            year = datumVanVandaag.get(Calendar.YEAR);
            month = datumVanVandaag.get(Calendar.MONTH) + 1;
        }


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
            //do the database stuff
            ResultSet resultSet = null;

            // eerst halen we het de waarden op van year, month en desgevallend (minicalendar) van day
            if ("wrapped".equals(action)) { //servlet triggered by minicalendare on site
                String sqlStatement = "SELECT * FROM `parameters` WHERE 1";
                resultSet = statement.executeQuery(sqlStatement);
                while (resultSet.next()) {
                    year = resultSet.getInt("year");
                    month = resultSet.getInt("month");
                    day = resultSet.getInt("day");
                }
            } else {    // servlet not triggered by minicalender
                if ((request.getParameter("year") != null) & (request.getParameter("month") != null)) {
                    year = Integer.parseInt(request.getParameter("year"));
                    month = Integer.parseInt(request.getParameter("month"));
                } else {
                    Calendar datumVanVandaag = new GregorianCalendar();
                    year = datumVanVandaag.get(Calendar.YEAR);
                    month = datumVanVandaag.get(Calendar.MONTH) + 1;
                }
            }

            //dan bouwen we onze bean DagMaandKalendar op
            GregorianCalendar kalenderTeTonenMaand = new GregorianCalendar(year, month - 1, 1);
            int aantalDagenInMaand = kalenderTeTonenMaand.getActualMaximum(Calendar.DAY_OF_MONTH);
            int dagNummerEersteDag = kalenderTeTonenMaand.get(Calendar.DAY_OF_WEEK);
            kalenderTeTonenMaand.setFirstDayOfWeek(Calendar.MONDAY);
            String[] dagenVanDeWeek = {"Ma", "Di", "Wo", "Do", "Vr", "Za", "Zo"};
            String[] maandenVanHetJaar = {"Januari", "Februari", "Maart", "April", "Mei", "Juni", "Juli",
                    "Augustus", "September", "Oktober", "November", "December"};
            int dagVanDeWeek;
            ArrayList<DagMaandKalender> dagenVanMaand = new ArrayList<DagMaandKalender>();
            for (int iDagteller = 1; iDagteller <= aantalDagenInMaand; iDagteller++) {
                String dagNaam;
                String dagActiviteit = "";
                dagVanDeWeek = ((iDagteller + dagNummerEersteDag - 3) % 7);
                if (dagVanDeWeek >= 0) {
                    dagNaam = dagenVanDeWeek[dagVanDeWeek];
                } else {
                    dagNaam = "Zo";
                }
                String sqlStatement = "select items from activities where year=" + year + " and month=" + month + " and day=" + iDagteller;
                resultSet = statement.executeQuery(sqlStatement);
                while (resultSet.next()) {
                    dagActiviteit = resultSet.getString("items");
                }

                DagMaandKalender dagMaandKalender = new DagMaandKalender(dagNaam, Integer.toString(iDagteller), dagActiviteit);
                dagenVanMaand.add(dagMaandKalender);
            } // end for

            // hier sluiten we alle connecties af
            resultSet.close();
            statement.close();
            connection.close();
            if (request.getParameter("view") != null) {
                request.setAttribute("view", "full");
            }
            request.setAttribute("day", day);
            request.setAttribute("maandenVanHetJaar", maandenVanHetJaar);
            request.setAttribute("dagenVanMaand", dagenVanMaand);
            request.setAttribute("year", year);
            request.setAttribute("month", month);
            if (request.getParameter("navbar") != null){
                if ("1".equals(request.getParameter("navbar"))) request.setAttribute("navbar","1");
                        else request.setAttribute("navbar","0");
            };
            String url = "";
            if ("edit".equals(action)) {
                url = "/WEB-INF/EditMonth.jsp";
            } else {
                url = "/WEB-INF/ShowMonth.jsp";
            }
            if (hasToLogin) url = "/WEB-INF/Login.jsp?app=activities";
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            String DBerror = e.getMessage();
            request.setAttribute("DBError", DBerror);
            String url = "/WEB-INF/DBError.jsp";
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
            dispatcher.forward(request, response);
        }
    }
}
