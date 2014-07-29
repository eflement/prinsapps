package org.flement.control;

import org.flement.model.DagMaandKalender;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;

@WebServlet(name = "UpdateMonthServlet", urlPatterns = "/updatemonth")
public class UpdateMonthServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {




        int year = Integer.parseInt(request.getParameter("year"));
        int month = Integer.parseInt(request.getParameter("month"));
        String[] maandenVanHetJaar = {"Januari","Februari","Maart","April","Mei","Juni","Juli",
                "Augustus","September","Oktober","November","December"};
        GregorianCalendar kalenderTeTonenMaand = new GregorianCalendar(year, month - 1, 1);
        int aantalDagenInMaand = kalenderTeTonenMaand.getActualMaximum(Calendar.DAY_OF_MONTH);
        int dagNummerEersteDag = kalenderTeTonenMaand.get(Calendar.DAY_OF_WEEK);

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
            ResultSet resultSet = null;
            int rowsUpdated = 0;

            // eerst doen we alle updates in de databank
            for (int dagTeller = 1; dagTeller <= aantalDagenInMaand; dagTeller++) {
                String dagNummer = Integer.toString(dagTeller);
                String dagActiviteitRaw = request.getParameter("d"+dagNummer);
                String dagActiviteit = dagActiviteitRaw.trim();
                String sqlStatement = "";
                if (! "".equals(dagActiviteit)) {
                    sqlStatement = "insert into activities (year,month,day,items) values(" +
                            year + "," +
                            month + "," +
                            dagNummer + "," +
                            "\"" + dagActiviteit + "\"" +
                            ") on duplicate key update items = \""
                            + dagActiviteit
                            + "\";";

                } else {
                    sqlStatement = "delete from activities where year="+year+" and month="+month+" and day="+dagTeller+";";
                }
                rowsUpdated = statement.executeUpdate(sqlStatement);
            }
            // dan bouwen we ons nieuwmaandoverzicht op
            String[] dagenVanDeWeek = {"Ma", "Di", "Wo", "Do", "Vr", "Za", "Zo"};
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
            statement.close();
            connection.close();
            request.setAttribute("year",year);
            request.setAttribute("month",month);
            request.setAttribute("maandenVanHetJaar",maandenVanHetJaar);
            request.setAttribute("dagenVanMaand", dagenVanMaand);
            String url = "/WEB-INF/EditMonth.jsp";
            RequestDispatcher dispatcher = request.getRequestDispatcher(url);
            dispatcher.forward(request,response);
        } catch (SQLException e)

        {
            String DBerror =e.getMessage();
            request.setAttribute("DBError",DBerror);
            String url = "/WEB-INF/DBError.jsp";
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
            dispatcher.forward(request, response);
        }

    }
}
