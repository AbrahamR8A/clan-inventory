package com.example.claninventory.beans;

/**
 * DTO usado para alimentar el gráfico de dona "Consumo por categoría"
 * de la vista Reportes. Cada objeto es una categoría y la cantidad total
 * consumida (solicitada) durante el mes y año seleccionados.
 */
public class ConsumoCategoriaDTO {

    private String categoria;
    private int cantidad;

    public ConsumoCategoriaDTO() {
    }

    public ConsumoCategoriaDTO(String categoria, int cantidad) {
        this.categoria = categoria;
        this.cantidad = cantidad;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }
}
