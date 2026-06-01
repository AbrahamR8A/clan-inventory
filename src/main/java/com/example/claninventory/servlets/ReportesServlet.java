package com.example.claninventory.servlets;

import com.example.claninventory.beans.ConsumoCategoriaDTO;
import com.example.claninventory.beans.ProductoSolicitadoDTO;
import com.example.claninventory.beans.ReporteConsumo;
import com.example.claninventory.beans.ReporteKpiDTO;
import com.example.claninventory.daos.ReportesDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

/**
 * Servlet de la vista Reportes.
 *
 * GET sin 'action'  -> carga KPIs, tabla de consumo y datos de los gráficos
 *                      desde la base de datos y reenvía al JSP.
 * GET action=exportar -> genera y descarga la tabla de consumo en un
 *                      archivo Excel (.xlsx) usando Apache POI.
 *
 * Filtros aceptados (parámetros): mes, anio, buscar.
 * Si no llegan 'mes' / 'anio' se usa el mes y año actuales.
 */
@WebServlet(name = "ReportesServlet", urlPatterns = {"/ReportesServlet"})
public class ReportesServlet extends HttpServlet {

    private static final String[] NOMBRE_MES = {
            "", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
            "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"
    };

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // ── Resolver el periodo (mes / año). Por defecto el periodo actual ────
        Calendar hoy = Calendar.getInstance();
        int mes  = parseIntOr(request.getParameter("mes"),  hoy.get(Calendar.MONTH) + 1);
        int anio = parseIntOr(request.getParameter("anio"), hoy.get(Calendar.YEAR));
        String buscar = request.getParameter("buscar");

        ReportesDao dao = new ReportesDao();

        // ── Exportar a Excel ─────────────────────────────────────────────────
        if ("exportar".equals(request.getParameter("action"))) {
            ArrayList<ReporteConsumo> datos = dao.listarConsumoMensual(mes, anio, buscar);
            exportarExcel(response, datos, mes, anio);
            return;
        }

        // ── Carga normal de la vista ─────────────────────────────────────────
        ReporteKpiDTO kpis = dao.obtenerKpis(mes, anio);
        ArrayList<ReporteConsumo> consumo = dao.listarConsumoMensual(mes, anio, buscar);
        List<ProductoSolicitadoDTO> masSolicitados = dao.obtenerProductosMasSolicitados(mes, anio);
        List<ConsumoCategoriaDTO> consumoCategoria = dao.obtenerConsumoPorCategoria(mes, anio);

        // Datos para la tabla y las tarjetas
        request.setAttribute("kpis", kpis);
        request.setAttribute("listaConsumo", consumo);

        // Datos en formato JSON para los gráficos (Chart.js)
        request.setAttribute("barLabels",   toJsonLabels(extraerProductos(masSolicitados)));
        request.setAttribute("barData",     toJsonData(extraerCantidadesProd(masSolicitados)));
        request.setAttribute("donutLabels", toJsonLabels(extraerCategorias(consumoCategoria)));
        request.setAttribute("donutData",   toJsonData(extraerCantidadesCat(consumoCategoria)));

        // Devolver los filtros para que el formulario conserve la selección
        request.setAttribute("mesActual", mes);
        request.setAttribute("anioActual", anio);
        request.setAttribute("busquedaActual", buscar);

        request.getRequestDispatcher("/views/administrador/Reportes_administrador.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    // ─── Exportación a Excel con Apache POI ──────────────────────────────────

    private void exportarExcel(HttpServletResponse response,
                               List<ReporteConsumo> datos,
                               int mes, int anio) throws IOException {

        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Consumo del Mes");

            // ── Estilos ──────────────────────────────────────────────────────
            // Título
            Font fuenteTitulo = workbook.createFont();
            fuenteTitulo.setBold(true);
            fuenteTitulo.setFontHeightInPoints((short) 14);
            fuenteTitulo.setColor(IndexedColors.WHITE.getIndex());
            CellStyle estiloTitulo = workbook.createCellStyle();
            estiloTitulo.setFont(fuenteTitulo);
            estiloTitulo.setFillForegroundColor(IndexedColors.INDIGO.getIndex());
            estiloTitulo.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            estiloTitulo.setAlignment(HorizontalAlignment.CENTER);

            // Encabezado de columnas
            Font fuenteHeader = workbook.createFont();
            fuenteHeader.setBold(true);
            fuenteHeader.setColor(IndexedColors.WHITE.getIndex());
            CellStyle estiloHeader = workbook.createCellStyle();
            estiloHeader.setFont(fuenteHeader);
            estiloHeader.setFillForegroundColor(IndexedColors.GREY_50_PERCENT.getIndex());
            estiloHeader.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            estiloHeader.setAlignment(HorizontalAlignment.CENTER);
            aplicarBordes(estiloHeader);

            // Celdas de datos
            CellStyle estiloCelda = workbook.createCellStyle();
            aplicarBordes(estiloCelda);

            CellStyle estiloCeldaCentrada = workbook.createCellStyle();
            aplicarBordes(estiloCeldaCentrada);
            estiloCeldaCentrada.setAlignment(HorizontalAlignment.CENTER);

            // Fila de totales
            Font fuenteTotal = workbook.createFont();
            fuenteTotal.setBold(true);
            CellStyle estiloTotal = workbook.createCellStyle();
            estiloTotal.setFont(fuenteTotal);
            aplicarBordes(estiloTotal);
            estiloTotal.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
            estiloTotal.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            estiloTotal.setAlignment(HorizontalAlignment.CENTER);

            String[] columnas = {"Código", "Producto", "Categoría",
                                 "Stock inicial", "Entrada del mes", "Salida del mes"};

            // ── Fila 0: título ───────────────────────────────────────────────
            Row filaTitulo = sheet.createRow(0);
            filaTitulo.setHeightInPoints(22);
            Cell celdaTitulo = filaTitulo.createCell(0);
            celdaTitulo.setCellValue("Tabla de Consumo - " + nombreMes(mes) + " " + anio);
            celdaTitulo.setCellStyle(estiloTitulo);
            sheet.addMergedRegion(new org.apache.poi.ss.util.CellRangeAddress(
                    0, 0, 0, columnas.length - 1));
            for (int i = 1; i < columnas.length; i++) {
                filaTitulo.createCell(i).setCellStyle(estiloTitulo);
            }

            // ── Fila 1: encabezados ─────────────────────────────────────────
            Row filaHeader = sheet.createRow(1);
            for (int i = 0; i < columnas.length; i++) {
                Cell c = filaHeader.createCell(i);
                c.setCellValue(columnas[i]);
                c.setCellStyle(estiloHeader);
            }

            // ── Filas de datos ───────────────────────────────────────────────
            int fila = 2;
            int totalStockInicial = 0, totalEntradas = 0, totalSalidas = 0;
            for (ReporteConsumo r : datos) {
                Row row = sheet.createRow(fila++);

                Cell c0 = row.createCell(0);
                c0.setCellValue(r.getCodigo() != null ? r.getCodigo() : "");
                c0.setCellStyle(estiloCeldaCentrada);

                Cell c1 = row.createCell(1);
                c1.setCellValue(r.getProducto() != null ? r.getProducto() : "");
                c1.setCellStyle(estiloCelda);

                Cell c2 = row.createCell(2);
                c2.setCellValue(r.getCategoria() != null ? r.getCategoria() : "");
                c2.setCellStyle(estiloCelda);

                Cell c3 = row.createCell(3);
                c3.setCellValue(r.getStockInicial());
                c3.setCellStyle(estiloCeldaCentrada);

                Cell c4 = row.createCell(4);
                c4.setCellValue(r.getEntradaMes());
                c4.setCellStyle(estiloCeldaCentrada);

                Cell c5 = row.createCell(5);
                c5.setCellValue(r.getSalidaMes());
                c5.setCellStyle(estiloCeldaCentrada);

                totalStockInicial += r.getStockInicial();
                totalEntradas     += r.getEntradaMes();
                totalSalidas      += r.getSalidaMes();
            }

            // ── Fila de totales ──────────────────────────────────────────────
            Row filaTotal = sheet.createRow(fila);
            Cell t0 = filaTotal.createCell(0);
            t0.setCellValue("TOTALES");
            t0.setCellStyle(estiloTotal);
            filaTotal.createCell(1).setCellStyle(estiloTotal);
            filaTotal.createCell(2).setCellStyle(estiloTotal);
            Cell t3 = filaTotal.createCell(3);
            t3.setCellValue(totalStockInicial);
            t3.setCellStyle(estiloTotal);
            Cell t4 = filaTotal.createCell(4);
            t4.setCellValue(totalEntradas);
            t4.setCellStyle(estiloTotal);
            Cell t5 = filaTotal.createCell(5);
            t5.setCellValue(totalSalidas);
            t5.setCellStyle(estiloTotal);

            // Ajustar ancho de columnas con valores fijos.
            // Se usan anchos fijos (en lugar de autoSizeColumn) para no depender
            // de las fuentes del sistema, que pueden faltar en servidores Linux.
            int[] anchos = {18, 34, 30, 16, 18, 18}; // ancho en nº de caracteres
            for (int i = 0; i < columnas.length; i++) {
                sheet.setColumnWidth(i, anchos[i] * 256);
            }

            // ── Enviar el archivo al navegador ───────────────────────────────
            String nombreArchivo = "Reporte_Consumo_" + nombreMes(mes) + "_" + anio + ".xlsx";
            response.setContentType(
                    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition",
                    "attachment; filename=\"" + nombreArchivo + "\"");

            try (OutputStream out = response.getOutputStream()) {
                workbook.write(out);
            }
        }
    }

    // ─── Utilidades ──────────────────────────────────────────────────────────

    private void aplicarBordes(CellStyle estilo) {
        estilo.setBorderTop(BorderStyle.THIN);
        estilo.setBorderBottom(BorderStyle.THIN);
        estilo.setBorderLeft(BorderStyle.THIN);
        estilo.setBorderRight(BorderStyle.THIN);
    }

    private int parseIntOr(String valor, int fallback) {
        if (valor == null || valor.trim().isEmpty()) return fallback;
        try {
            return Integer.parseInt(valor.trim());
        } catch (NumberFormatException e) {
            return fallback;
        }
    }

    private String nombreMes(int mes) {
        return (mes >= 1 && mes <= 12) ? NOMBRE_MES[mes] : String.valueOf(mes);
    }

    // ── Helpers para construir JSON de los gráficos (sin librerías) ──────────

    private List<String> extraerProductos(List<ProductoSolicitadoDTO> lista) {
        List<String> r = new ArrayList<>();
        for (ProductoSolicitadoDTO d : lista) r.add(d.getProducto());
        return r;
    }

    private List<Integer> extraerCantidadesProd(List<ProductoSolicitadoDTO> lista) {
        List<Integer> r = new ArrayList<>();
        for (ProductoSolicitadoDTO d : lista) r.add(d.getCantidad());
        return r;
    }

    private List<String> extraerCategorias(List<ConsumoCategoriaDTO> lista) {
        List<String> r = new ArrayList<>();
        for (ConsumoCategoriaDTO d : lista) r.add(d.getCategoria());
        return r;
    }

    private List<Integer> extraerCantidadesCat(List<ConsumoCategoriaDTO> lista) {
        List<Integer> r = new ArrayList<>();
        for (ConsumoCategoriaDTO d : lista) r.add(d.getCantidad());
        return r;
    }

    /** Convierte una lista de textos en un arreglo JSON: ["a","b","c"] */
    private String toJsonLabels(List<String> valores) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < valores.size(); i++) {
            String v = valores.get(i) == null ? "" : valores.get(i)
                    .replace("\\", "\\\\").replace("\"", "\\\"");
            sb.append("\"").append(v).append("\"");
            if (i < valores.size() - 1) sb.append(",");
        }
        return sb.append("]").toString();
    }

    /** Convierte una lista de números en un arreglo JSON: [1,2,3] */
    private String toJsonData(List<Integer> valores) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < valores.size(); i++) {
            sb.append(valores.get(i));
            if (i < valores.size() - 1) sb.append(",");
        }
        return sb.append("]").toString();
    }
}
