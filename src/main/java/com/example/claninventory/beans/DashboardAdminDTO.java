package com.example.claninventory.beans;

public class DashboardAdminDTO {
    private int usuariosRegistrados;
    private int solicitudesAprobadas;
    private int solicitudesPendientes;
    private int solicitudesRechazadas;

    public DashboardAdminDTO() {
    }

    public int getUsuariosRegistrados() {
        return usuariosRegistrados;
    }

    public void setUsuariosRegistrados(int usuariosRegistrados) {
        this.usuariosRegistrados = usuariosRegistrados;
    }

    public int getSolicitudesAprobadas() {
        return solicitudesAprobadas;
    }

    public void setSolicitudesAprobadas(int solicitudesAprobadas) {
        this.solicitudesAprobadas = solicitudesAprobadas;
    }

    public int getSolicitudesPendientes() {
        return solicitudesPendientes;
    }

    public void setSolicitudesPendientes(int solicitudesPendientes) {
        this.solicitudesPendientes = solicitudesPendientes;
    }

    public int getSolicitudesRechazadas() {
        return solicitudesRechazadas;
    }

    public void setSolicitudesRechazadas(int solicitudesRechazadas) {
        this.solicitudesRechazadas = solicitudesRechazadas;
    }
}
