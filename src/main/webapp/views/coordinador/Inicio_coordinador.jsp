<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

    <title>Inicio-Coordinador</title>

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
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/InicioCoordinadorServlet?action=inicio">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-laugh-wink"></i>
                </div>
                <div class="sidebar-brand-text mx-3">CLAN INVENTORY</div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/InicioCoordinadorServlet">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>INICIO</span></a>
            </li>

            <!-- Nav Item - Historial de solicitudes -->
            <li class="nav-item">
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
                                        <div class="icon-circle bg-advertencia">
                                            <i class="fas fa-info text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">12 de Abril, 2026</div>
                                        Nueva solicitud 91843700 pendiente de aprobación.
                                    </div>
                                </a>
                                    
                                <a class="dropdown-item text-center small text-gray-500" href="notificaciones.jsp">Mostrar todas las notificaciones</a>
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
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <div id="actionToast" class="alert alert-success alert-dismissible fade show shadow mb-4" role="alert" style="display: none;">
                        <i class="fas fa-check-circle mr-2"></i>
                        <strong>¡Éxito!</strong> <span id="toastMessage">La solicitud ha sido procesada.</span>
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <!--<div class="d-sm-flex align-items-center justify-content-between mb-4">-->

                    <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-auto">
                        <h1 class="h3 mb-0 text-gray-800">Bandeja de solicitudes pendientes</h1>
                    </div>

                    <!-- Main Content -->
                    <div class="card-body">
                        
                        <div class="row">

                            <div class="col-lg-9">

                                <div class="row mb-4">

                                    <div class="col-xl-4 col-md-6 mb-4">
                                        <div class="card border-left-success shadow h-100 py-2">
                                            <div class="card-body">
                                                <div class="row no-gutters align-items-center">
                                                    <div class="col mr-2">
                                                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                            SOLICITUDES APROBADAS</div>
                                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${totalAprobadas != null ? totalAprobadas : 0}</div>
                                                    </div>
                                                    <div class="col-auto">
                                                        <i class="fas fa-check fa-2x text-gray-300"></i>
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
                                                            SOLICITUDES PENDIENTES</div>
                                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${totalPendientes != null ? totalPendientes : 0}</div>
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
                                                            SOLICITUDES RECHAZADAS</div>
                                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${totalRechazadas != null ? totalRechazadas : 0}</div>
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
                                    <!-- DataTales Example -->
                                    <div class="card shadow mb-4">

                                        <div class="card-body">

                                            <form action="${pageContext.request.contextPath}/InicioCoordinadorServlet" method="GET" class="w-100 mb-4">
                                                <input type="hidden" name="action" value="inicio">

                                                <div class="row align-items-end mb-3">
                                                    <div class="col-md-6">
                                                        <input type="text" name="buscar" class="form-control" placeholder="Filtrar por nombre o ID de solicitud..." value="${param.buscar}">
                                                    </div>

                                                    <div class="col-md-3">
                                                        <input type="date" name="fecha" class="form-control text-sm" value="${param.fecha}">
                                                    </div>

                                                    <div class="col-md-3 d-flex align-items-end">
                                                        <button type="submit" class="btn btn-admin flex-grow-1 mr-2">
                                                            <i class="fas fa-filter fa-sm mr-1"></i> Filtrar
                                                        </button>
                                                        <a href="${pageContext.request.contextPath}/InicioCoordinadorServlet?action=inicio" class="btn btn-light shadow-sm">
                                                            <i class="fas fa-eraser text-secondary"></i>
                                                        </a>
                                                    </div>
                                                </div>
                                            </form>

                                            <div class="table-responsive">

                                                <table id="dataTable" class="table table-hover table-striped text-gray-800" >
                                                    <thead class="bg-light">
                                                        <tr>
                                                            <th class="centered font-weight-bold">ID de solicitud</th>
                                                            <th class="centered font-weight-bold">Solicitante</th>
                                                            <th class="centered font-weight-bold">Fecha</th>
                                                            <th class="centered font-weight-bold">Estado</th>
                                                            <th class="centered font-weight-bold">Acción</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:choose>
                                                            <c:when test="${not empty listaPendientes}">
                                                                <c:forEach var="solicitud" items="${listaPendientes}">
                                                                    <tr>
                                                                        <td class="align-middle" data-order="${solicitud.idSolicitudes}">#${solicitud.idSolicitudes}</td>
                                                                        <td class="align-middle">${solicitud.solicitante.nombres} ${solicitud.solicitante.apellidoPaterno} ${solicitud.solicitante.apellidoMaterno}</td>
                                                                        <td class="align-middle">
                                                                            <fmt:formatDate value="${solicitud.fechaSolicitud}" pattern="dd/MM/yyyy HH:mm" />
                                                                        </td>
                                                                        <td class="align-middle">
                                                                            <span class="badge badge-warning px-2 py-1">Pendiente</span>
                                                                        </td>
                                                                        <td class="align-middle">
                                                                            <a href="${pageContext.request.contextPath}/InicioCoordinadorServlet?action=verDetalle&id=${solicitud.idSolicitudes}" class="btn btn-sm shadow-sm btn-admin text-white">
                                                                                <i class="fa-solid fa-eye"></i>
                                                                            </a>
                                                                        </td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <tr>
                                                                    <td colspan="5" class="text-center py-4 text-muted">No hay solicitudes pendientes por revisar. ¡Estás al día!</td>
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
                            
                            <div class="col-lg-3">
                                
                                <div class="card shadow mb-4">
                                    
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-admin">Alertas de Stock</h6>
                                    </div>
                                    
                                    <div class="card-body p-0">

                                        <div class="table-responsive">
                                            
                                            <table class="table table-hover table-striped text-gray-800" width="100%" cellspacing="0">
                                        
                                                <thead class="bg-light">
                                                    <tr>
                                                        <th class="text-center align-middle">Material</th>
                                                        <th class="text-center align-middle">Cantidad</th>
                                                        <th class="text-center align-middle">Estado</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td class="text-left pl-3">Kits Ayuda</td>
                                                        <td class="text-center align-middle">1</td>
                                                        <td class="text-center align-middle"><i class="fas fa-circle text-danger"></i></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-left pl-3">polos</td>
                                                        <td class="text-center align-middle">3</td>
                                                        <td class="text-center align-middle"><i class="fas fa-circle text-danger"></i></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-left pl-3">tasas</td>
                                                        <td class="text-center align-middle">4</td>
                                                        <td class="text-center align-middle"><i class="fas fa-circle text-danger"></i></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-left pl-3">pelotas</td>
                                                        <td class="text-center align-middle">5</td>
                                                        <td class="text-center align-middle"><i class="fas fa-circle text-danger"></i></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-left pl-3">Jengas</td>
                                                        <td class="text-center align-middle">6</td>
                                                        <td class="text-center align-middle"><i class="fas fa-circle text-advertencia"></i></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-left pl-3">medias</td>
                                                        <td class="text-center align-middle">8</td>
                                                        <td class="text-center align-middle"><i class="fas fa-circle text-advertencia"></i></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-left pl-3">bloques</td>
                                                        <td class="text-center align-middle">9</td>
                                                        <td class="text-center align-middle"><i class="fas fa-circle text-advertencia"></i></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-left pl-3">platos</td>
                                                        <td class="text-center align-middle">10</td>
                                                        <td class="text-center align-middle"><i class="fas fa-circle text-advertencia"></i></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-left pl-3">vasos</td>
                                                        <td class="text-center align-middle">10</td>
                                                        <td class="text-center align-middle"><i class="fas fa-circle text-advertencia"></i></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-left pl-3">Legos</td>
                                                        <td class="text-center align-middle">24</td>
                                                        <td class="text-center align-middle"><i class="fas fa-circle text-success"></i></td>
                                                    </tr>
                                                </tbody>
                                            </table>

                                        </div>
                                        
                                        <hr class="m-0">
                                        
                                        <div class="p-2 small text-auto bg-light">
                                            <td class="text-center align-middle"><span class="badge badge-danger px-2 py-1">Crítico</span></td>
                                            <span class="mr-2"><i class="fas fa-circle text-danger"></i> 0 a 5</span>
                                            <td class="text-center align-middle"><span class="badge badge-advertencia px-2 py-1">bajo</span></td>
                                            <span class="mr-2"><i class="fas fa-circle text-warning"></i> 6 a 10</span>
                                            <td class="text-center align-middle"><span class="badge badge-success px-2 py-1">Óptimo</span></td>
                                            <span class="mt-1 d-inline-block"><i class="fas fa-circle text-success"></i> 11 a más</span>
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
    <script src="${pageContext.request.contextPath}/js/demo/datatables-InicioCoord.js"></script>

    <script>
        window.onload = function() {
            // 1. Capturamos los parámetros de la URL
            const urlParams = new URLSearchParams(window.location.search);
            const accion = urlParams.get('action'); // Busca la palabra 'aprobada' o 'rechazada'
            const idSolicitud = urlParams.get('id'); // Busca el número de solicitud

            // 2. Si existen ambos parámetros, configuramos y mostramos la alerta
            if (accion && idSolicitud) {
                const toast = document.getElementById('actionToast');
                const toastMessage = document.getElementById('toastMessage');
                
                // 3. Cambiamos el texto dinámicamente
                if (accion === 'aprobada') {
                    toastMessage.innerText = `La solicitud #${idSolicitud} ha sido aprobada correctamente.`;
                    toast.classList.add('alert-success');
                } else if (accion === 'rechazada') {
                    toastMessage.innerText = `La solicitud #${idSolicitud} ha sido rechazada correctamente.`;
                    // Cambiamos el color a rojo/advertencia si fue un rechazo
                    toast.classList.remove('alert-success');
                    toast.classList.add('alert-success'); 
                }

                // 4. Mostramos la alerta en pantalla
                toast.style.display = 'block';
                
                // 5. Cierre automático después de 5 segundos (5000 milisegundos)
                setTimeout(() => {
                    $(toast).alert('close');
                }, 5000);
            }
        };
    </script>


</body>

</html>