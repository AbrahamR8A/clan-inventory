package com.example.claninventory.servlets;

import com.example.claninventory.beans.*;
import com.example.claninventory.daos.OrdenIngresoDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "OrdenIngresoServlet", value = "/OrdenIngresoServlet")
public class OrdenIngresoServlet extends HttpServlet {

    private OrdenIngresoDao ordenDao = new OrdenIngresoDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "pendientes";


        RequestDispatcher dispatcher;

        switch (action) {
            case "nueva":

                HttpSession session = request.getSession();
                Usuarios userLogueado = (Usuarios) session.getAttribute("usuario");
                if (userLogueado == null) {
                    response.sendRedirect("index.jsp");
                    return;
                }

                // Solo admin y coordinador pueden crear ordenes
                if (userLogueado.getRol().equals("administrador") || userLogueado.getRol().equals("coordinador")) {
                    List<Productos> listaProductos = ordenDao.listarProductosActivos();
                    request.setAttribute("listaProductos", listaProductos);
                    dispatcher = request.getRequestDispatcher("views/coordinador/nueva_orden_ingreso.jsp");
                    dispatcher.forward(request, response);
                } else {
                    response.sendRedirect("InicioDepositoServlet"); // Sin permisos
                }
                break;

            case "pendientes":
                // Para Deposito (y admin si quiere ver)
                List<OrdenIngreso> listaOrdenesPendientes = ordenDao.listarOrdenesPendientes();
                request.setAttribute("listaOrdenesPendientes", listaOrdenesPendientes);
                request.setAttribute("totalPendientes", listaOrdenesPendientes != null ? listaOrdenesPendientes.size() : 0);
                dispatcher = request.getRequestDispatcher("views/deposito/entradas_pendientes.jsp");
                dispatcher.forward(request, response);
                break;

            case "verificar":
                // Para Deposito: mostrar detalles de orden para verificar
                String idStr = request.getParameter("id");
                if (idStr != null) {
                    try {
                        int id = Integer.parseInt(idStr);
                        OrdenIngreso orden = ordenDao.obtenerOrdenIngreso(id);
                        if(orden != null) {
                            List<DetalleOrdenIngreso> detalles = ordenDao.obtenerDetallesPorOrden(id);
                            request.setAttribute("ordenIngreso", orden);
                            request.setAttribute("detalleOrdenIngreso", detalles);
                            dispatcher = request.getRequestDispatcher("views/deposito/verificacion_ingreso.jsp");
                            dispatcher.forward(request, response);
                        } else {
                            response.sendRedirect("OrdenIngresoServlet?action=pendientes");
                        }
                    } catch (NumberFormatException e) {
                        response.sendRedirect("OrdenIngresoServlet?action=pendientes");
                    }
                } else {
                    response.sendRedirect("OrdenIngresoServlet?action=pendientes");
                }
                break;

            default:
                response.sendRedirect("OrdenIngresoServlet?action=pendientes");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect("OrdenIngresoServlet?action=pendientes");
            return;
        }

        HttpSession session = request.getSession();
        Usuarios userLogueado = (Usuarios) session.getAttribute("usuario");
        if (userLogueado == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        switch (action) {
            case "registrar":
                // Creado por admin/coord
                String[] productosSeleccionados = request.getParameterValues("productosSeleccionados");
                
                if (productosSeleccionados != null && productosSeleccionados.length > 0) {
                    String fechaEsperadaStr = request.getParameter("fechaEsperada");
                    String proveedor = request.getParameter("proveedor");
                    String observaciones = request.getParameter("observaciones");

                    OrdenIngreso orden = new OrdenIngreso();
                    orden.setCreador(userLogueado);
                    orden.setProveedor(proveedor);
                    orden.setObservaciones(observaciones);
                    try {
                        if (fechaEsperadaStr != null && !fechaEsperadaStr.isEmpty()) {
                            orden.setFechaEsperada(java.sql.Date.valueOf(fechaEsperadaStr));
                        }
                    } catch (IllegalArgumentException ignored) {}
                    
                    List<DetalleOrdenIngreso> detalles = new ArrayList<>();
                    for (String idProdStr : productosSeleccionados) {
                        try {
                            int idProd = Integer.parseInt(idProdStr);
                            String cantStr = request.getParameter("cantidadEsperada_" + idProd);
                            if (cantStr != null) {
                                int cantidad = Integer.parseInt(cantStr);
                                if (cantidad > 0) {
                                    Productos p = new Productos();
                                    p.setIdProductos(idProd);
                                    
                                    DetalleOrdenIngreso d = new DetalleOrdenIngreso();
                                    d.setProducto(p);
                                    d.setCantidadEsperada(cantidad);
                                    detalles.add(d);
                                }
                            }
                        } catch (NumberFormatException ignored) {}
                    }
                    
                    if (!detalles.isEmpty()) {
                        boolean exito = ordenDao.registrarOrdenIngreso(orden, detalles);
                        // Redirigir según rol (Admin -> InicioAdminServlet, Coord -> InicioCoordinadorServlet)
                        String redirectBase = userLogueado.getRol().equals("administrador") ? "InicioAdminServlet" : "InicioCoordinadorServlet";
                        response.sendRedirect(redirectBase + "?ordenCreada=" + (exito ? "true" : "false"));
                    } else {
                        response.sendRedirect("OrdenIngresoServlet?action=nueva&error=empty");
                    }
                } else {
                    response.sendRedirect("OrdenIngresoServlet?action=nueva&error=invalid");
                }
                break;

            case "confirmarRecepcion":
                // Llenado por Depósito
                String idOrdenStr = request.getParameter("idOrdenIngreso");
                String[] idDetallesStr = request.getParameterValues("idDetalle");
                
                if (idOrdenStr != null && idDetallesStr != null && idDetallesStr.length > 0) {
                    try {
                        int idOrden = Integer.parseInt(idOrdenStr);
                        OrdenIngreso orden = new OrdenIngreso();
                        orden.setIdOrdenesIngreso(idOrden);
                        orden.setVerificador(userLogueado);
                        boolean tieneObservaciones = false;
                        
                        List<DetalleOrdenIngreso> detalles = new ArrayList<>();
                        for (String idDetStr : idDetallesStr) {
                            int idDetalle = Integer.parseInt(idDetStr);
                            
                            String recibidaStr = request.getParameter("cantidadRecibida_" + idDetalle);
                            String esperadaStr = request.getParameter("cantidadEsperada_" + idDetalle);
                            String obsStr = request.getParameter("observacion_" + idDetalle);
                            String idProdStr = request.getParameter("idProducto_" + idDetalle);
                            
                            int cantRecibida = (recibidaStr != null && !recibidaStr.isEmpty()) ? Integer.parseInt(recibidaStr) : 0;
                            int cantEsperada = (esperadaStr != null && !esperadaStr.isEmpty()) ? Integer.parseInt(esperadaStr) : cantRecibida;
                            
                            if (cantRecibida != cantEsperada || (obsStr != null && !obsStr.trim().isEmpty())) {
                                tieneObservaciones = true;
                            }
                            
                            DetalleOrdenIngreso d = new DetalleOrdenIngreso();
                            d.setIdDetallesOrden(idDetalle);
                            d.setCantidadRecibida(cantRecibida);
                            
                            if(idProdStr != null && !idProdStr.isEmpty()) {
                                Productos p = new Productos();
                                p.setIdProductos(Integer.parseInt(idProdStr));
                                d.setProducto(p);
                            }
                            
                            detalles.add(d);
                        }
                        
                        orden.setObservaciones(tieneObservaciones ? "Hay diferencias o notas en la recepción" : "Todo conforme");
                        
                        boolean exito = ordenDao.procesarVerificacion(orden, detalles, tieneObservaciones);
                        response.sendRedirect("OrdenIngresoServlet?action=pendientes&recepcion=" + (exito ? "success" : "error"));
                        
                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                        response.sendRedirect("OrdenIngresoServlet?action=pendientes&error=invalid_data");
                    }
                } else {
                    response.sendRedirect("OrdenIngresoServlet?action=pendientes&error=missing_data");
                }
                break;
                
            default:
                response.sendRedirect("OrdenIngresoServlet?action=pendientes");
                break;
        }
    }
}
