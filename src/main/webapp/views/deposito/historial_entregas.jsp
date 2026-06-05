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

    <title>Historial de Entregas - Depósito</title>

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
        <a class="sidebar-brand d-flex align-items-center justify-content-center href="${pageContext.request.contextPath}/InicioDepositoServlet">
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
        <li class="nav-item active">
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
                    <h1 class="h3 mb-0 text-gray-800 font-weight-bold">HISTORIAL DE ENTREGAS</h1>
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

                <div id="actionToast" class="alert alert-success alert-dismissible fade show shadow mb-4" role="alert" style="display: none;">
                    <i class="fas fa-check-circle mr-2"></i>
                    <strong>¡Éxito!</strong> <span id="toastMessage">La solicitud ha sido procesada.</span>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <!-- Page Heading -->

                <!-- Main Content -->

                <div class="card shadow mb-4">
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                            <h6 class="m-0 font-weight-bold text-admin">Tabla de solicitudes despachadas</h6>
                        </div>
                        <div class="card-body">

                            <form action="${pageContext.request.contextPath}/InicioDepositoServlet" method="GET" class="w-100 mb-4">
                                <input type="hidden" name="action" value="historial">
                                <div class="row align-items-end mb-3">
                                    <div class="col-md-3">
                                        <select name="idSolicitante" class="form-control">
                                            <option value="">Filtrar por Solicitante...</option>
                                            <c:forEach var="sol" items="${listaSolicitantes}">
                                                <option value="${sol.idUsuarios}" ${paramSolicitante == sol.idUsuarios ? 'selected' : ''}>${sol.nombres} ${sol.apellidoPaterno}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <select name="idCoordinador" class="form-control">
                                            <option value="">Filtrar por Coordinador...</option>
                                            <c:forEach var="coord" items="${listaCoordinadores}">
                                                <option value="${coord.idUsuarios}" ${paramCoordinador == coord.idUsuarios ? 'selected' : ''}>${coord.nombres} ${coord.apellidoPaterno}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <input type="date" name="fecha" class="form-control" value="${paramFecha}">
                                    </div>
                                    <div class="col-md-3 d-flex align-items-end">
                                        <button type="submit" class="btn btn-admin flex-grow-1 mr-2"><i class="fas fa-filter"></i> Filtrar</button>
                                        <a href="${pageContext.request.contextPath}/InicioDepositoServlet?action=historial" class="btn btn-light"><i class="fas fa-eraser"></i></a>
                                    </div>
                                </div>
                            </form>

                            <div class="row">

                                <div class="card-body">

                                    <div class="table-responsive">
                                        <table id="dataTable" class="table table-hover text-gray-800">
                                            <thead class="bg-light">
                                            <tr>
                                                <th class="centered font-weight-bold">Fila</th>
                                                <th class="centered font-weight-bold">Solicitante</th>
                                                <th class="centered font-weight-bold">Coordinador</th>
                                                <th class="centered font-weight-bold">Fecha de Entrega</th>
                                                <th class="centered font-weight-bold">Acción</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:choose>
                                                <c:when test="${not empty listaHistorial}">
                                            <c:forEach var="solicitud" items="${listaHistorial}" varStatus="loop">
                                                <tr>
                                                    <td class="align-middle">#${loop.count}</td>
                                                    <td class="align-middle">${solicitud.solicitante.nombres} ${solicitud.solicitante.apellidoPaterno} ${solicitud.solicitante.apellidoMaterno}</td>
                                                    <td class="align-middle">${solicitud.coordinador.nombres} ${solicitud.coordinador.apellidoPaterno} ${solicitud.coordinador.apellidoMaterno}</td>
                                                    <td class="align-middle"><fmt:formatDate value="${solicitud.fechaEntrega}" pattern="dd/MM/yyyy HH:mm" /></td>
                                                    <td class="align-middle">
                                                        <button type="button" class="btn btn-sm btn-admin shadow-sm text-white" onclick="enviarDetalle('${solicitud.idSolicitudes}')">
                                                            <i class="fas fa-eye"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                                </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="7" class="text-center text-muted py-4">
                                                        <i class="fas fa-inbox fa-2x mb-2"></i><br>
                                                        No hay resultados que mostrar.
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

<form id="formVerDetalle" action="${pageContext.request.contextPath}/InicioDepositoServlet" method="POST">
    <input type="hidden" name="action" value="verDetalle">
    <input type="hidden" id="idSolicitudOculto" name="id" value="">
</form>

<script>
    function enviarDetalle(id) {
        document.getElementById('idSolicitudOculto').value = id;
        document.getElementById('formVerDetalle').submit();
    }
</script>

<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">¿Desea salir?</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">Seleccione "Cerrar sesión" a continuación si desea finalizar su sesión actual</div>
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancelar</button>
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

<!-- Script para el filtro -->
<script>
    $(document).ready(function() {

        // 1. Inicializar Select2 con el tema de Bootstrap 4
        $('.select2').select2({
            theme: 'bootstrap4',
            width: '100%'
        });

        // 2. Conectar los filtros a tu tabla
        // Usamos la variable 'dataTable' que ya se creo en datatables-demo.js

        // Filtro de Solicitante (Busca en la columna 1)
        $('#filtroSolicitante').on('change', function() {
            dataTable.column(1).search(this.value).draw();
        });

        // Filtro de Estado (Busca en la columna 4)
        $('#filtroEstado').on('change', function() {
            dataTable.column(4).search(this.value).draw();
        });


    });
</script>

<!-- Opciones de buscador y calendario -->
<script>
    function cambiarFiltro() {
        const tipo = document.getElementById('tipoFiltro').value;
        const contenedor = document.getElementById('contenedorBusqueda');
        const inputBusqueda = document.getElementById('inputBusqueda');
        const inputFecha = document.getElementById('inputFecha');
        const label = document.getElementById('labelBusqueda');

        if (tipo === 'ninguno') {
            contenedor.style.display = 'none';
        } else {
            contenedor.style.display = 'block';

            if (tipo === 'fecha') {
                // Mostrar calendario
                inputBusqueda.style.display = 'none';
                inputFecha.style.display = 'block';
                label.innerText = 'Seleccionar Fecha:';
            } else {
                // Mostrar buscador para Solicitante o Coordinador
                inputBusqueda.style.display = 'block';
                inputFecha.style.display = 'none';
                label.innerText = (tipo === 'solicitante') ? 'Nombre del Solicitante:' : 'Nombre del Coordinador:';
            }
        }
    }
</script>

<script>
    window.onload = function() {
        // 1. Capturamos los parámetros de la URL
        const urlParams = new URLSearchParams(window.location.search);
        const registroStatus = urlParams.get('registro'); // Busca la palabra 'registro'

        // 2. Si la URL dice que hubo un éxito, mostramos la alerta
        if (registroStatus === 'exito') {
            const toast = document.getElementById('actionToast');
            const toastMessage = document.getElementById('toastMessage');

            toastMessage.innerText = 'El producto se ha añadido correctamente.';
            toast.classList.add('alert-success');

            // Mostramos la alerta
            toast.style.display = 'block';

            // Cierre automático después de 5 segundos
            setTimeout(() => {
                $(toast).alert('close'); // Asegúrate de que tu toast soporte esta función de Bootstrap
            }, 5000);

            // Opcional: Limpiar la URL para que si recarga la página no vuelva a salir la alerta
            window.history.replaceState(null, null, window.location.pathname);
        }
    };
</script>

</body>

</html>