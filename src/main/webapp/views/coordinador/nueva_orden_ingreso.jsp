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

    <title>Nueva orden de ingreso</title>

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

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <%-- El administrador y el coordinador usan esta misma vista.
             Se muestra la barra lateral que corresponde al rol en sesión. --%>
        <c:set var="rolActual" value="${sessionScope.usuario.rol}" />

        <c:choose>
            <c:when test="${rolActual == 'Coordinador' or rolActual == 'coordinador' or sessionScope.rol == 'coordinador'}">
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
                    <li class="nav-item active">
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
            </c:when>
            <c:otherwise>
                <!-- Sidebar -->
                <ul class="navbar-nav bg-gradient-admin sidebar sidebar-dark accordion" id="accordionSidebar">

                    <!-- Sidebar - Brand -->
                    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/InicioAdminServlet">
                        <div class="sidebar-brand-icon rotate-n-15">
                            <i class="fas fa-laugh-wink"></i>
                        </div>
                        <div class="sidebar-brand-text mx-3">CLAN INVENTORY </div>
                    </a>

                    <!-- Divider -->
                    <hr class="sidebar-divider my-0">

                    <!-- Nav Item - INICIO -->
                    <li class="nav-item">
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

                    <%-- Nav Item - GESTION DE INVENTARIO --%>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/ProductosServlet">
                            <i class="fas fa-fw fa-box mr"></i>
                            <span>GESTION DE INVENTARIO</span></a>
                    </li>

                    <!-- Nav Item - Nueva orden de ingreso -->
                    <li class="nav-item active">
                        <a class="nav-link" href="${pageContext.request.contextPath}/OrdenIngresoServlet?action=nueva">
                            <i class="fas fa-fw fa-dolly"></i>
                            <span>NUEVA ORDEN DE INGRESO</span></a>
                    </li>

                    <!-- Nav Item - REPORTES -->
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/views/administrador/Reportes_administrador.jsp">
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
            </c:otherwise>
        </c:choose>

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
                    
                    <!-- Section Title (Topbar) -->
                    <div class="d-none d-sm-inline-block mr-auto ml-md-3 my-2 my-md-0 mw-100">
                        <h1 class="h3 mb-0 text-gray-800 font-weight-bold">NUEVA ORDEN DE INGRESO</h1>
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
                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="alertsDropdown">
                                <h6 class="dropdown-header bg-admin text-white border-0">
                                    Centro de Alertas
                                </h6>

                                <c:choose>
                                    <c:when test="${not empty listaNotificaciones}">
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
                                    </c:when>
                                    <c:otherwise>
                                        <a class="dropdown-item d-flex align-items-center" href="#">
                                            <div class="mr-3">
                                                <div class="icon-circle bg-info">
                                                    <i class="fas fa-box text-white"></i>
                                                </div>
                                            </div>
                                            <div>
                                                <div class="small text-gray-500">Hoy</div>
                                                No tienes notificaciones nuevas.
                                            </div>
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                                
                                <a class="dropdown-item text-center small text-gray-500" href="notificaciones.jsp">Mostrar todas las notificaciones</a>
                            </div>
                        </li>

                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small"><c:out value="${sessionScope.usuario.nombres}" default="Usuario" /></span>
                                <img class="img-profile rounded-circle"
                                    src="${pageContext.request.contextPath}/img/undraw_profile.svg">
                            </a>
                            
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="#">
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
                    <c:if test="${param.msg == 'success'}">
                        <div class="alert alert-success alert-dismissible fade show shadow mb-4" role="alert">
                            <i class="fas fa-check-circle mr-2"></i>
                            <strong>¡Éxito!</strong> La orden de ingreso fue registrada correctamente.
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>

                    <c:if test="${param.msg == 'error'}">
                        <div class="alert alert-danger alert-dismissible fade show shadow mb-4" role="alert">
                            <i class="fas fa-exclamation-circle mr-2"></i>
                            No se pudo registrar la orden. Verifique que haya seleccionado productos y cantidades válidas.
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>

                    <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">Registrar orden de ingreso</h1>
                    </div>

                    <form id="formOrdenIngreso" action="${pageContext.request.contextPath}/OrdenIngresoServlet" method="POST">
                        <input type="hidden" name="action" value="registrar">

                        <!-- Datos generales de la orden -->
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-admin">
                                    <i class="fas fa-clipboard-list mr-2"></i>Datos generales de la orden
                                </h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <label class="font-weight-bold text-dark">Fecha esperada de recepción:</label>
                                        <input type="date" class="form-control" name="fechaEsperada" required>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label class="font-weight-bold text-dark">Proveedor o donante:</label>
                                        <input type="text" class="form-control" name="proveedor" placeholder="Ej: Donación / Proveedor externo">
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label class="font-weight-bold text-dark">Responsable:</label>
                                        <input type="text" class="form-control" value="${sessionScope.usuario.nombres}" readonly>
                                    </div>
                                </div>
                                <div class="form-group mb-0">
                                    <label class="font-weight-bold text-dark">Observaciones generales:</label>
                                    <textarea class="form-control" name="observaciones" rows="3" placeholder="Detalle adicional de la orden..."></textarea>
                                </div>
                            </div>
                        </div>

                        <!-- Tabla de productos -->
                        <div class="card shadow mb-4">
                            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                <h6 class="m-0 font-weight-bold text-admin">
                                    <i class="fas fa-boxes mr-2"></i>Productos esperados
                                </h6>
                                <button type="button" id="btnAbrirConfirmacion" class="btn btn-admin shadow-sm">
                                    <i class="fas fa-save fa-sm text-white-50 mr-1"></i> Registrar orden
                                </button>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table id="dataTable" class="table table-hover text-gray-800" width="100%" cellspacing="0">
                                        <thead class="bg-light">
                                            <tr>
                                                <th class="text-center">Seleccionar</th>
                                                <th class="font-weight-bold">SKU</th>
                                                <th class="font-weight-bold">Producto</th>
                                                <th class="font-weight-bold">Categoría</th>
                                                <th class="font-weight-bold">Stock actual</th>
                                                <th class="font-weight-bold">Cantidad esperada</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:choose>
                                                <c:when test="${not empty listaProductos}">
                                                    <c:forEach var="producto" items="${listaProductos}">
                                                        <tr>
                                                            <td class="text-center align-middle">
                                                                <input type="checkbox" class="seleccionar-producto" name="productosSeleccionados" value="${producto.idProductos}">
                                                            </td>
                                                            <td class="align-middle">SKU: ${producto.siglaCategoria}-${producto.codigo}</td>
                                                            <td class="align-middle">${producto.nombre}</td>
                                                            <td class="align-middle">${producto.nombreCategoria}</td>
                                                            <td class="align-middle">${producto.stockActual}</td>
                                                            <td class="align-middle">
                                                                <input type="number" class="form-control form-control-sm cantidad-esperada" name="cantidadEsperada_${producto.idProductos}" min="1" placeholder="0" disabled>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <tr>
                                                        <td colspan="6" class="text-center text-muted py-4">
                                                            <i class="fas fa-box-open fa-2x mb-2"></i><br>
                                                            No se encontraron productos para registrar en la orden.
                                                        </td>
                                                    </tr>
                                                </c:otherwise>
                                            </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                    </form>

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

    <!-- Modal Error Validacion -->
    <div class="modal fade" id="modalErrorValidacion" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content border-left-danger shadow">
                <div class="modal-header">
                    <h5 class="modal-title text-danger"><i class="fas fa-exclamation-triangle mr-2"></i>Error de Validación</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body text-dark">
                    Seleccione al menos un producto y registre una cantidad esperada válida (mayor a 0).
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Confirmar Registro -->
    <div class="modal fade" id="modalConfirmarOrden" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header bg-admin text-white">
                    <h5 class="modal-title">Confirmar orden de ingreso</h5>
                    <button class="close text-white" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    ¿Desea registrar la orden con los productos y cantidades seleccionadas?
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancelar</button>
                    <button class="btn btn-admin" type="button" id="btnConfirmarOrden">Confirmar</button>
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
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

    <!-- Script para DataTables y validación del formulario -->
    <script>
        $(document).ready(function() {
            var dataTable = $('#dataTable').DataTable({
                language: {
                    decimal: "",
                    emptyTable: "No hay información disponible",
                    info: "Mostrando _START_ a _END_ de _TOTAL_ registros",
                    infoEmpty: "Mostrando 0 a 0 de 0 registros",
                    infoFiltered: "(filtrado de _MAX_ registros totales)",
                    lengthMenu: "Mostrar _MENU_ registros",
                    loadingRecords: "Cargando...",
                    processing: "Procesando...",
                    search: "Buscar:",
                    zeroRecords: "No se encontraron resultados",
                    paginate: {
                        first: "Primero",
                        last: "Último",
                        next: "Siguiente",
                        previous: "Anterior"
                    }
                },
                columnDefs: [
                    { orderable: false, targets: [0, 5] }
                ]
            });

            $('.select2').select2({ theme: 'bootstrap4', width: '100%' });

            // Habilitar la cantidad solo cuando el producto esté seleccionado
            $(document).on('change', '.seleccionar-producto', function() {
                var fila = $(this).closest('tr');
                var cantidad = fila.find('.cantidad-esperada');
                cantidad.prop('disabled', !this.checked);

                if (this.checked) {
                    cantidad.attr('required', true).focus();
                } else {
                    cantidad.val('').removeAttr('required');
                }
            });

            $('#btnAbrirConfirmacion').on('click', function() {
                var seleccionados = $('.seleccionar-producto:checked').length;
                var cantidadesValidas = true;

                $('.seleccionar-producto:checked').each(function() {
                    var cantidad = $(this).closest('tr').find('.cantidad-esperada').val();
                    if (!cantidad || parseInt(cantidad) <= 0) {
                        cantidadesValidas = false;
                    }
                });

                if (seleccionados === 0 || !cantidadesValidas) {
                    $('#modalErrorValidacion').modal('show');
                    return;
                }

                $('#modalConfirmarOrden').modal('show');
            });

            $('#btnConfirmarOrden').on('click', function() {
                $('#formOrdenIngreso').submit();
            });

            // Evitar ingreso de números negativos
            $(document).on('input', '.cantidad-esperada', function() {
                if (this.value < 0) {
                    this.value = Math.abs(this.value);
                }
            });

            // Desaparecer alerta de éxito después de 4.5 segundos
            setTimeout(function() {
                $('.alert-success').fadeTo(500, 0).slideUp(500, function(){
                    $(this).remove(); 
                });
            }, 4500);
        });
    </script>

</body>

</html>
