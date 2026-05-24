package com.example.claninventory.beans;

/**
 * DTO con los 4 indicadores que se muestran en las tarjetas superiores
 * de la vista Inicio del solicitante: solicitudes pendientes, aprobadas,
 * entregadas y rechazadas (del propio solicitante).
 */
public class KpiSolicitante {

    private int pendientes;
    private int aprobadas;
    private int entregadas;
    private int rechazadas;

    public KpiSolicitante() {
    }

    public int getPendientes() {
        return pendientes;
    }

    public void setPendientes(int pendientes) {
        this.pendientes = pendientes;
    }

    public int getAprobadas() {
        return aprobadas;
    }

    public void setAprobadas(int aprobadas) {
        this.aprobadas = aprobadas;
    }

    public int getEntregadas() {
        return entregadas;
    }

    public void setEntregadas(int entregadas) {
        this.entregadas = entregadas;
    }

    public int getRechazadas() {
        return rechazadas;
    }

    public void setRechazadas(int rechazadas) {
        this.rechazadas = rechazadas;
    }
}
