package com.example.claninventory.beans;

public class Detalles {
    private int idDetalles;
    private int cantidad;

    // Relaciones
    private Solicitudes solicitud;
    private Productos producto;

    // Getters y Setters
    public int getIdDetalles() {
        return idDetalles;
    }

    public void setIdDetalles(int idDetalles) {
        this.idDetalles = idDetalles;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public Solicitudes getSolicitud() {
        return solicitud;
    }

    public void setSolicitud(Solicitudes solicitud) {
        this.solicitud = solicitud;
    }

    public Productos getProducto() {
        return producto;
    }

    public void setProducto(Productos producto) {
        this.producto = producto;
    }
}