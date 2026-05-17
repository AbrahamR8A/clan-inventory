<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>

            <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
            <meta name="description" content="">
            <meta name="author" content="">

            <title>Inicio-Administrador</title>

            <!-- Custom fonts for this template-->
            <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
                type="text/css">
            <link
                href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
                rel="stylesheet">

            <!-- Custom styles for this template-->
            <link href="${pageContext.request.contextPath}/css/sb-admin-2.min.css" rel="stylesheet">

        </head>

        <body id="page-top">

            <!-- Page Wrapper -->
            <div id="wrapper">

                <!-- Sidebar -->
                <ul class="navbar-nav bg-gradient-admin sidebar sidebar-dark accordion" id="accordionSidebar">

                    <!-- Sidebar - Brand -->
                    <a class="sidebar-brand d-flex align-items-center justify-content-center"
                        href="${pageContext.request.contextPath}/InicioAdminServlet">
                        <div class="sidebar-brand-icon rotate-n-15">
                            <i class="fas fa-laugh-wink"></i>
                        </div>
                        <div class="sidebar-brand-text mx-3">CLAN INVENTORY </div>
                    </a>

                    <!-- Divider -->
                    <hr class="sidebar-divider my-0">

                    <!-- Nav Item - INICIO -->
                    <li class="nav-item active">
                        <a class="nav-link" href="${pageContext.request.contextPath}/InicioAdminServlet">
                            <i class="fas fa-fw fa-tachometer-alt"></i>
                            <span>INICIO</span></a>
                    </li>


                    <!-- Nav Item - GESTION DE USUARIOS -->
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/UsuariosServlet">
                            <i class="fas fa-fw fa-users mr"></i>
                            <span>GESTION DE USUARIOS</span></a>
                    </li>

                    <!-- Nav Item - GESTION DE INVENTARIO -->
                    <li class="nav-item">
                        <a class="nav-link" href="GestionInventario_administrador.jsp">
                            <i class="fas fa-fw fa-box mr"></i>
                            <span>GESTION DE INVENTARIO</span></a>
                    </li>

                    <!-- Nav Item - REPORTES -->
                    <li class="nav-item">
                        <a class="nav-link" href="Reportes_administrador.jsp">
                            <i class="fas fa-fw fa-chart-area"></i>
                            <span>REPORTES</span></a>
                    </li>

                    <!-- Divider -->
                    <hr class="sidebar-divider">

                    <!-- Sidebar Toggler (Sidebar) -->
                    <div class="text-center d-none d-md-inline">
                        <button class="rounded-circle border-0" id="sidebarToggle"></button>
                    </div>

                </ul>
                <!-- End of Sidebar -->

                <!-- Content Wrapper -->
                <div id="content-wrapper" class="d-flex flex-column">

                    <!-- Main Content -->
                    <div id="content">

                        <!-- Topbar -->
                        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                            <!-- Section Title (Topbar) -->
                            <div class="d-none d-sm-inline-block mr-auto ml-md-3 my-2 my-md-0 mw-100">
                                <h1 class="h3 mb-0 text-gray-800 font-weight-bold">INICIO</h1>
                            </div>

                            <!-- Sidebar Toggle (Topbar) -->
                            <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                                <i class="fa fa-bars"></i>
                            </button>

                            <!-- Topbar Navbar -->
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

                                        <a class="dropdown-item text-center small text-gray-500"
                                            href="notificaciones.html">Mostrar todas las notificaciones</a>
                                    </div>
                                </li>



                                <div class="topbar-divider d-none d-sm-block"></div>

                                <!-- Nav Item - User Information -->
                                <li class="nav-item dropdown no-arrow">
                                    <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <span class="mr-2 d-none d-lg-inline text-gray-600 small">Nathan Castillo</span>
                                        <img class="img-profile rounded-circle"
                                            src="${pageContext.request.contextPath}/img/undraw_profile.svg">
                                    </a>

                                    <!-- Dropdown - User Information -->
                                    <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                        aria-labelledby="userDropdown">
                                        <a class="dropdown-item" href="perfil_depósito.html">
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
                        <!-- End of Topbar -->

                        <!-- Begin Page Content -->
                        <div class="container-fluid">

                            <div id="actionToast" class="alert alert-success alert-dismissible fade show shadow mb-4"
                                role="alert" style="display: none;">
                                <i class="fas fa-check-circle mr-2"></i>
                                <strong>¡Éxito!</strong> <span id="toastMessage">La solicitud ha sido procesada.</span>
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>

                            <!--<div class="d-sm-flex align-items-center justify-content-between mb-4">-->

                            <!-- Page Heading -->
                            <div class="d-sm-flex align-items-center justify-content-between mb-0">
                                <h1 class="h3 mb-0 text-gray-800">Panel de Control del mes</h1>
                            </div>

                            <!-- Main Content -->
                            <div class="card-body">

                                <div class="row">

                                    <div class="col-lg-9">

                                        <div class="row mb-4">

                                            <div class="col-xl-3 col-md-6 mb-4">
                                                <div class="card border-left-admin shadow h-100 py-2">
                                                    <div class="card-body">
                                                        <div class="row no-gutters align-items-center">
                                                            <div class="col mr-2">
                                                                <div
                                                                    class="text-xs font-weight-bold text-admin text-uppercase mb-1">
                                                                    USUARIOS REGISTRADOS</div>
                                                                <div class="h5 mb-0 font-weight-bold text-gray-800">${kpis.usuariosRegistrados}
                                                                </div>
                                                            </div>
                                                            <div class="col-auto">
                                                                <i class="fas fa-user-check fa-2x text-gray-300"></i>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-xl-3 col-md-6 mb-4">
                                                <div class="card border-left-success shadow h-100 py-2">
                                                    <div class="card-body">
                                                        <div class="row no-gutters align-items-center">
                                                            <div class="col mr-2">
                                                                <div
                                                                    class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                                    SOLICITUDES APROBADAS</div>
                                                                <div class="h5 mb-0 font-weight-bold text-gray-800">${kpis.solicitudesAprobadas}
                                                                </div>
                                                            </div>
                                                            <div class="col-auto">
                                                                <i class="fas fa-check fa-2x text-gray-300"></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-xl-3 col-md-6 mb-4">
                                                <div class="card border-left-warning shadow h-100 py-2">
                                                    <div class="card-body">
                                                        <div class="row no-gutters align-items-center">
                                                            <div class="col mr-2">
                                                                <div
                                                                    class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                                                    SOLICITUDES PENDIENTES</div>
                                                                <div class="h5 mb-0 font-weight-bold text-gray-800">${kpis.solicitudesPendientes}
                                                                </div>
                                                            </div>
                                                            <div class="col-auto">
                                                                <i class="fas fa-clock fa-2x text-gray-300"></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-xl-3 col-md-6 mb-4">
                                                <div class="card border-left-danger shadow h-100 py-2">
                                                    <div class="card-body">
                                                        <div class="row no-gutters align-items-center">
                                                            <div class="col mr-2">
                                                                <div
                                                                    class="text-xs font-weight-bold text-danger text-uppercase mb-1">
                                                                    SOLICITUDES RECHAZADAS</div>
                                                                <div class="h5 mb-0 font-weight-bold text-gray-800">${kpis.solicitudesRechazadas}
                                                                </div>
                                                            </div>
                                                            <div class="col-auto">
                                                                <i class="fa-solid fa-x fa-2x text-gray-300"></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>

                                        <div class="card shadow mb-4">
                                            <div
                                                class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                                <h6 class="m-0 font-weight-bold text-admin">Actividad Reciente del
                                                    Sistema</h6>
                                                <a href="#" class="btn btn-sm btn-admin shadow-sm">Ver todo</a>
                                            </div>
                                            <div class="card-body">
                                                <div class="table-responsive">
                                                    <table class="table table-hover table-striped text-gray-800"
                                                        width="100%" cellspacing="0">
                                                        <thead class="bg-light">
                                                            <tr>
                                                                <th class="text-center">Usuario</th>
                                                                <th class="text-center">Rol</th>
                                                                <th class="text-center">Acción</th>
                                                                <th class="text-center">Detalle</th>
                                                                <th class="text-center">Fecha y Hora</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="act" items="${actividadReciente}">
                                                                <tr>
                                                                    <td>${act.usuario}</td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${act.rol == 'encargado_deposito'}"><span class="badge badge-info px-2 py-1">Encargado de Depósito</span></c:when>
                                                                            <c:when test="${act.rol == 'coordinador'}"><span class="badge badge-coord px-2 py-1">Coordinador</span></c:when>
                                                                            <c:when test="${act.rol == 'administrador'}"><span class="badge badge-admin px-2 py-1">Administrador</span></c:when>
                                                                            <c:when test="${act.rol == 'solicitante'}"><span class="badge badge-soli px-2 py-1">Solicitante</span></c:when>
                                                                            <c:otherwise><span class="badge badge-secondary px-2 py-1">${act.rol}</span></c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>${act.accion}</td>
                                                                    <td>${act.detalle}</td>
                                                                    <td class="text-center small">${act.fechaHora}</td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>

                                    </div>

                                    <div class="col-lg-3">

                                        <div class="card shadow mb-4">

                                            <div class="card-header py-3">
                                                <h6 class="m-0 font-weight-bold text-admin">Alertas de Stock</h6>
                                            </div>

                                            <div class="card-body p-0">

                                                <div class="table-responsive">

                                                    <table class="table table-hover table-striped text-gray-800"
                                                        width="100%" cellspacing="0">

                                                        <thead class="bg-light">
                                                            <tr>
                                                                <th class="text-center align-middle">Producto</th>
                                                                <th class="text-center align-middle">Stock Actual</th>
                                                                <th class="text-center align-middle">Estado</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="alerta" items="${alertasStock}">
                                                                <tr>
                                                                    <td class="text-left pl-3">${alerta.producto}</td>
                                                                    <td class="text-center align-middle">${alerta.cantidad}</td>
                                                                    <td class="text-center align-middle">
                                                                        <c:choose>
                                                                            <c:when test="${alerta.estadoColor == 'Rojo'}"><i class="fas fa-circle text-danger"></i></c:when>
                                                                            <c:when test="${alerta.estadoColor == 'Amarillo'}"><i class="fas fa-circle text-warning"></i></c:when>
                                                                            <c:when test="${alerta.estadoColor == 'Verde'}"><i class="fas fa-circle text-success"></i></c:when>
                                                                        </c:choose>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>

                                                </div>

                                                <hr class="m-0">

                                                <div class="p-2 small text-center bg-light">
                                                    <td class="text-center align-middle"><span
                                                            class="badge badge-danger px-2 py-1">Crítico</span></td>
                                                    <span class="mr-2"><i class="fas fa-circle text-danger"></i> 0 a
                                                        5</span>
                                                    <td class="text-center align-middle"><span
                                                            class="badge badge-advertencia px-2 py-1">bajo</span></td>
                                                    <span class="mr-2"><i class="fas fa-circle text-warning"></i> 6 a
                                                        10</span>
                                                    <td class="text-center align-middle"><span
                                                            class="badge badge-success px-2 py-1">Óptimo</span></td>
                                                    <span class="mt-1 d-inline-block"><i
                                                            class="fas fa-circle text-success"></i> 11 a más</span>
                                                </div>

                                            </div>
                                        </div>

                                    </div>
                                </div>


                            </div>
                        </div>
                        <!-- /.container-fluid -->

                    </div>
                    <!-- End of Main Content -->

                    <!-- Footer -->
                    <footer class="sticky-footer bg-white">
                        <div class="container my-auto">
                            <div class="copyright text-center my-auto">
                                <span>Copyright &copy; Clan Inventory 2026</span>
                            </div>
                        </div>
                    </footer>
                    <!-- End of Footer -->

                </div>
                <!-- End of Content Wrapper -->

            </div>
            <!-- End of Page Wrapper -->

            <!-- Scroll to Top Button-->
            <a class="scroll-to-top rounded" href="#page-top">
                <i class="fas fa-angle-up"></i>
            </a>

            <!-- Logout Modal-->
            <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
                aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">Select "Logout" below if you are ready to end your current session.
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                            <a class="btn btn-primary" href="${pageContext.request.contextPath}/login.jsp">Logout</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bootstrap core JavaScript-->
            <script src="${pageContext.request.contextPath}/vendor/jquery/jquery.min.js"></script>
            <script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

            <!-- Core plugin JavaScript-->
            <script src="${pageContext.request.contextPath}/vendor/jquery-easing/jquery.easing.min.js"></script>

            <!-- Custom scripts for all pages-->
            <script src="${pageContext.request.contextPath}/js/sb-admin-2.min.js"></script>

            <!-- Page level plugins -->
            <script src="${pageContext.request.contextPath}/vendor/chart.js/Chart.min.js"></script>

            <!-- Page level custom scripts -->
            <script src="${pageContext.request.contextPath}/js/demo/chart-area-demo.js"></script>
            <script src="${pageContext.request.contextPath}/js/demo/chart-pie-demo.js"></script>