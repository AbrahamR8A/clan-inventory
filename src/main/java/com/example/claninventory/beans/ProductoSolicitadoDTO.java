package com.example.claninventory.beans;

/**
 * DTO usado para alimentar el gráfico de barras "Productos más solicitados"
 * de la vista Reportes. Cada objeto es un producto y la cantidad total
 * solicitada durante el mes y año seleccionados.
 */
public class ProductoSolicitadoDTO {

    private String producto;
    private int cantidad;

    public ProductoSolicitadoDTO() {
    }

    public ProductoSolicitadoDTO(String producto, int cantidad) {
        this.producto = producto;
        this.cantidad = cantidad;
    }

    public String getProducto() {
        return producto;
    }

    public void setProducto(String producto) {
        this.producto = producto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }
}
