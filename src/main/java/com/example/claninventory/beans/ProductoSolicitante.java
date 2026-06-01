package com.example.claninventory.beans;

/**
 * Representa un producto disponible que el solicitante puede ver y agregar
 * a la cajita en la vista "Nueva Solicitud".
 */
public class ProductoSolicitante {

    private int idProductos;
    private String codigo;
    private String nombre;
    private String descripcion;
    private int stockActual;
    private int stockBajo;
    private int stockCritico;
    private int idCategorias;
    private String nombreCategoria;
    private String siglaCategoria;

    public ProductoSolicitante() {
    }

    // ─── Getters y Setters ───────────────────────────────────────────────────

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

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getStockActual() {
        return stockActual;
    }

    public void setStockActual(int stockActual) {
        this.stockActual = stockActual;
    }

    public int getStockBajo() {
        return stockBajo;
    }

    public void setStockBajo(int stockBajo) {
        this.stockBajo = stockBajo;
    }

    public int getStockCritico() {
        return stockCritico;
    }

    public void setStockCritico(int stockCritico) {
        this.stockCritico = stockCritico;
    }

    public int getIdCategorias() {
        return idCategorias;
    }

    public void setIdCategorias(int idCategorias) {
        this.idCategorias = idCategorias;
    }

    public String getNombreCategoria() {
        return nombreCategoria;
    }

    public void setNombreCategoria(String nombreCategoria) {
        this.nombreCategoria = nombreCategoria;
    }

    public String getSiglaCategoria() {
        return siglaCategoria;
    }

    public void setSiglaCategoria(String siglaCategoria) {
        this.siglaCategoria = siglaCategoria;
    }

    // ─── Métodos de apoyo ────────────────────────────────────────────────────

    /** SKU mostrado al solicitante, por ejemplo "SKU: L-0101". */
    public String getSku() {
        return "SKU: " + siglaCategoria + "-" + codigo;
    }

    /** Estado del stock: "critico", "bajo" u "optimo". Sirve para el color del badge. */
    public String getEstadoStock() {
        if (stockActual <= stockCritico) return "critico";
        if (stockActual <= stockBajo)    return "bajo";
        return "optimo";
    }
}
