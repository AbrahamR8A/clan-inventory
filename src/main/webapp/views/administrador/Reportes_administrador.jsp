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
        <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/InicioAdminServlet">
            <div class="sidebar-brand-icon rotate-n-15"><i class="fas fa-laugh-wink"></i></div>
            <div class="sidebar-brand-text mx-3">CLAN INVENTORY</div>
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

        <!-- Nav Item - Nueva orden de ingreso -->
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/OrdenIngresoServlet?action=nueva">
                <i class="fas fa-fw fa-dolly"></i>
                <span>NUEVA ORDEN DE INGRESO</span></a>
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
                                                                                            <!-- Nav Item - Alerts -->
                        <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-bell fa-fw"></i>
                                <!-- Counter - Alerts -->
                                <c:if test="${notificacionesNoLeidas > 0}">
                                    <span class="badge badge-danger badge-counter">${notificacionesNoLeidas}</span>
                                </c:if>
                            </a>
                            <!-- Dropdown - Alerts -->
                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="alertsDropdown">
                                <h6 class="dropdown-header bg-admin text-white border-0">
                                    Centro de Alertas
                                </h6>

                                <c:forEach var="notif" items="${listaNotificaciones}">
                                    <a class="dropdown-item d-flex align-items-center" href="#">
                                        <div class="mr-3">
                                            <div class="icon-circle bg-${notif.tipo}">
                                                <c:choose>
                                                    <c:when test="${notif.tipo == 'success'}"><i class="fas fa-check text-white"></i></c:when>
                                                    <c:when test="${notif.tipo == 'warning'}"><i class="fas fa-exclamation-triangle text-white"></i></c:when>
                                                    <c:when test="${notif.tipo == 'danger'}"><i class="fas fa-exclamation-circle text-white"></i></c:when>
                                                    <c:otherwise><i class="fas fa-info text-white"></i></c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div>
                                            <div class="small text-gray-500">${notif.fechaCreacion}</div>
                                            <span class="${notif.leido ? '' : 'font-weight-bold'}">${notif.mensaje}</span>
                                        </div>
                                    </a>
                                </c:forEach>
                                <c:if test="${empty listaNotificaciones}">
                                     <a class="dropdown-item text-center small text-gray-500" href="#">No hay notificaciones</a>
                                </c:if>
                            </div>
                        </li>
                        <div class="topbar-divider d-none d-sm-block"></div>
                    <!-- Nav Item - User Information -->
                    <li class="nav-item dropdown no-arrow">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="mr-2 d-none d-lg-inline text-gray-600 small">${sessionScope.nombreCompleto}</span>
                            <img class="img-profile rounded-circle"
                                src="${pageContext.request.contextPath}/img/undraw_profile.svg">
                        </a>
                        <!-- Dropdown - User Information -->
                        <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                        aria-labelledby="userDropdown">
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/PerfilServlet">
                                            <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                            Perfil
                                        </a>

                                        <div class="dropdown-divider"></div>
                                        <a class="dropdown-item" href="#" data-toggle="modal"
                                            data-target="#logoutModal">
                                            <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                            Cerrar Sesión
                                        </a>
                                    </div>
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
                                <form method="get" action="${pageContext.request.contextPath}/ReportesServlet" class="mb-4">

                                    <div class="row align-items-center filtros-reportes-admin">

                                        <div class="col-md-5 mb-2">
                                            <select name="mes" class="form-control filtro-control">
                                                <option value="">Filtrar por Mes...</option>

                                                <option value="Enero" ${param.mes == 'Enero' ? 'selected' : ''}>Enero</option>
                                                <option value="Febrero" ${param.mes == 'Febrero' ? 'selected' : ''}>Febrero</option>
                                                <option value="Marzo" ${param.mes == 'Marzo' ? 'selected' : ''}>Marzo</option>
                                                <option value="Abril" ${param.mes == 'Abril' ? 'selected' : ''}>Abril</option>
                                                <option value="Mayo" ${param.mes == 'Mayo' ? 'selected' : ''}>Mayo</option>
                                                <option value="Junio" ${param.mes == 'Junio' ? 'selected' : ''}>Junio</option>
                                                <option value="Julio" ${param.mes == 'Julio' ? 'selected' : ''}>Julio</option>
                                                <option value="Agosto" ${param.mes == 'Agosto' ? 'selected' : ''}>Agosto</option>
                                                <option value="Septiembre" ${param.mes == 'Septiembre' ? 'selected' : ''}>Septiembre</option>
                                                <option value="Octubre" ${param.mes == 'Octubre' ? 'selected' : ''}>Octubre</option>
                                                <option value="Noviembre" ${param.mes == 'Noviembre' ? 'selected' : ''}>Noviembre</option>
                                                <option value="Diciembre" ${param.mes == 'Diciembre' ? 'selected' : ''}>Diciembre</option>
                                            </select>
                                        </div>

                                        <div class="col-md-5 mb-2">
                                            <select name="anio" class="form-control filtro-control">
                                                <option value="">Filtrar por Año...</option>

                                                <option value="2026" ${param.anio == '2026' ? 'selected' : ''}>2026</option>
                                                <option value="2025" ${param.anio == '2025' ? 'selected' : ''}>2025</option>
                                                <option value="2024" ${param.anio == '2024' ? 'selected' : ''}>2024</option>
                                            </select>
                                        </div>

                                        <div class="col-md-1 mb-2">
                                            <button type="submit" class="btn btn-admin btn-block btn-filtro-reportes">
                                                <i class="fas fa-filter"></i>
                                            </button>
                                        </div>

                                        <div class="col-md-1 mb-2">
                                            <a href="${pageContext.request.contextPath}/ReportesServlet"
                                               class="btn btn-light btn-block btn-limpiar-reportes">
                                                <i class="fas fa-eraser"></i>
                                            </a>
                                        </div>
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
                                <!-- Mismo estilo que la tabla de Gestión de Inventario -->
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
                                                        <td class="text-center">${r.codigo}</td>
                                                        <td class="text-center">${r.producto}</td>
                                                        <td class="text-center">${r.categoria}</td>
                                                        <td class="text-center">${r.stockInicial}</td>
                                                        <td class="text-center text-success font-weight-bold">${r.entradaMes}</td>
                                                        <td class="text-center text-danger font-weight-bold">${r.salidaMes}</td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="6" class="text-center">
                                                        No se encontraron registros.
                                                    </td>
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
                    <span>CLAN INVENTORY &copy; <%= java.time.Year.now() %></span>
                </div>
            </div>
        </footer>
    </div><!-- /content-wrapper -->
</div><!-- /wrapper -->

<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>

<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">¿Desea salir?</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">Seleccione "Cerrar sesión" a continuación si desea finalizar su sesión actual.</div>
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancelar</button>
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/LogoutServlet">Cerrar Sesión</a>
            </div>
        </div>
    </div>
</div>

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
    // Se usa JSON.parse sobre un string para evitar que VS Code marque el $\{} como error de ES6.
    const barLabels   = JSON.parse('${empty barLabels ? "[]" : barLabels}');
    const barData     = JSON.parse('${empty barData ? "[]" : barData}');
    const donutLabels = JSON.parse('${empty donutLabels ? "[]" : donutLabels}');
    const donutData   = JSON.parse('${empty donutData ? "[]" : donutData}');

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
