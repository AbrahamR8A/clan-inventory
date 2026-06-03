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

    <title>Inicio - Encargado del depósito</title>

    <!-- Custom fonts for this template-->
    <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="${pageContext.request.contextPath}/css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <link href="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    <!-- Select2 -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

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

            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/InicioDepositoServlet">
                    <i class="fas fa-fw fa-home"></i>
                    <span>INICIO</span></a>
            </li>

            <!-- Nav Item - Historial de Entregas -->
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/InicioDepositoServlet?action=historial">
                    <i class="fas fa-fw fa-table"></i>
                    <span>HISTORIAL DE ENTREGAS</span></a>
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
                                        <span class="font-weight-bold">Coordinador x aprobó la solicitud 91843830.</span>
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
                                        <span class="font-weight-bold">Coordinador y aprobó la solicitud 91843829.</span>
                                    </div>
                                </a>
                                        
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-info">
                                            <i class="fas fa-box text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">12 de Abril, 2026</div>
                                        Realizaste la entrega de la solicitud 91843700.
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
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">Douglas McGee</span>
                                <img class="img-profile rounded-circle"
                                    src="${pageContext.request.contextPath}/img/undraw_profile.svg">
                            </a>
                            
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/views/deposito/perfil_deposito.jsp">
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

                    <!-- Toast -->
                    <div id="deliveryToast" class="alert alert-success alert-dismissible fade show shadow mb-4" role="alert" style="display: none;">
                        <i class="fas fa-check-circle mr-2"></i>
                        <strong>¡Éxito!</strong> La solicitud ha sido marcada como entregada correctamente.
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>


                    <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-1">
                        <h1 class="h3 mb-0 text-gray-800">Bandeja de solicitudes</h1>
                    </div>
                    
                    <!-- Main Content -->
                    <div class="card-body">

                        <div class="row mb-2">

                            <div class="col-xl-4 col-md-6 mb-4">
                                <div class="card border-left-info shadow h-100 py-2">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                                    SOLICITUDES ENTREGADAS</div>
                                                <div class="h5 mb-0 font-weight-bold text-gray-800">${totalEntregadas}</div>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fa-solid fa-truck fa-2x text-gray-300"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-4 col-md-6 mb-4">
                                <div class="card border-left-warning shadow h-100 py-2">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                                    SOLICITUDES POR ENTREGAR</div>
                                                <div class="h5 mb-0 font-weight-bold text-gray-800">${totalAprobadas}</div>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fas fa-clock fa-2x text-gray-300"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-4 col-md-6 mb-4">
                                <div class="card border-left-danger shadow h-100 py-2">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">
                                                    SOLICITUDES ATRASADAS</div>
                                                <div class="h5 mb-0 font-weight-bold text-gray-800">?</div>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fa-solid fa-hourglass-half fa-2x text-gray-300"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    
                        <div class="card shadow mb-4">

                        
                            <div class="card-body">

                                <div class="row mb-3">

                                    <form action="${pageContext.request.contextPath}/InicioDepositoServlet" method="GET" class="w-100">
                                        <div class="row mb-3">

                                            <div class="col-md-3">
                                                <select name="idSolicitante" id="filtroSolicitante" class="form-control select2" style="width: 100%;">
                                                    <option value="">Filtrar por Solicitante...</option>
                                                    <c:forEach var="solicitante" items="${listaSolicitantes}">
                                                        <option value="${solicitante.idUsuarios}" ${paramSolicitante == solicitante.idUsuarios ? 'selected' : ''}>
                                                                ${solicitante.nombres} ${solicitante.apellidoPaterno} ${solicitante.apellidoMaterno}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <div class="col-md-3">
                                                <select name="idCoordinador" id="filtroRol" class="form-control select2" style="width: 100%;">
                                                    <option value="">Filtrar por Coordinador...</option>
                                                    <c:forEach var="coord" items="${listaCoordinadores}">
                                                        <option value="${coord.idUsuarios}" ${paramCoordinador == coord.idUsuarios ? 'selected' : ''}>
                                                                ${coord.nombres} ${coord.apellidoPaterno} ${coord.apellidoMaterno}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <div class="col-md-3">
                                                <input type="date" name="fecha" class="form-control text-sm" value="${paramFecha}">
                                            </div>

                                            <div class="col-md-3 d-flex align-items-end">
                                                <button type="submit" class="btn btn-admin flex-grow-1 mr-2">
                                                    <i class="fas fa-filter fa-sm mr-1"></i>Filtrar
                                                </button>
                                                <a href="${pageContext.request.contextPath}/InicioDepositoServlet" class="btn btn-light shadow-sm">
                                                    <i class="fas fa-eraser text-secondary"></i>
                                                </a>
                                            </div>

                                        </div>
                                    </form>

                                </div>

                                <div class="table-responsive">
                                    <table id="dataTable" class="table table-hover table-striped text-gray-800" >
                                        <thead class="bg-white text-dark">
                                            <tr>
                                                <th class="centered font-weight-bold">Fila</th>
                                                <th class="centered font-weight-bold">Solicitante</th>
                                                <th class="centered font-weight-bold">Coordinador</th>
                                                <th class="centered font-weight-bold">Fecha de aprobación</th>
                                                <th class="centered font-weight-bold">Acción</th>
                                            </tr>
                                        </thead>
                                        <tbody class="text-sm">
                                        <c:choose>
                                            <c:when test="${not empty listaBandeja}">
                                                <c:forEach var="solicitud" items="${listaBandeja}" varStatus="loop">
                                                    <tr>
                                                        <td class="align-middle">#${loop.count}</td>

                                                        <td class="align-middle">${solicitud.solicitante.nombres} ${solicitud.solicitante.apellidoPaterno} ${solicitud.solicitante.apellidoMaterno}</td>

                                                        <td class="align-middle">${solicitud.coordinador.nombres} ${solicitud.coordinador.apellidoPaterno} ${solicitud.coordinador.apellidoMaterno}</td>

                                                        <td class="align-middle">
                                                            <fmt:formatDate value="${solicitud.fechaRevision}" pattern="dd/MM/yyyy HH:mm" />
                                                        </td>

                                                        <td class="align-middle">
                                                            <button type="button" class="btn btn-sm btn-light shadow-sm text-secondary" onclick="enviarDetalle('${solicitud.idSolicitudes}')">
                                                                <i class="fas fa-pen fa-sm"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="5" class="text-center py-4 text-muted">No hay solicitudes pendientes de entrega en la bandeja.</td>
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
                <!-- /.container-fluid -->

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
            <!-- End of Main Content -->

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

    <!-- Bootstrap core JavaScript-->
    <script src="${pageContext.request.contextPath}/vendor/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="${pageContext.request.contextPath}/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="${pageContext.request.contextPath}/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="${pageContext.request.contextPath}/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="${pageContext.request.contextPath}/js/demo/datatables-demo.js"></script>

    <!-- Formulario para los botones de 'Ver Detalle'-->
    <form id="formVerDetalle" action="${pageContext.request.contextPath}/InicioDepositoServlet" method="POST">
        <input type="hidden" name="action" value="verDetalle">
        <input type="hidden" id="idSolicitudOculto" name="id" value="">
    </form>

    <script>
    function enviarDetalle(id) {
    // 1. Asignamos el ID al input oculto del formulario global
    document.getElementById('idSolicitudOculto').value = id;
    // 2. Enviamos el formulario
    document.getElementById('formVerDetalle').submit();
    }
    </script>

    <script>
        window.onload = function() {
            // Check for delivery success parameter in URL
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('delivery') === 'success') {
                const toast = document.getElementById('deliveryToast');
                if(toast) {
                    toast.style.display = 'block';
                    
                    // Auto-close alert after 5 seconds
                    setTimeout(() => {
                        $(toast).alert('close');
                    }, 5000);
                }
            }
        };
    </script>


</body>

</html>
