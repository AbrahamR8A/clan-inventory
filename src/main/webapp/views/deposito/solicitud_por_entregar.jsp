<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Detalle de Solicitud - Depósito</title>

    <!-- Custom fonts for this template-->
    <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="${pageContext.request.contextPath}/css/sb-admin-2.min.css" rel="stylesheet">
</head>

<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">

    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-admin sidebar sidebar-dark accordion" id="accordionSidebar">

        <!-- Sidebar - Brand -->
        <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/InicioDepositoServlet">
            <div class="sidebar-brand-icon rotate-n-15">
                <i class="fas fa-laugh-wink"></i>
            </div>
            <div class="sidebar-brand-text mx-3">CLAN INVENTORY</div>
        </a>

        <!-- Divider -->
        <hr class="sidebar-divider my-0">

        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/InicioDepositoServlet">
                <i class="fas fa-fw fa-tachometer-alt"></i>
                <span>INICIO</span></a>
        </li>

        <!-- Nav Item - Entradas pendientes -->
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/OrdenIngresoServlet?action=pendientes">
                <i class="fas fa-fw fa-clipboard-check"></i>
                <span>ENTRADAS PENDIENTES</span></a>
        </li>

        <!-- Nav Item - Historial de Entregas -->
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/InicioDepositoServlet?action=historial">
                <i class="fas fa-fw fa-table"></i>
                <span>HISTORIAL DE ENTREGAS</span></a>
        </li>

        <hr class="sidebar-divider d-none d-md-block">

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
                    <h1 class="h4 mb-0 text-gray-800 font-weight-bold">DETALLE DE SOLICITUD</h1>
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
                            <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
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

                <div class="mb-4">
                    <a href="${pageContext.request.contextPath}/InicioDepositoServlet" class="btn btn-sm btn-light shadow-sm text-secondary">
                        <i class="fas fa-arrow-left fa-sm mr-1"></i> Volver a la bandeja
                    </a>
                </div>

                <div class="row">
                    <div class="col-lg-8">

                        <div class="mb-4 text-dark">
                            <%--                                <h1 class="h3 mb-2 text-gray-800">Solicitud #${solicitud.idSolicitudes}</h1>--%>
                            <p class="mb-1"><strong>Datos del Solicitante:</strong> ${solicitud.solicitante.nombres} ${solicitud.solicitante.apellidoPaterno} ${solicitud.solicitante.apellidoMaterno}</p>
                            <p class="mb-1"><strong>Datos del Coordinador:</strong> ${solicitud.coordinador.nombres} ${solicitud.coordinador.apellidoPaterno} ${solicitud.coordinador.apellidoMaterno}</p>
                            <p class="mb-1"><strong>Fecha y Hora de Aprobación:</strong> <fmt:formatDate value="${solicitud.fechaRevision}" pattern="dd/MM/yyyy HH:mm" /></p>
                            <p class="mb-1"><strong>Estado actual:</strong> <span class="badge badge-success px-2 py-1">Aprobada</span></p>
                            <p class="mb-1"><strong>Propósito:</strong></p>
                            <div class="p-3 bg-light border rounded text-dark">
                                <p>${solicitud.proposito}</p>
                            </div>
                        </div>


                        <div class="card shadow mb-4">

                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-admin">Materiales solicitados</h6>
                            </div>

                            <div class="table-responsive mb-4 shadow-sm">
                                <table class="table table-hover text-gray-800 text-center" width="100%" cellspacing="0">
                                    <thead class="bg-light text-dark">
                                    <tr>
                                        <th>SKU</th>
                                        <th>Producto</th>
                                        <th>Categoría</th>
                                        <th>Cantidad solicitada</th>
                                        <th>Stock actual</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${not empty listaDetalles}">
                                    <c:forEach var="detalle" items="${listaDetalles}">
                                        <tr>
                                            <td class="align-middle">${detalle.producto.siglaCategoria}-${detalle.producto.codigo}</td>
                                            <td class="align-middle">${detalle.producto.nombre}</td>
                                            <td class="align-middle">${detalle.producto.nombreCategoria}</td>
                                            <td class="align-middle">${detalle.cantidad}</td>
                                            <td class="align-middle">${detalle.producto.stockActual}</td>
                                        </tr>
                                    </c:forEach>
                                        </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="7" class="text-center text-muted py-4">
                                                <i class="fas fa-inbox fa-2x mb-2"></i><br>
                                                No hay productos solicitados.
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                    </div>

                    <div class="col-lg-4">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3 bg-admin">
                                <h6 class="m-0 font-weight-bold text-white text-center">¿Entrega completada?</h6>
                            </div>
                            <div class="card-body p-4 text-center">
                                <i class="fas fa-box-open fa-3x text-gray-300 mb-3"></i>
                                <p class="text-gray-800 mb-4">Por favor, haz clic aquí solo después de haber entregado todos los materiales solicitados al usuario. ¡Gracias por mantener nuestro inventario al día!</p>

                                <%--                                    Le colocamos un id al form para que el JavaScript pueda encontrarlo--%>
                                <form id="formProcesarEntrega" action="${pageContext.request.contextPath}/InicioDepositoServlet" method="POST">
                                    <input type="hidden" name="action" value="procesarEntrega">
                                    <input type="hidden" name="idSolicitud" value="${solicitud.idSolicitudes}">

                                    <!-- El botón abre el modal directamente con HTML -->
                                    <button type="button" class="btn btn-admin btn-block py-2 shadow-sm" data-toggle="modal" data-target="#modalConfirmarEntrega">
                                        <i class="fas fa-check-circle mr-2"></i> Marcar como Entregada
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
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
            <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/LogoutServlet">Cerrar Sesión</a>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalConfirmarEntrega" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content border-bottom-admin">
            <div class="modal-body text-center p-5">
                <h4 class="text-dark font-weight-bold">Confirmación de entrega</h4>
                <div class="mb-4 text-left text-dark">
                    <p class="mb-2">¿Estás seguro de que deseas marcar esta solicitud como ENTREGADA?</p>

                    <p class="mb-2">
                        - <strong>Solicitante:</strong> ${solicitud.solicitante.nombres} ${solicitud.solicitante.apellidoPaterno} ${solicitud.solicitante.apellidoMaterno}
                    </p>

                    <p class="mb-1">- <strong>Materiales a entregar:</strong></p>
                    <ul class="small font-weight-bold mb-3 bg-light p-3 rounded" style="list-style-type: none;">
                        <c:forEach var="detalle" items="${listaDetalles}">
                            <li class="mb-1">
                                <i class="fas fa-box-open text-admin mr-2"></i>
                                    ${detalle.cantidad}x ${detalle.producto.nombre}
                                <span class="text-muted">(${detalle.producto.siglaCategoria}-${detalle.producto.codigo})</span>
                            </li>
                        </c:forEach>
                    </ul>

                </div>

                <button type="button" class="btn btn-secondary rounded-pill px-4 mr-2" data-dismiss="modal">Cancelar</button>
                <button type="button" id="btnConfirmarAccionFinal" class="btn btn-admin px-4">Sí, confirmar</button>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Al confirmar dentro del modal, enviamos el formulario al Servlet
        $('#btnConfirmarAccionFinal').on('click', function () {
            // Cerramos el modal visualmente
            $('#modalConfirmarEntrega').modal('hide');

            // Disparamos el POST al servidor
            document.getElementById("formProcesarEntrega").submit();
        });
    });
</script>

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
</body>
</html>