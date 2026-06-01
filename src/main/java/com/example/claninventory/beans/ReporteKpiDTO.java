package com.example.claninventory.beans;

/**
 * DTO con los indicadores (KPIs) que se muestran en las 4 tarjetas
 * superiores de la vista Reportes: total de solicitudes, aprobadas,
 * entregadas y rechazadas dentro del mes y año seleccionados.
 */
public class ReporteKpiDTO {

    private int solicitudesTotales;
    private int solicitudesAprobadas;
    private int solicitudesEntregadas;
    private int solicitudesRechazadas;

    public ReporteKpiDTO() {
    }

    public int getSolicitudesTotales() {
        return solicitudesTotales;
    }

    public void setSolicitudesTotales(int solicitudesTotales) {
        this.solicitudesTotales = solicitudesTotales;
    }

    public int getSolicitudesAprobadas() {
        return solicitudesAprobadas;
    }

    public void setSolicitudesAprobadas(int solicitudesAprobadas) {
        this.solicitudesAprobadas = solicitudesAprobadas;
    }

    public int getSolicitudesEntregadas() {
        return solicitudesEntregadas;
    }

    public void setSolicitudesEntregadas(int solicitudesEntregadas) {
        this.solicitudesEntregadas = solicitudesEntregadas;
    }

    public int getSolicitudesRechazadas() {
        return solicitudesRechazadas;
    }

    public void setSolicitudesRechazadas(int solicitudesRechazadas) {
        this.solicitudesRechazadas = solicitudesRechazadas;
    }
}
