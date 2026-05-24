package com.example.claninventory.beans;

/**
 * Representa una solicitud vista desde el rol Solicitante.
 * Se usa en la "Tabla de Actividad Reciente" (Inicio) y en la
 * vista "Detalle de Solicitud".
 */
public class SolicitudSolicitante {

    private int idSolicitudes;
    private String proposito;
    private String estado;
    private String fechaSolicitud;     // ya viene formateada desde el DAO
    private String comentarioRechazo;
    private int idSolicitante;
    /** Categorías de los productos de la solicitud, separadas por "||". */
    private String categorias;

    public SolicitudSolicitante() {
    }

    // ─── Getters y Setters ───────────────────────────────────────────────────

    public int getIdSolicitudes() {
        return idSolicitudes;
    }

    public void setIdSolicitudes(int idSolicitudes) {
        this.idSolicitudes = idSolicitudes;
    }

    public String getProposito() {
        return proposito;
    }

    public void setProposito(String proposito) {
        this.proposito = proposito;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getFechaSolicitud() {
        return fechaSolicitud;
    }

    public void setFechaSolicitud(String fechaSolicitud) {
        this.fechaSolicitud = fechaSolicitud;
    }

    public String getComentarioRechazo() {
        return comentarioRechazo;
    }

    public void setComentarioRechazo(String comentarioRechazo) {
        this.comentarioRechazo = comentarioRechazo;
    }

    public int getIdSolicitante() {
        return idSolicitante;
    }

    public void setIdSolicitante(int idSolicitante) {
        this.idSolicitante = idSolicitante;
    }

    public String getCategorias() {
        return categorias;
    }

    public void setCategorias(String categorias) {
        this.categorias = categorias;
    }

    // ─── Métodos de apoyo para la tabla de Actividad Reciente ───────────────

    /** Primera categoría de la solicitud (la que se muestra en texto). */
    public String getCategoriaPrincipal() {
        if (categorias == null || categorias.trim().isEmpty()) return "Sin categoría";
        return categorias.split("\\|\\|")[0];
    }

    /** Cantidad de categorías adicionales (para el badge "+N"). */
    public int getCategoriasExtra() {
        if (categorias == null || categorias.trim().isEmpty()) return 0;
        int total = categorias.split("\\|\\|").length;
        return total > 1 ? total - 1 : 0;
    }

    /** Todas las categorías en un texto legible (para el tooltip del badge). */
    public String getCategoriasTexto() {
        if (categorias == null) return "";
        return categorias.replace("||", ", ");
    }

    /** Etiqueta legible del estado, con la primera letra en mayúscula. */
    public String getEstadoLabel() {
        if (estado == null || estado.isEmpty()) return "";
        return estado.substring(0, 1).toUpperCase() + estado.substring(1);
    }
}
