package org.flement.control;

import org.flement.model.DagMaandMiniKalender;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;

// we werken met dagcodes om aan te geven welke soort dag het is
// de volgende codes gelden :
// 1 = niet van de huidige maand
// 2 = zonder actiteiten
// 3 = met activiteiten
// 4 = vandaag zonder activiteiten
// 5 = vandaag met activiteiten

@WebServlet(name = "MiniCalendarServlet", urlPatterns = "/minicalendar")
public class MiniCalendarServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int year = 0;
        int month = 0;
        int dagVandaag = 0;
        HttpSession session = request.getSession(true);
        if ((session.getAttribute("month") != null) & (session.getAttribute("year") != null)) { // we hebben een sessie
            if ((request.getParameter("action") != null)) {     // we vragen een nieuwe maand op via de pijltjes
                if ("previous".equals(request.getParameter("action"))) {    // toon vorige maand
                    Long LYear = (Long) session.getAttribute("prevYear");
                    year = (int) (long) LYear;
                    Long LMonth = (Long) session.getAttribute("prevMonth");
                    month = (int) (long) LMonth;
                }
                if ("next".equals(request.getParameter("action"))) {      // toon volgende maand
                    Long LYear = (Long) session.getAttribute("nextYear");
                    year = (int) (long) LYear;
                    Long LMonth = (Long) session.getAttribute("nextMonth");
                    month = (int) (long) LMonth;
                }
                Calendar datumVanVandaag = new GregorianCalendar();
                int maandVandaag = datumVanVandaag.get(Calendar.MONTH) + 1;
                int jaarVandaag = datumVanVandaag.get(Calendar.YEAR);
                if ((year == jaarVandaag) & (month == maandVandaag)) {
                    dagVandaag = datumVanVandaag.get(Calendar.DATE);
                }
            } else { // we hebben een maand gekozen
                year = (Integer) session.getAttribute("year");
                month = (Integer) session.getAttribute("month");
                Calendar datumVanVandaag = new GregorianCalendar();
                int maandVandaag = datumVanVandaag.get(Calendar.MONTH) + 1;
                int jaarVandaag = datumVanVandaag.get(Calendar.YEAR);
                if ((year == jaarVandaag) & (month == maandVandaag)) {
                    dagVandaag = datumVanVandaag.get(Calendar.DATE);
                }
            }
        } else {                                                                                 // we starten een nieuwe sessie
            Calendar datumVanVandaag = new GregorianCalendar();
            year = datumVanVandaag.get(Calendar.YEAR);
            month = datumVanVandaag.get(Calendar.MONTH) + 1;
            dagVandaag = datumVanVandaag.get(Calendar.DATE);
        }

        String[] maandenVanHetJaar = {"Januari", "Februari", "Maart", "April", "Mei", "Juni", "Juli",
                "Augustus", "September", "Oktober", "November", "December"};
        Calendar calendar = new GregorianCalendar();

        GregorianCalendar cal = new GregorianCalendar(year, month - 1, 1);
        int aantalDagenInMaand = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        int eersteDagMaandStartOpDag = cal.get(Calendar.DAY_OF_WEEK);
        if (eersteDagMaandStartOpDag == 1) {
            eersteDagMaandStartOpDag = 7;
        } else {
            eersteDagMaandStartOpDag = eersteDagMaandStartOpDag - 1;
        }
        int aantalWekeninMaand = (aantalDagenInMaand + eersteDagMaandStartOpDag - 2) / 7 + 1;
        int aantalDagenVorigeMaand;
        if (month == 0) {
            GregorianCalendar cal_previous = new GregorianCalendar(year - 1, 11, 1);
            aantalDagenVorigeMaand = cal_previous.getActualMaximum(Calendar.DAY_OF_MONTH);
        } else {
            GregorianCalendar cal_previous = new GregorianCalendar(year, month - 2, 1);
            aantalDagenVorigeMaand = cal_previous.getActualMaximum(Calendar.DAY_OF_MONTH);
        }

        ArrayList<DagMaandMiniKalender> dagenVanMaandMiniKalender = new ArrayList<DagMaandMiniKalender>();
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


            for (int teller = 1; teller <= 7 * aantalWekeninMaand; teller++) {
                if (teller < eersteDagMaandStartOpDag) {
                    // dagen vorige maand
                    DagMaandMiniKalender dagMaandMiniKalender = new DagMaandMiniKalender(Integer.toString(aantalDagenVorigeMaand + 1 - eersteDagMaandStartOpDag + teller), "1", "");
                    dagenVanMaandMiniKalender.add(dagMaandMiniKalender);
                } else if (teller > eersteDagMaandStartOpDag + aantalDagenInMaand - 1) {
                    // dagen volgende maand
                    DagMaandMiniKalender dagMaandMiniKalender = new DagMaandMiniKalender(Integer.toString(teller - eersteDagMaandStartOpDag - aantalDagenInMaand + 1), "1", "");
                    dagenVanMaandMiniKalender.add(dagMaandMiniKalender);
                } else {
                    // dagen van deze maand
                    int dezeDag = teller - eersteDagMaandStartOpDag + 1;
                    int dagCodeBasis = 0;
                    if (dezeDag == dagVandaag) {
                        dagCodeBasis = 4;
                    } else {
                        dagCodeBasis = 2;
                    }
                    String sqlStatement = "select items from activities where year=" + year + " and month=" + month + " and day=" +
                            Integer.toString(teller - eersteDagMaandStartOpDag + 1);
                    resultSet = statement.executeQuery(sqlStatement);
                    String actviteitVanDeDag = "";
                    while (resultSet.next()) {
                        actviteitVanDeDag = resultSet.getString("items");
                        if (!"".equals(actviteitVanDeDag)) {
                            dagCodeBasis = dagCodeBasis + 1;
                        }
                        String cleanString = actviteitVanDeDag.replaceAll("\\<.*?>", "");
                        String cleanString2 = cleanString.replaceAll("&nbsp;", "");
                        actviteitVanDeDag = cleanString2;
                    }
                    DagMaandMiniKalender dagMaandMiniKalender = new DagMaandMiniKalender(Integer.toString(teller - eersteDagMaandStartOpDag + 1),
                            Integer.toString(dagCodeBasis), actviteitVanDeDag);
                    dagenVanMaandMiniKalender.add(dagMaandMiniKalender);
                }
            }  // end for
            resultSet.close();
            statement.close();
            connection.close();
            session.setAttribute("year", year);
            session.setAttribute("month", month);
//            request.setAttribute("year", year);
//            request.setAttribute("month", month);
//            request.setAttribute("aantalWekeninMaand", aantalWekeninMaand);
            session.setAttribute("aantalWekeninMaand", aantalWekeninMaand);
            session.setAttribute("maandenVanHetJaar", maandenVanHetJaar);
//            request.setAttribute("maandenVanHetJaar", maandenVanHetJaar);
            session.setAttribute("dagenVanMaandMiniKalender", dagenVanMaandMiniKalender);
//            request.setAttribute("dagenVanMaandMiniKalender", dagenVanMaandMiniKalender);
            String url = "/WEB-INF/MiniCalendar.jsp";
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
