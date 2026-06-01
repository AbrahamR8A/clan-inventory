package com.example.claninventory.beans;

import java.sql.Timestamp;

public class Solicitudes {
    private int idSolicitudes;
    private String proposito;
    private String estado;
    private Timestamp fechaSolicitud;
    private String comentarioRechazo;
    private Timestamp fechaEntrega;
    private Timestamp fechaRevision;

    // Relaciones
    private Usuarios solicitante; // Para saber quién hizo el pedido
    private Usuarios coordinador; // Para saber quién la aprobó/rechazó

    // Getters y Setters
    public int getIdSolicitudes() { return idSolicitudes; }
    public void setIdSolicitudes(int idSolicitudes) { this.idSolicitudes = idSolicitudes; }

    public String getProposito() { return proposito; }
    public void setProposito(String proposito) { this.proposito = proposito; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public Timestamp getFechaSolicitud() { return fechaSolicitud; }
    public void setFechaSolicitud(Timestamp fechaSolicitud) { this.fechaSolicitud = fechaSolicitud; }

    public String getComentarioRechazo() { return comentarioRechazo; }
    public void setComentarioRechazo(String comentarioRechazo) { this.comentarioRechazo = comentarioRechazo; }

    public Timestamp getFechaEntrega() { return fechaEntrega; }
    public void setFechaEntrega(Timestamp fechaEntrega) { this.fechaEntrega = fechaEntrega; }

    public Timestamp getFechaRevision() { return fechaRevision; }
    public void setFechaRevision(Timestamp fechaRevision) { this.fechaRevision = fechaRevision; }

    public Usuarios getSolicitante() { return solicitante; }
    public void setSolicitante(Usuarios solicitante) { this.solicitante = solicitante; }

    public Usuarios getCoordinador() { return coordinador; }
    public void setCoordinador(Usuarios coordinador) { this.coordinador = coordinador; }
}