package com.example.claninventory.beans;

public class Productos {
    private int idProductos;
    private String codigo;
    private String nombre;
    private int stockActual;
    private int stockBajo;
    private int stockCritico;
    private byte[] imagen;
    private String descripcion;
    private int activo;
    private int idUsuarios;
    private int idCategorias;
    private String nombreCategoria;
    private String siglaCategoria;

    public int getIdProductos() { return idProductos; }
    public void setIdProductos(int idProductos) { this.idProductos = idProductos; }
    public String getCodigo() { return codigo; }
    public void setCodigo(String codigo) { this.codigo = codigo; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public int getStockActual() { return stockActual; }
    public void setStockActual(int stockActual) { this.stockActual = stockActual; }
    public int getStockBajo() { return stockBajo; }
    public void setStockBajo(int stockBajo) { this.stockBajo = stockBajo; }
    public int getStockCritico() { return stockCritico; }
    public void setStockCritico(int stockCritico) { this.stockCritico = stockCritico; }
    public byte[] getImagen() { return imagen; }
    public void setImagen(byte[] imagen) { this.imagen = imagen; }
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    public int getActivo() { return activo; }
    public void setActivo(int activo) { this.activo = activo; }
    public int getIdUsuarios() { return idUsuarios; }
    public void setIdUsuarios(int idUsuarios) { this.idUsuarios = idUsuarios; }
    public int getIdCategorias() { return idCategorias; }
    public void setIdCategorias(int idCategorias) { this.idCategorias = idCategorias; }
    public String getNombreCategoria() { return nombreCategoria; }
    public void setNombreCategoria(String nombreCategoria) { this.nombreCategoria = nombreCategoria; }
    public String getSiglaCategoria() { return siglaCategoria; }
    public void setSiglaCategoria(String siglaCategoria) { this.siglaCategoria = siglaCategoria; }

    /** Retorna "critico", "bajo" u "optimo" segun los umbrales configurados. */
    public String getEstadoStock() {
        if (stockActual <= stockCritico) return "critico";
        if (stockActual <= stockBajo)    return "bajo";
        return "optimo";
    }
}
