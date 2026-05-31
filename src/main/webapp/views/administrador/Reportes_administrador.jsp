<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%--
  Si esta vista se abre directamente (sin pasar por ReportesServlet) no
  tendría datos cargados. En ese caso se redirige al servlet para que
  cargue los reportes desde la base de datos y regrese a esta página.
--%>
<%
    if (request.getAttribute("kpis") == null) {
        response.sendRedirect(request.getContextPath() + "/ReportesServlet");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Reportes - CLAN INVENTORY</title>

    <!-- Fuentes e iconos -->
    <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,300,400,600,700,800,900&display=swap" rel="stylesheet">

    <!-- Estilos del tema SB Admin 2 (versión personalizada con los colores de rol) -->
    <link href="${pageContext.request.contextPath}/css/sb-admin-2.css" rel="stylesheet">

    <!-- Estilos DataTables -->
    <link href="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

    <style>
        /* Respaldo de los colores de rol de CLAN INVENTORY.
           Ya vienen definidos en sb-admin-2.css; se repiten aquí solo
           por seguridad, para garantizar el tema morado del Administrador. */
        .bg-admin { background-color: #7203c1 !important; color: #fff !important; }
        .text-admin { color: #7203c1 !important; }
        .border-left-admin { border-left: .25rem solid #7203c1 !important; }
        .btn-admin { color: #fff; background-color: #7203c1; border-color: #7203c1; }
        .btn-admin:hover, .btn-admin:focus {
            color: #fff; background-color: #5a0299; border-color: #5a0299;
        }
        /* Logo Quinta Ola en sidebar */
        #accordionSidebar .sidebar-brand {
            background: transparent !important;
            height: 4.375rem !important;
            padding: 0.6rem 0.7rem !important;
            margin: 0 !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
        }

        /* Caja blanca del logo */
        #accordionSidebar .logo-quintaola-box {
            width: 150px !important;
            height: 50px !important;
            background-color: #ffffff !important;
            border-radius: 14px !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            padding: 6px 10px !important;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.16) !important;
            overflow: hidden !important;
        }

        /* Imagen del logo */
        #accordionSidebar .logo-quintaola-sidebar {
            max-width: 125px !important;
            max-height: 40px !important;
            width: auto !important;
            height: auto !important;
            object-fit: contain !important;
            display: block !important;
        }

        /* Cuando la sidebar está contraída */
        #accordionSidebar.toggled .logo-quintaola-box {
            width: 52px !important;
            height: 52px !important;
            border-radius: 50% !important;
            padding: 6px !important;
        }

        #accordionSidebar.toggled .logo-quintaola-sidebar {
            max-width: 42px !important;
            max-height: 42px !important;
        }
        .text-coord { color: #ff2a9e !important; }
        .border-left-coord { border-left: .25rem solid #ff2a9e !important; }

        /* Degradado morado del menú lateral (igual que el resto del sistema) */
        #accordionSidebar {
            background-image: linear-gradient(180deg, #7203c1 10%, #5a0299 100%) !important;
            background-size: cover;
        }

        /* Tarjetas KPI de Reportes */
        .kpi-card .kpi-num { font-size: 1.6rem; font-weight: 700; }
        .kpi-icon { font-size: 2rem; opacity: .3; }

        /* La tabla de consumo conserva el mismo look de Gestión de Inventario */
        #dataTable thead th { text-align: center; vertical-align: middle; }
        #dataTable td { vertical-align: middle; }
    </style>
</head>

<body id="page-top">
<div id="wrapper">

    <%-- ============================================================== --%>
    <%-- SIDEBAR                                                         --%>
    <%-- Si ya tienes tu propio menu lateral, reemplaza este bloque      --%>
    <%-- completo por tu include de sidebar.                             --%>
    <%-- ============================================================== --%>
    <ul class="navbar-nav bg-admin sidebar sidebar-dark accordion" id="accordionSidebar">
        <a class="sidebar-brand d-flex align-items-center justify-content-center"
           href="${pageContext.request.contextPath}/InicioAdminServlet">
            <div class="logo-quintaola-box">
                <img src="${pageContext.request.contextPath}/img/quintaola_logo.png"
                     alt="Quinta Ola"
                     class="logo-quintaola-sidebar">
            </div>
        </a>

        <hr class="sidebar-divider my-0">
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/InicioAdminServlet">
                <i class="fas fa-fw fa-tachometer-alt"></i><span>INICIO</span></a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/UsuariosServlet">
                <i class="fas fa-fw fa-users"></i><span>GESTION DE USUARIOS</span></a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/ProductosServlet">
                <i class="fas fa-fw fa-boxes"></i><span>GESTION DE INVENTARIO</span></a>
        </li>
        <li class="nav-item active">
            <a class="nav-link" href="${pageContext.request.contextPath}/ReportesServlet">
                <i class="fas fa-fw fa-chart-bar"></i><span>REPORTES</span></a>
        </li>
        <hr class="sidebar-divider d-none d-md-block">

        <!-- Botón para contraer / expandir el menú -->
        <div class="text-center d-none d-md-inline">
            <button class="rounded-circle border-0" id="sidebarToggle"></button>
        </div>
    </ul>
    <!-- FIN SIDEBAR -->

    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">

            <%-- ========================================================= --%>
            <%-- TOPBAR                                                    --%>
            <%-- Reemplazalo por tu include de topbar si ya lo tienes.     --%>
            <%-- ========================================================= --%>
            <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
                <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                    <i class="fa fa-bars"></i>
                </button>
                <h1 class="h3 mb-0 text-gray-800 ml-2">REPORTES</h1>
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item dropdown no-arrow">
                        <a class="nav-link" href="#"><i class="fas fa-bell fa-fw"></i></a>
                    </li>
                    <div class="topbar-divider d-none d-sm-block"></div>
                    <li class="nav-item">
                        <span class="mr-2 d-none d-lg-inline text-gray-600 small">Administrador</span>
                    </li>
                </ul>
            </nav>
            <!-- FIN TOPBAR -->

            <!-- ========================= CONTENIDO ====================== -->
            <div class="container-fluid">

                <div class="row">

                    <!-- ===================== COLUMNA IZQUIERDA ============ -->
                    <div class="col-xl-8 col-lg-7">
                        <div class="card shadow mb-4">

                            <!-- Cabecera: título + botón Exportar a Excel -->
                            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                <h6 class="m-0 font-weight-bold text-admin">Tabla de Consumo del Mes</h6>
                                <a class="btn btn-sm btn-admin"
                                   href="${pageContext.request.contextPath}/ReportesServlet?action=exportar&mes=${mesActual}&anio=${anioActual}">
                                    <i class="fas fa-file-excel fa-sm"></i> Exportar a Excel
                                </a>
                            </div>

                            <div class="card-body">

                                <!-- ============ FORMULARIO DE FILTRO ========= -->
                                <form method="get" action="${pageContext.request.contextPath}/ReportesServlet"
                                      class="form-row align-items-end mb-4">
                                    <div class="form-group col-md-4 mb-2">
                                        <label class="small font-weight-bold text-gray-700">Selecciona un mes</label>
                                        <select name="mes" class="form-control form-control-sm">
                                            <c:forEach var="m" begin="1" end="12">
                                                <option value="${m}" ${m == mesActual ? 'selected' : ''}>
                                                    <c:choose>
                                                        <c:when test="${m == 1}">Enero</c:when>
                                                        <c:when test="${m == 2}">Febrero</c:when>
                                                        <c:when test="${m == 3}">Marzo</c:when>
                                                        <c:when test="${m == 4}">Abril</c:when>
                                                        <c:when test="${m == 5}">Mayo</c:when>
                                                        <c:when test="${m == 6}">Junio</c:when>
                                                        <c:when test="${m == 7}">Julio</c:when>
                                                        <c:when test="${m == 8}">Agosto</c:when>
                                                        <c:when test="${m == 9}">Septiembre</c:when>
                                                        <c:when test="${m == 10}">Octubre</c:when>
                                                        <c:when test="${m == 11}">Noviembre</c:when>
                                                        <c:otherwise>Diciembre</c:otherwise>
                                                    </c:choose>
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="form-group col-md-4 mb-2">
                                        <label class="small font-weight-bold text-gray-700">Selecciona un año</label>
                                        <select name="anio" class="form-control form-control-sm">
                                            <c:forEach var="y" begin="${anioActual - 5}" end="${anioActual + 1}">
                                                <option value="${y}" ${y == anioActual ? 'selected' : ''}>${y}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="form-group col-md-4 mb-2">
                                        <button type="submit" class="btn btn-sm btn-admin">
                                            <i class="fas fa-filter fa-sm"></i> Filtrar
                                        </button>
                                    </div>
                                </form>

                                <!-- ============ TARJETAS KPI ================= -->
                                <div class="row">
                                    <div class="col-md-3 col-6 mb-3">
                                        <div class="card border-left-coord shadow h-100 py-2 kpi-card">
                                            <div class="card-body py-2">
                                                <div class="row no-gutters align-items-center">
                                                    <div class="col mr-2">
                                                        <div class="text-xs font-weight-bold text-coord text-uppercase mb-1">Solicitudes Totales</div>
                                                        <div class="kpi-num text-gray-800">${kpis.solicitudesTotales}</div>
                                                    </div>
                                                    <div class="col-auto"><i class="fas fa-clipboard-list kpi-icon text-coord"></i></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-6 mb-3">
                                        <div class="card border-left-success shadow h-100 py-2 kpi-card">
                                            <div class="card-body py-2">
                                                <div class="row no-gutters align-items-center">
                                                    <div class="col mr-2">
                                                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Solicitudes Aprobadas</div>
                                                        <div class="kpi-num text-gray-800">${kpis.solicitudesAprobadas}</div>
                                                    </div>
                                                    <div class="col-auto"><i class="fas fa-check-circle kpi-icon text-success"></i></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-6 mb-3">
                                        <div class="card border-left-primary shadow h-100 py-2 kpi-card">
                                            <div class="card-body py-2">
                                                <div class="row no-gutters align-items-center">
                                                    <div class="col mr-2">
                                                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Solicitudes Entregadas</div>
                                                        <div class="kpi-num text-gray-800">${kpis.solicitudesEntregadas}</div>
                                                    </div>
                                                    <div class="col-auto"><i class="fas fa-truck kpi-icon text-primary"></i></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-6 mb-3">
                                        <div class="card border-left-danger shadow h-100 py-2 kpi-card">
                                            <div class="card-body py-2">
                                                <div class="row no-gutters align-items-center">
                                                    <div class="col mr-2">
                                                        <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">Solicitudes Rechazadas</div>
                                                        <div class="kpi-num text-gray-800">${kpis.solicitudesRechazadas}</div>
                                                    </div>
                                                    <div class="col-auto"><i class="fas fa-times-circle kpi-icon text-danger"></i></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- ============ TABLA DE CONSUMO ============= -->
                                <div class="table-responsive">
                                    <table id="dataTable" class="table table-hover text-gray-800">
                                        <thead class="bg-light">
                                        <tr>
                                            <th class="centered font-weight-bold">Código</th>
                                            <th class="centered font-weight-bold">Producto</th>
                                            <th class="centered font-weight-bold">Categoría</th>
                                            <th class="centered font-weight-bold">Stock inicial</th>
                                            <th class="centered font-weight-bold">Entrada del mes</th>
                                            <th class="centered font-weight-bold">Salida del mes</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                            <c:when test="${not empty listaConsumo}">
                                                <c:forEach var="r" items="${listaConsumo}">
                                                    <tr>
                                                        <td>${r.codigo}</td>
                                                        <td>${r.producto}</td>
                                                        <td>${r.categoria}</td>
                                                        <td>${r.stockInicial}</td>
                                                        <td class="text-success font-weight-bold">${r.entradaMes}</td>
                                                        <td class="text-danger font-weight-bold">${r.salidaMes}</td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="6" class="text-center">No se encontraron registros.</td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                    </table>
                                </div>

                            </div><!-- /card-body -->
                        </div><!-- /card -->
                    </div><!-- /col izquierda -->

                    <!-- ===================== COLUMNA DERECHA ============== -->
                    <div class="col-xl-4 col-lg-5">

                        <!-- Gráfico de barras -->
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-admin">Productos más solicitados</h6>
                            </div>
                            <div class="card-body">
                                <div class="chart-bar"><canvas id="graficoProductos"></canvas></div>
                            </div>
                        </div>

                        <!-- Gráfico de dona -->
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-admin">Consumo por categoría</h6>
                            </div>
                            <div class="card-body">
                                <div class="chart-pie pt-2"><canvas id="graficoCategorias"></canvas></div>
                            </div>
                        </div>

                    </div><!-- /col derecha -->

                </div><!-- /row -->

            </div><!-- /container-fluid -->
            <!-- ======================= FIN CONTENIDO ==================== -->

        </div><!-- /content -->

        <footer class="sticky-footer bg-white">
            <div class="container my-auto">
                <div class="copyright text-center my-auto">
                    <span>CLAN INVENTORY ; <%= java.time.Year.now() %></span>
                </div>
            </div>
        </footer>
    </div><!-- /content-wrapper -->
</div><!-- /wrapper -->

<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>

<!-- ===================== SCRIPTS ===================== -->
<script src="${pageContext.request.contextPath}/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="${pageContext.request.contextPath}/js/sb-admin-2.min.js"></script>

<!-- DataTables: hace que la tabla de Reportes se vea/funcione como la de Inventario -->
<script src="${pageContext.request.contextPath}/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.min.js"></script>
<script src="${pageContext.request.contextPath}/js/datatables-ReportesAdmin.js"></script>

<!-- Chart.js para los gráficos -->
<script src="${pageContext.request.contextPath}/vendor/chart.js/Chart.min.js"></script>
<script>
    // Datos enviados por ReportesServlet (ya vienen en formato JSON)
    const barLabels   = ${empty barLabels   ? '[]' : barLabels};
    const barData     = ${empty barData     ? '[]' : barData};
    const donutLabels = ${empty donutLabels ? '[]' : donutLabels};
    const donutData   = ${empty donutData   ? '[]' : donutData};

    // Muestra un mensaje cuando un gráfico no tiene datos para el periodo
    function reportesSinDatos(idCanvas, mensaje) {
        var canvas = document.getElementById(idCanvas);
        if (canvas) {
            canvas.parentElement.innerHTML =
                '<div class="text-center text-gray-500 py-5">' +
                '<i class="fas fa-chart-area fa-2x mb-2 text-gray-300"></i><br>' +
                mensaje + '</div>';
        }
    }

    // ---- Gráfico de barras: Productos más solicitados ----
    if (barLabels.length === 0) {
        reportesSinDatos("graficoProductos", "No hay solicitudes registradas en este periodo.");
    } else if (document.getElementById("graficoProductos")) {
        new Chart(document.getElementById("graficoProductos"), {
            type: "bar",
            data: {
                labels: barLabels,
                datasets: [{
                    label: "Cantidad solicitada",
                    data: barData,
                    backgroundColor: "#7203c1",
                    hoverBackgroundColor: "#5a0299",
                    borderColor: "#7203c1"
                }]
            },
            options: {
                maintainAspectRatio: false,
                legend: { display: false },
                scales: { yAxes: [{ ticks: { beginAtZero: true } }] }
            }
        });
    }

    // ---- Gráfico de dona: Consumo por categoría ----
    if (donutLabels.length === 0) {
        reportesSinDatos("graficoCategorias", "No hay consumo registrado en este periodo.");
    } else if (document.getElementById("graficoCategorias")) {
        new Chart(document.getElementById("graficoCategorias"), {
            type: "doughnut",
            data: {
                labels: donutLabels,
                datasets: [{
                    data: donutData,
                    backgroundColor: ["#7203c1", "#23b1be", "#ff2a9e", "#f6cf0b",
                                      "#fdb11f", "#1cc88a", "#36b9cc", "#e74a3b"],
                    hoverBorderColor: "#ffffff"
                }]
            },
            options: {
                maintainAspectRatio: false,
                cutoutPercentage: 70,
                legend: { position: "bottom" }
            }
        });
    }
</script>
</body>
</html>
