package com.example.claninventory.beans;

/**
 * Representa una línea de detalle de una solicitud.
 * Se usa en dos momentos:
 *   1. Como ítem de la "cajita" (carrito) guardada en la sesión.
 *   2. Como fila de "Materiales solicitados" al ver el detalle de una solicitud.
 */
public class DetalleSolicitante {

    private int idDetalles;
    private int idSolicitudes;
    private int idProductos;
    private String codigo;
    private String siglaCategoria;
    private String nombre;
    private String categoria;
    private int stockActual;
    private int cantidad;

    public DetalleSolicitante() {
    }

    // ─── Getters y Setters ───────────────────────────────────────────────────

    public int getIdDetalles() {
        return idDetalles;
    }

    public void setIdDetalles(int idDetalles) {
        this.idDetalles = idDetalles;
    }

    public int getIdSolicitudes() {
        return idSolicitudes;
    }

    public void setIdSolicitudes(int idSolicitudes) {
        this.idSolicitudes = idSolicitudes;
    }

    public int getIdProductos() {
        return idProductos;
    }

    public void setIdProductos(int idProductos) {
        this.idProductos = idProductos;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getSiglaCategoria() {
        return siglaCategoria;
    }

    public void setSiglaCategoria(String siglaCategoria) {
        this.siglaCategoria = siglaCategoria;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public int getStockActual() {
        return stockActual;
    }

    public void setStockActual(int stockActual) {
        this.stockActual = stockActual;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    /** SKU mostrado en las tablas, por ejemplo "SKU: L-0101". */
    public String getSku() {
        return "SKU: " + siglaCategoria + "-" + codigo;
    }
}
