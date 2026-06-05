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

    <title>Verificación de ingreso - Encargado del depósito</title>

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

</head>

<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">

    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-admin sidebar sidebar-dark accordion" id="accordionSidebar">

        <!-- Sidebar - Brand -->
        <a class="sidebar-brand d-flex align-items-center justify-content-center my-4 px-3" href="${pageContext.request.contextPath}/InicioDepositoServlet">
            <div class="sidebar-brand-icon rotate-n-15">
                <i class="fas fa-laugh-wink"></i>
            </div>
            <div class="sidebar-brand-text mx-3">CLAN INVENTORY</div>
        </a>

        <!-- Divider -->
        <hr class="sidebar-divider my-0">

        <!-- Nav Item - Dashboard -->
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
                    <h1 class="h3 mb-0 text-gray-800 font-weight-bold">VERIFICACIÓN DE INGRESO</h1>
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

                            <a class="dropdown-item text-center small text-gray-500" href="#">Mostrar todas las notificaciones</a>
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

                <div class="mb-4">
                    <a href="${pageContext.request.contextPath}/OrdenIngresoServlet?action=pendientes" class="btn btn-sm btn-light shadow-sm text-secondary">
                        <i class="fas fa-arrow-left fa-sm mr-1"></i> Volver a Entradas Pendientes
                    </a>
                </div>

                <form id="formVerificacionIngreso" action="${pageContext.request.contextPath}/OrdenIngresoServlet" method="POST">
                    <input type="hidden" name="action" value="confirmarRecepcion">
                    <input type="hidden" name="idOrdenIngreso" value="${ordenIngreso.idOrdenesIngreso}">

                    <div class="row">

                        <div class="col-lg-8">

                            <div class="mb-4 text-dark">
<%--                                <div class="d-sm-flex align-items-center justify-content-between mb-4">--%>
<%--                                    <h1 class="h3 mb-2 text-gray-800">Orden #<c:out value="${ordenIngreso.idOrdenesIngreso}" default="" /></h1>--%>
<%--                                </div>--%>
                                <p class="mb-1"><strong>Registrado por:</strong> <c:out value="${ordenIngreso.creador.nombres} ${ordenIngreso.creador.apellidoPaterno}" default="-" /></p>
                                <p class="mb-1"><strong>Fecha de orden:</strong> <c:out value="${ordenIngreso.fechaRegistro}" default="-" /></p>
                                <p class="mb-1"><strong>Fecha esperada:</strong> <c:out value="${ordenIngreso.fechaEsperada}" default="-" /></p>
                                <p class="mb-1"><strong>Proveedor:</strong> <c:out value="${ordenIngreso.proveedor}" default="-" /></p>
                                <p class="mb-1"><strong>Estado:</strong> <span class="badge badge-warning text-dark px-2 py-1"><c:out value="${ordenIngreso.estado}" default="Pendiente de Recepción" /></span></p>
                                <p class="mb-1 mt-2"><strong>Observaciones Originales:</strong></p>
                                <div class="p-3 bg-light border rounded text-dark">
                                    <p class="mb-0"><c:out value="${ordenIngreso.observaciones}" default="Sin observaciones." /></p>
                                </div>
                            </div>

                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-admin">
                                        <i class="fas fa-clipboard-check mr-2"></i>Detalle de productos esperados
                                    </h6>
                                </div>
                                <div class="card-body">
                                    <div class="alert alert-info shadow-sm" role="alert">
                                        <i class="fas fa-info-circle mr-2"></i>
                                        Marque el check cuando la cantidad recibida coincida. Si llegó menos o más, desmarque y edite la cantidad recibida antes de confirmar.
                                    </div>

                                    <div class="table-responsive">
                                        <table id="dataTable" class="table table-hover text-gray-800 text-center" width="100%" cellspacing="0">
                                            <thead class="bg-light text-dark">
                                            <tr>
                                                <th class="font-weight-bold">SKU</th>
                                                <th class="font-weight-bold">Producto</th>
                                                <th class="font-weight-bold">Cantidad esperada</th>
                                                <th class="font-weight-bold">Cantidad recibida</th>
                                                <th class="font-weight-bold text-center">Coincide</th>
                                                <th class="font-weight-bold">Observaciones</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:choose>
                                                <c:when test="${not empty detalleOrdenIngreso}">
                                                    <c:forEach var="detalle" items="${detalleOrdenIngreso}">
                                                        <tr>
                                                            <td class="align-middle">SKU: ${detalle.producto.siglaCategoria}-${detalle.producto.codigo}</td>
                                                            <td class="align-middle">
                                                                <input type="hidden" name="idDetalle" value="${detalle.idDetallesOrden}">
                                                                <input type="hidden" name="idProducto_${detalle.idDetallesOrden}" value="${detalle.producto.idProductos}">
                                                                <input type="hidden" name="cantidadEsperada_${detalle.idDetallesOrden}" value="${detalle.cantidadEsperada}">
                                                                    ${detalle.producto.nombre}
                                                            </td>
                                                            <td class="align-middle cantidad-esperada-text">${detalle.cantidadEsperada}</td>
                                                            <td class="align-middle">
                                                                <input type="number" class="form-control form-control-sm cantidad-recibida" name="cantidadRecibida_${detalle.idDetallesOrden}" value="${detalle.cantidadEsperada}" min="0" readonly required>
                                                            </td>
                                                            <td class="text-center align-middle">
                                                                <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" class="custom-control-input check-coincide" id="check_${detalle.idDetallesOrden}" checked>
                                                                    <label class="custom-control-label" for="check_${detalle.idDetallesOrden}"></label>
                                                                </div>
                                                            </td>
                                                            <td class="align-middle">
                                                                <textarea class="form-control form-control-sm" name="observacion_${detalle.idDetallesOrden}" rows="2" placeholder="Sin observaciones"></textarea>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <tr>
                                                        <td colspan="6" class="text-center text-muted py-4">
                                                            <i class="fas fa-box-open fa-2x mb-2"></i><br>
                                                            No hay productos registrados para esta orden.
                                                        </td>
                                                    </tr>
                                                </c:otherwise>
                                            </c:choose>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div> <div class="col-lg-4">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-admin text-center">Acciones de Ingreso</h6>
                            </div>
                            <div class="card-body text-center py-4">
                                <i class="fas fa-clipboard-list fa-3x mb-3 text-gray-300"></i>
                                <p class="text-dark mb-4">Revise los materiales y confirme la recepción en el sistema. El inventario será actualizado automáticamente.</p>

                                <button type="button" id="btnAbrirConfirmacion" class="btn btn-admin btn-block shadow-sm">
                                    <i class="fas fa-check-double mr-2"></i> Confirmar Recepción
                                </button>
                            </div>
                        </div>
                    </div> </div> </form>

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
                    Todas las cantidades recibidas deben ser mayores o iguales a cero.
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Confirmar Recepción -->
    <div class="modal fade" id="modalConfirmarRecepcion" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header bg-admin text-white">
                    <h5 class="modal-title">Confirmar recepción</h5>
                    <button class="close text-white" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    ¿Desea confirmar la recepción de esta orden? El inventario se actualizará con las cantidades recibidas.
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancelar</button>
                    <button class="btn btn-admin" type="button" id="btnConfirmarRecepcion">Confirmar</button>
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

    <!-- Script para DataTables y verificación de cantidades -->
    <script>
        $(document).ready(function() {
            $('#dataTable').DataTable({
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
                    { orderable: false, targets: [4, 5] }
                ]
            });

            // Si el check está marcado, la cantidad recibida coincide con lo esperado
            $(document).on('change', '.check-coincide', function() {
                var fila = $(this).closest('tr');
                var esperada = fila.find('.cantidad-esperada-text').text().trim();
                var recibida = fila.find('.cantidad-recibida');

                if (this.checked) {
                    recibida.val(esperada).prop('readonly', true);
                } else {
                    recibida.prop('readonly', false).focus();
                }
            });

            // Si se edita la cantidad recibida, se actualiza el check según la coincidencia
            $(document).on('input', '.cantidad-recibida', function() {
                if (this.value < 0) {
                    this.value = Math.abs(this.value);
                }
                var fila = $(this).closest('tr');
                var esperada = parseInt(fila.find('.cantidad-esperada-text').text().trim());
                var recibida = parseInt($(this).val());
                var check = fila.find('.check-coincide');

                check.prop('checked', recibida === esperada);
            });

            $('#btnAbrirConfirmacion').on('click', function() {
                var cantidadesValidas = true;

                $('.cantidad-recibida').each(function() {
                    var cantidad = $(this).val();
                    if (cantidad === '' || parseInt(cantidad) < 0) {
                        cantidadesValidas = false;
                    }
                });

                if (!cantidadesValidas) {
                    $('#modalErrorValidacion').modal('show');
                    return;
                }

                $('#modalConfirmarRecepcion').modal('show');
            });

            $('#btnConfirmarRecepcion').on('click', function() {
                $('#formVerificacionIngreso').submit();
            });
        });
    </script>

</body>

</html>