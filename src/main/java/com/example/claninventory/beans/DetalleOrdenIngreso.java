package com.example.claninventory.beans;

public class DetalleOrdenIngreso {
    private int idDetallesOrden;
    private OrdenIngreso ordenIngreso;
    private Productos producto;
    private int cantidadEsperada;
    private Integer cantidadRecibida;

    // Getters and Setters
    public int getIdDetallesOrden() {
        return idDetallesOrden;
    }

    public void setIdDetallesOrden(int idDetallesOrden) {
        this.idDetallesOrden = idDetallesOrden;
    }

    public OrdenIngreso getOrdenIngreso() {
        return ordenIngreso;
    }

    public void setOrdenIngreso(OrdenIngreso ordenIngreso) {
        this.ordenIngreso = ordenIngreso;
    }

    public Productos getProducto() {
        return producto;
    }

    public void setProducto(Productos producto) {
        this.producto = producto;
    }

    public int getCantidadEsperada() {
        return cantidadEsperada;
    }

    public void setCantidadEsperada(int cantidadEsperada) {
        this.cantidadEsperada = cantidadEsperada;
    }

    public Integer getCantidadRecibida() {
        return cantidadRecibida;
    }

    public void setCantidadRecibida(Integer cantidadRecibida) {
        this.cantidadRecibida = cantidadRecibida;
    }
}
