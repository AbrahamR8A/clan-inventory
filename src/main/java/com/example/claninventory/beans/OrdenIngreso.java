package com.example.claninventory.beans;

import java.sql.Timestamp;

public class OrdenIngreso {
    private int idOrdenesIngreso;
    private Timestamp fechaRegistro;
    private Timestamp fechaVerificacion;
    private String estado;
    private String observaciones;
    private Usuarios creador;
    private Usuarios verificador;
    private java.sql.Date fechaEsperada;
    private String proveedor;

    // Getters and Setters
    public int getIdOrdenesIngreso() {
        return idOrdenesIngreso;
    }

    public void setIdOrdenesIngreso(int idOrdenesIngreso) {
        this.idOrdenesIngreso = idOrdenesIngreso;
    }

    public Timestamp getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Timestamp fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    public Timestamp getFechaVerificacion() {
        return fechaVerificacion;
    }

    public void setFechaVerificacion(Timestamp fechaVerificacion) {
        this.fechaVerificacion = fechaVerificacion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public Usuarios getCreador() {
        return creador;
    }

    public void setCreador(Usuarios creador) {
        this.creador = creador;
    }

    public Usuarios getVerificador() {
        return verificador;
    }

    public void setVerificador(Usuarios verificador) {
        this.verificador = verificador;
    }

    public java.sql.Date getFechaEsperada() {
        return fechaEsperada;
    }

    public void setFechaEsperada(java.sql.Date fechaEsperada) {
        this.fechaEsperada = fechaEsperada;
    }

    public String getProveedor() {
        return proveedor;
    }

    public void setProveedor(String proveedor) {
        this.proveedor = proveedor;
    }
}
