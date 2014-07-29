package org.flement.model;

public class DagMenukaart {

    String dagNaam;
    String dagDatum;
    String dagMenu;
    String dagCode;

    public DagMenukaart(String dagNaam, String dagDatum, String dagMenu, String dagCode) {
        this.dagNaam = dagNaam;
        this.dagDatum = dagDatum;
        this.dagMenu = dagMenu;
        this.dagCode = dagCode;
    }

    public String getDagNaam() {
        return dagNaam;
    }

    public void setDagNaam(String dagNaam) {
        this.dagNaam = dagNaam;
    }

    public String getDagDatum() {
        return dagDatum;
    }

    public void setDagDatum(String dagDatum) {
        this.dagDatum = dagDatum;
    }

    public String getDagMenu() {
        return dagMenu;
    }

    public void setDagMenu(String dagMenu) {
        this.dagMenu = dagMenu;
    }

    public String getDagCode() {
        return dagCode;
    }

    public void setDagCode(String dagCode) {
        this.dagCode = dagCode;
    }
}
