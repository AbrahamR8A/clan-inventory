<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Detalles de solicitud procesadas-Coordinador</title>

    <!-- Custom fonts for this template-->
    <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
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
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/InicioCoordinadorServlet?action=inicio">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-laugh-wink"></i>
                </div>
                <div class="sidebar-brand-text mx-3">CLAN INVENTORY</div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/InicioCoordinadorServlet?action=inicio">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>INICIO</span></a>
            </li>

            <!-- Nav Item - Historial de solicitudes -->
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/InicioCoordinadorServlet?action=historial">
                    <i class="fas fa-fw fa-table"></i>
                    <span>HISTORIAL DE SOLICITUDES</span></a>
            </li>

            <!-- Nav Item - Nueva orden de ingreso -->
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/OrdenIngresoServlet?action=nueva">
                    <i class="fas fa-fw fa-dolly"></i>
                    <span>NUEVA ORDEN DE INGRESO</span></a>
            </li>

            <!-- Divider -->
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
                        <h1 class="h3 mb-0 text-gray-800 font-weight-bold">DETALLES DE SOLICITUD - PROCESADO</h1>
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
                                <span class="badge badge-danger badge-counter">3+</span>
                            </a>
                            <!-- Dropdown - Alerts -->
                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="alertsDropdown">
                                <h6 class="dropdown-header bg-admin text-white border-0">
                                    Centro de Alertas
                                </h6>
                                
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-success">
                                            <i class="fas fa-check text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">13 de Abril, 2026</div>
                                        <span class="font-weight-bold">Aprobaste la solicitud 91843830.</span>
                                    </div>
                                </a>

                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-success">
                                            <i class="fas fa-check text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">13 de Abril, 2026</div>
                                        <span class="font-weight-bold">Aprobaste la solicitud 91843829.</span>
                                    </div>
                                </a>
                                        
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-warning">
                                            <i class="fas fa-info text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">12 de Abril, 2026</div>
                                        Nueva solicitud 91843700 pendiente de aprobación.
                                    </div>
                                </a>
                                    
                                <a class="dropdown-item text-center small text-gray-500" href="notificaciones.html">Mostrar todas las notificaciones</a>
                            </div>
                        </li>

            

                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">Abraham Ramirez</span>
                                <img class="img-profile rounded-circle"
                                    src="../../img/undraw_profile.svg">
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
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading 
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">Bandeja de solicitudes pendientes</h1>
                    </div>
                    -->

                    <!-- Main Content -->
                    <div class="card-body">
                        
                        <div class="row">

                            <div class="col-lg-8">
                                
                                <!--<h4 class="mb-4 font-weight-bold text-dark">Detalles de solicitud - pasada</h4>-->

                                <div class="mb-4 text-dark">
                                    <h1 class="h3 mb-2 text-gray-800">Solicitud #${solicitud.idSolicitudes}</h1>
                                    <p class="mb-1"><strong>Datos del Solicitante:</strong> ${solicitud.solicitante.nombres} ${solicitud.solicitante.apellidoPaterno} ${solicitud.solicitante.apellidoMaterno}</p>
                                    <p class="mb-1"><strong>Fecha y Hora de Solicitud:</strong> <fmt:formatDate value="${solicitud.fechaSolicitud}" pattern="dd/MM/yyyy HH:mm" /></p>
                                    <p class="mb-1"><strong>Fecha y Hora de Revisión:</strong> <fmt:formatDate value="${solicitud.fechaRevision}" pattern="dd/MM/yyyy HH:mm" /></p>
                                    <p class="mb-1"><strong>Estado:</strong> <span class="badge ${solicitud.estado == 'aprobada' ? 'badge-success' : 'badge-danger'} px-2 py-1">${solicitud.estado}</span></p>
                                    <p class="mb-1"><strong>Propósito:</strong></p>
                                    <div class="p-3 bg-light border rounded text-dark">
                                        <p>${solicitud.proposito}</p>
                                    </div>
                                </div>

                                <div class="card shadow mb-4">

                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-admin">Materiales Solicitados</h6>
                                    </div>
                                    
                                    <div class="table-responsive mb-4 shadow-sm">
                                        <table class="table table-hover table-striped text-gray-800 text-center" width="100%" cellspacing="0">
                                            <thead class="bg-light text-dark">
                                                <tr>
                                                    <th>SKU</th>
                                                    <th>Producto</th>
                                                    <th>Categoría</th>
                                                    <th>Cantidad</th>
                                                    <th>Stock Actual</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="detalle" items="${listaDetalles}">
                                                    <tr>
                                                        <td class="align-middle">${detalle.producto.siglaCategoria}-${detalle.producto.codigo}</td>
                                                        <td class="align-middle">${detalle.producto.nombre}</td>
                                                        <td class="align-middle">${detalle.producto.nombreCategoria}</td>
                                                        <td class="align-middle">${detalle.cantidad}</td>
                                                        <td class="align-middle">${detalle.producto.stockActual}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>

                                </div>


                                <c:choose>
                                    <c:when test="${solicitud.estado == 'rechazada'}">
                                        <div class="card shadow-sm mb-4 border-left-danger bg-light">
                                            <div class="card-body">
                                                <h6 class="font-weight-bold text-danger mb-3">
                                                    <i class="fas fa-times-circle mr-2"></i> Solicitud Rechazada
                                                </h6>
                                                <div class="form-group mb-0">
                                                    <label class="small font-weight-bold text-dark">Motivo del rechazo:</label>
                                                    <div class="p-2 text-dark" style="min-height: 60px;">
                                                        ${solicitud.comentarioRechazo}
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:when test="${solicitud.estado == 'aprobada'}">
                                        <div class="card shadow-sm mb-4 border-left-success bg-light">
                                            <div class="card-body">
                                                <h6 class="font-weight-bold text-success mb-0">
                                                    <i class="fas fa-check-circle mr-2"></i> Solicitud Aprobada Exitosamente
                                                </h6>
                                                <p class="p-2 text-dark">Los materiales ya fueron descontados del inventario y notificados al depósito.</p>
                                            </div>
                                        </div>
                                    </c:when>
                                </c:choose>

                            </div>

                            <div class="col-lg-4">
                                
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-admin">Información Adicional</h6>
                                    </div>
                                    <div class="card-body text-center py-5 text-muted">
                                        <i class="fas fa-folder-open fa-3x mb-3 text-gray-300"></i>
                                        <p class="mb-0">Registro histórico de solo lectura.</p>
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
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/LogoutServlet">Cerrar Sesión</a>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="confirmacionModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content border-primary">
            <div class="modal-body text-center p-5">
                <h5 class="text-dark mb-4" id="textoConfirmacion">¿Desea marcar la solicitud como ...?</h5>
                <button type="button" class="btn btn-outline-secondary px-4 mr-2" data-dismiss="modal">No</button>
                <a href="#" class="btn btn-primary px-4">Sí</a>
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


</body>

</html>