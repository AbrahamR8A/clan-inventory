<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Inicio - Solicitante</title>

    <!-- Fuentes e iconos -->
    <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,300,400,600,700,800,900" rel="stylesheet">

    <!-- Tema SB Admin 2 -->
    <link href="${pageContext.request.contextPath}/css/sb-admin-2.min.css" rel="stylesheet">

    <!-- DataTables -->
    <link href="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
</head>

<body id="page-top">
<div id="wrapper">

    <%-- ====================== SIDEBAR ====================== --%>
    <ul class="navbar-nav bg-gradient-admin sidebar sidebar-dark accordion" id="accordionSidebar">
        <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/InicioSolicitanteServlet">
            <div class="sidebar-brand-icon rotate-n-15"><i class="fas fa-laugh-wink"></i></div>
            <div class="sidebar-brand-text mx-3">CLAN INVENTORY</div>
        </a>
        <hr class="sidebar-divider my-0">
        <li class="nav-item active">
            <a class="nav-link" href="${pageContext.request.contextPath}/InicioSolicitanteServlet">
                <i class="fas fa-fw fa-tachometer-alt"></i><span>INICIO</span></a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/NuevaSolicitudSolicitanteServlet">
                <i class="fas fa-fw fa-box"></i><span>NUEVA SOLICITUD</span></a>
        </li>
        <hr class="sidebar-divider d-none d-md-block">
        <div class="text-center d-none d-md-inline">
            <button class="rounded-circle border-0" id="sidebarToggle"></button>
        </div>
    </ul>
    <!-- Fin Sidebar -->

    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">

            <%-- ====================== TOPBAR ====================== --%>
            <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
                <div class="d-none d-sm-inline-block mr-auto ml-md-3 my-2 my-md-0 mw-100">
                    <h1 class="h3 mb-0 text-gray-800 font-weight-bold">INICIO</h1>
                </div>
                <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                    <i class="fa fa-bars"></i>
                </button>
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item dropdown no-arrow mx-1">
                        <a class="nav-link" href="#"><i class="fas fa-bell fa-fw"></i></a>
                    </li>
                    <div class="topbar-divider d-none d-sm-block"></div>
                    <li class="nav-item dropdown no-arrow">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="mr-2 d-none d-lg-inline text-gray-600 small">${sessionScope.nombreCompleto}</span>
                            <img class="img-profile rounded-circle"
                                src="${pageContext.request.contextPath}/img/undraw_profile.svg">
                        </a>
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
            <!-- Fin Topbar -->

            <%-- ====================== CONTENIDO ====================== --%>
            <div class="container-fluid">

                <%-- Aviso de solicitud creada --%>
                <c:if test="${param.msg == 'creada'}">
                    <div class="alert alert-success alert-dismissible fade show shadow mb-4" role="alert">
                        <i class="fas fa-check-circle mr-2"></i>
                        <strong>¡Éxito!</strong> La solicitud fue creada correctamente y está pendiente de revisión.
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </c:if>

                <div class="card-body">

                    <%-- ============ TARJETAS KPI ============ --%>
                    <div class="row mb-2">
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-warning shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Solicitudes Pendientes</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${kpis.pendientes}</div>
                                        </div>
                                        <div class="col-auto"><i class="fas fa-clock fa-2x text-gray-300"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Solicitudes Aprobadas</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${kpis.aprobadas}</div>
                                        </div>
                                        <div class="col-auto"><i class="fas fa-check fa-2x text-gray-300"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-info shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Solicitudes Entregadas</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${kpis.entregadas}</div>
                                        </div>
                                        <div class="col-auto"><i class="fas fa-truck fa-2x text-gray-300"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-danger shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">Solicitudes Rechazadas</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${kpis.rechazadas}</div>
                                        </div>
                                        <div class="col-auto"><i class="fas fa-times fa-2x text-gray-300"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%-- ============ TABLA DE ACTIVIDAD RECIENTE ============ --%>
                    <div class="card shadow mb-4">
                        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                            <h6 class="m-0 font-weight-bold text-admin">Tabla de Actividad Reciente</h6>
                            <a href="${pageContext.request.contextPath}/NuevaSolicitudSolicitanteServlet" class="btn btn-admin shadow-sm">
                                <i class="fas fa-plus fa-sm text-white-50"></i> Crear nueva solicitud
                            </a>
                        </div>
                        <div class="card-body">

                            <%-- Filtro por estado --%>
                            <div class="row mb-3">
                                <div class="col-md-3">
                                    <label class="small font-weight-bold text-dark">Por Estado:</label>
                                    <select id="filtroEstado" class="form-control">
                                        <option value="">Todos</option>
                                        <option value="Pendiente">Pendiente</option>
                                        <option value="Aprobada">Aprobada</option>
                                        <option value="Rechazada">Rechazada</option>
                                        <option value="Entregada">Entregada</option>
                                    </select>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table id="dataTable" class="table table-hover text-center text-gray-800" width="100%">
                                    <thead class="bg-white text-dark text-center">
                                        <tr>
<%--                                            <th>ID de solicitud</th>--%>
                                            <th class="font-weight-bold">Fila</th>
                                            <th class="font-weight-bold">Fecha</th>
                                            <th class="font-weight-bold">Categorías Solicitadas</th>
                                            <th class="font-weight-bold">Estado</th>
                                            <th class="font-weight-bold">Acción</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${not empty listaSolicitudes}">
                                            <c:forEach var="s" items="${listaSolicitudes}" varStatus="status">
                                                <tr>
                                                    <td class="text-center align-middle">${status.count}</td>

<%--                                                    <td class="text-center align-middle">#${s.idSolicitudes}</td>--%>
                                                    <td class="text-center align-middle">${s.fechaSolicitud}</td>
                                                    <td class="align-middle">
                                                            ${s.categoriaPrincipal}
                                                        <c:if test="${s.categoriasExtra > 0}">
                                                            <span class="badge badge-secondary ml-1" title="${s.categoriasTexto}">+${s.categoriasExtra}</span>
                                                        </c:if>
                                                    </td>
                                                    <td class="text-center align-middle">
                                                        <c:choose>
                                                            <c:when test="${s.estado == 'pendiente'}">
                                                                <span class="badge badge-warning px-2 py-1">Pendiente</span>
                                                            </c:when>
                                                            <c:when test="${s.estado == 'aprobada'}">
                                                                <span class="badge badge-success px-2 py-1">Aprobada</span>
                                                            </c:when>
                                                            <c:when test="${s.estado == 'rechazada'}">
                                                                <span class="badge badge-danger px-2 py-1">Rechazada</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge badge-info px-2 py-1">Entregada</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="text-center align-middle">
                                                        <a href="${pageContext.request.contextPath}/DetalleSolicitudSolicitanteServlet?id=${s.idSolicitudes}"
                                                           class="btn btn-sm shadow-sm" title="Ver detalle">
                                                            <i class="fas fa-eye"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>

                                        <%-- Control de cuando la lista está vacía --%>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="6" class="text-center text-muted py-4">
                                                    <i class="fas fa-inbox fa-2x mb-2"></i><br>
                                                    No se encontraron solicitudes.
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <!-- Fin Contenido -->

        </div>

        <footer class="sticky-footer bg-white">
            <div class="container my-auto">
                <div class="copyright text-center my-auto">
                    <span>Copyright &copy; Clan Inventory 2026</span>
                </div>
            </div>
        </footer>
    </div>
</div>

<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>

<!-- Logout Modal -->
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

<!-- Scripts -->
<script src="${pageContext.request.contextPath}/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="${pageContext.request.contextPath}/js/sb-admin-2.min.js"></script>
<script src="${pageContext.request.contextPath}/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.min.js"></script>
<script src="${pageContext.request.contextPath}/js/demo/datatables-demo.js"></script>

<script>
    // Filtro por estado: busca en la columna "Estado" (índice 3) de la tabla
    $(document).ready(function () {
        $('#filtroEstado').on('change', function () {
            if (window.dataTable) {
                window.dataTable.column(3).search(this.value).draw();
            }
        });
    });
</script>

</body>
</html>
