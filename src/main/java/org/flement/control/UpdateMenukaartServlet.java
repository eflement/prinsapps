package org.flement.control;

import org.flement.model.DagMaandKalender;
import org.flement.model.DagMenukaart;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.GregorianCalendar;

@WebServlet(name = "UpdateMenukaartServlet", urlPatterns = "/updatemenucard")
public class UpdateMenukaartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int year = 0;    // gebruikt om door te geven aan JSP (welk jaar we zijn)
        int month = 0;   // gebruikt om door te geven aan JSP (welke maand we zijn)
        int day = 0;     // gebruikt om door te geven aan JSP (welke maand we zijn)
        int dYear = 0;   // gebruikt om in databank te steken
        int dMonth = 0;  // gebruikt om in databank te steken
        int dDay = 0;    // gebruikt om in databank te steken
        String dagMenu = "";
        String dagCode = "";
        String sqlStatement = "";

        if ((request.getParameter("year") != null) & (request.getParameter("month") != null)) {
            year = Integer.parseInt(request.getParameter("year"));
            month = Integer.parseInt(request.getParameter("month"));
        } else {
            Calendar datumVanVandaag = new GregorianCalendar();
            year = datumVanVandaag.get(Calendar.YEAR);
            month = datumVanVandaag.get(Calendar.MONTH) + 1;
        }

        String[] maandenVanHetJaar = {"Januari", "Februari", "Maart", "April", "Mei", "Juni", "Juli",
                "Augustus", "September", "Oktober", "November", "December"};
        String[] dagenVanDeWeek = {"maandag", "dinsdag", "woensdag", "donderdag", "vrijdag", "zaterdag", "zondag"};
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


        try {
            // get a connection
            String dbURL = "jdbc:mysql://localhost:3306/pprinsappss";
            String username = "pprinsappss";
            String password = "pprinsappss";
            try {
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
            // we halen de lijst van de parameters op
            Enumeration<String> params = (Enumeration<String>) request.getParameterNames();
            String parameter;
            while (params.hasMoreElements()) {
                parameter = params.nextElement();
                if ("year".equals(parameter)) year = Integer.parseInt(request.getParameter(parameter));
                else if ("month".equals(parameter)) month = Integer.parseInt(request.getParameter(parameter));
                else {  // het betreft een menuitem, we steken de inhoud ervan in de databank
                    dDay = Integer.parseInt(parameter.substring(1, 3));
                    dMonth = Integer.parseInt(parameter.substring(3, 5));
                    dYear = Integer.parseInt(parameter.substring(5, 9));
                    dagMenu = request.getParameter(parameter);
                    sqlStatement = "";
                    if (!"".equals(dagMenu)) {
                        sqlStatement = "insert into menucards (year,month,day,menuitem) values(" +
                                dYear + "," +
                                dMonth + "," +
                                dDay + "," +
                                "'" + dagMenu + "'" +
                                ") on duplicate key update menuitem = '"
                                + dagMenu
                                + "';";

                    } else {
                        sqlStatement = "delete from menucards where year=" + dYear + " and month=" + dMonth + " and day=" + dDay + ";";
                    }
                    rowsUpdated = statement.executeUpdate(sqlStatement);
                }
            }
            // dan bouwen we ons nieuwmaandoverzicht op

            ArrayList<DagMenukaart> dagenMenukaart = new ArrayList<DagMenukaart>();
            for (int teller = 1; teller <= 7 * aantalWekeninMaand; teller++) {     //van maandag tot vrijdag
                int dagInWeek = ((teller - 1) % 7) + 1;
                String sDatum = "";
                if (dagInWeek != 3 & dagInWeek < 6) {  // geen woensdagen en geen week-ends
                    dagMenu = "";
                    if (teller < eersteDagMaandStartOpDag) {
                        // dagen vorige maand
                        dagCode = "0";
                        day = aantalDagenVorigeMaand + 1 - eersteDagMaandStartOpDag + teller;
                        dDay = day;
                        sDatum = Integer.toString(day);
                        if (sDatum.length() < 2) sDatum = "0" + sDatum;
                        if (month == 1) {
                            sDatum = sDatum + "/12/" + Integer.toString(year-1);
                            dMonth = 12;
                            dYear = year - 1;
                        }
                        if (month > 1 & month <= 10) {
                            sDatum = sDatum + "/" + "0" + Integer.toString(month - 1)+ "/" + Integer.toString(year);
                            dMonth = month - 1;
                            dYear = year;
                        }
                        if (month == 11 || month == 12) {
                            sDatum = sDatum + "/" + Integer.toString(month -1 ) + "/" + Integer.toString(year);
                            dMonth = month - 1;
                            dYear = year;
                        }
                    } else if (teller > eersteDagMaandStartOpDag + aantalDagenInMaand - 1) {
                        // dagen volgende maand
                        dagCode = "0";
                        day = teller - eersteDagMaandStartOpDag - aantalDagenInMaand + 1;
                        dDay = day;
                        sDatum = Integer.toString(day);
                        if (sDatum.length() < 2) sDatum = "0" + sDatum;
                        if (month == 12 ) {
                            sDatum = sDatum + "/01/" + Integer.toString(year + 1);
                            dMonth = 1;
                            dYear = year + 1;
                        }
                        if (month < 9 ) {
                            sDatum = sDatum + "/0" + Integer.toString(month + 1) + "/" + Integer.toString(year);
                            dMonth = month + 1;
                            dYear = year;
                        }
                        if (month >= 9 & month <= 11) {
                            sDatum = sDatum + "/" + Integer.toString(month + 1) + "/" + Integer.toString(year);
                            dMonth = month + 1;
                            dYear = year;
                        }
                    } else {
                        // dagen van deze maand
                        dagCode = "1";
                        day = teller - eersteDagMaandStartOpDag + 1;
                        sDatum = Integer.toString(day);
                        dDay = day;
                        dMonth = month;
                        dYear = year;
                        if (sDatum.length() < 2) sDatum = "0" + sDatum;
                        if (month <10) sDatum = sDatum + "/0" + Integer.toString(month) + "/" + Integer.toString(year);
                        if (month > 9) sDatum = sDatum + "/" + Integer.toString(month) + "/" + Integer.toString(year);
                    }
                    sqlStatement = "select menuitem from menucards where year=" + dYear + " and month=" + dMonth + " and day=" + dDay;
                    resultSet = statement.executeQuery(sqlStatement);
                    while (resultSet.next()) {
                        dagMenu = resultSet.getString("menuitem");
                    }
                    DagMenukaart dagMenukaart = new DagMenukaart(dagenVanDeWeek[dagInWeek - 1], sDatum, dagMenu,dagCode);
                    dagenMenukaart.add(dagMenukaart);
                }      // geen woensdagen

            }  // end for
            if (eersteDagMaandStartOpDag > 6) {         // we laten de eerste week vallen want eerste dag valt in weekend
                for (int i = 0; i < 4; i++) {
                    dagenMenukaart.remove(0);
                }
                aantalWekeninMaand = aantalWekeninMaand - 1;
            }
            int nextYear=0;
            int nextMonth=0;
            int previousYear=0;
            int previousMonth=0;
            if (month == 1) {
                previousMonth = 12;
                previousYear = year - 1;
                nextMonth = month +1;
                nextYear = year +1;
            }
            if (month == 12){
                previousMonth = month - 1;
                previousYear = year - 1;
                nextMonth = 1;
                nextYear = year + 1;
            }
            if (month > 1 & month < 12){
                previousMonth = month - 1;
                previousYear = year;
                nextMonth = month + 1;
                nextYear = year;
            }
            resultSet.close();
            statement.close();
            connection.close();
            String action = request.getParameter("action");
            request.setAttribute("action",action);
            request.setAttribute("previousMonth",previousMonth);
            request.setAttribute("previousYear",previousYear);
            request.setAttribute("nextMonth",nextMonth);
            request.setAttribute("nextYear",nextYear);
            request.setAttribute("year", year);
            request.setAttribute("month", month);
            request.setAttribute("aantalWekeninMaand", aantalWekeninMaand);
            request.setAttribute("maandenVanHetJaar", maandenVanHetJaar);
            request.setAttribute("dagenMenukaart", dagenMenukaart);
            String url = "/WEB-INF/EditMenukaart.jsp";
            RequestDispatcher dispatcher = request.getRequestDispatcher(url);
            dispatcher.forward(request, response);
        } catch (SQLException e)

        {
            String DBerror = e.getMessage();
            request.setAttribute("DBError", DBerror);
            String url = "/WEB-INF/DBError.jsp";
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
            dispatcher.forward(request, response);
        }

    }
}
