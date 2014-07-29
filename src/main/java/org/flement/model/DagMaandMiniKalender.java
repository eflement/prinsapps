package org.flement.model;

public class DagMaandMiniKalender {

    public DagMaandMiniKalender(String dagNummer, String dagCode, String dagBeschrijving) {
        this.dagNummer = dagNummer;
        this.dagCode = dagCode;
        this.dagBeschrijving = dagBeschrijving;
    }

    String dagNummer;
    String dagCode;
    String dagBeschrijving;


    // voor dagCode gebruiken we de volgende conventie :
    // 1 = dag van de vorige of volgende maand
    // 2 = dag van de maand zonder activiteiten
    // 3 = dag van de maadn met activiteiten
    // 4 = vandaag zonder actviteiten
    // 5 = vandaag met activiteiten


    public String getDagNummer() {
        return dagNummer;
    }

    public void setDagNummer(String dagNummer) {
        this.dagNummer = dagNummer;
    }

    public String getDagCode() {
        return dagCode;
    }

    public void setDagCode(String dagCode) {
        this.dagCode = dagCode;
    }

    public String getDagBeschrijving() {
        return dagBeschrijving;
    }

    public void setDagBeschrijving(String dagBeschrijving) {
        this.dagBeschrijving = dagBeschrijving;
    }

}
