package org.flement.model;

public class DagMaandKalender {

    public DagMaandKalender(String dagNaam, String dagNummer, String dagActiviteit) {
        this.dagNaam = dagNaam;
        this.dagNummer = dagNummer;
        this.dagActiviteit = dagActiviteit;
    }

    String dagNaam;
    String dagNummer;
    String dagActiviteit;

    public String getDagNaam() {
        return dagNaam;
    }

    public void setDagNaam(String dagNaam) {
        this.dagNaam = dagNaam;
    }

    public String getDagNummer() {
        return dagNummer;
    }

    public void setDagNummer(String dagNummer) {
        this.dagNummer = dagNummer;
    }

    public String getDagActiviteit() {
        return dagActiviteit;
    }

    public void setDagActiviteit(String dagActiviteit) {
        this.dagActiviteit = dagActiviteit;
    }

}
