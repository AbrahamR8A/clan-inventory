package com.example.claninventory.beans;

/**
 * Representa una fila de la "Tabla de Consumo del Mes" de la vista Reportes.
 * Cada objeto corresponde a un producto con su movimiento (entradas y salidas)
 * dentro del mes y año seleccionados en el filtro.
 */
public class ReporteConsumo {

    private int idProductos;
    private String codigo;
    private String producto;
    private String categoria;
    private int stockActual;     // stock al consultar (fin de periodo)
    private int entradaMes;      // SUM de movimientos tipo 'entrada' en el mes
    private int salidaMes;       // SUM de movimientos tipo 'salida' en el mes

    public ReporteConsumo() {
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

    public String getProducto() {
        return producto;
    }

    public void setProducto(String producto) {
        this.producto = producto;
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

    public int getEntradaMes() {
        return entradaMes;
    }

    public void setEntradaMes(int entradaMes) {
        this.entradaMes = entradaMes;
    }

    public int getSalidaMes() {
        return salidaMes;
    }

    public void setSalidaMes(int salidaMes) {
        this.salidaMes = salidaMes;
    }

    /**
     * Stock inicial del periodo.
     * Se reconstruye a partir del stock actual: se le restan las entradas
     * y se le suman las salidas registradas durante el mes.
     *   stockInicial = stockActual - entradaMes + salidaMes
     */
    public int getStockInicial() {
        return stockActual - entradaMes + salidaMes;
    }
}
