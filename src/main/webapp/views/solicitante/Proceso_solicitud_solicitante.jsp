<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Proceso de Solicitud - Solicitante</title>

    <!-- Fuentes e iconos -->
    <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,300,400,600,700,800,900" rel="stylesheet">

    <!-- Tema SB Admin 2 y estilos del solicitante -->
    <link href="${pageContext.request.contextPath}/css/sb-admin-2.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style_solicitante.css" rel="stylesheet">
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
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/InicioSolicitanteServlet">
                <i class="fas fa-fw fa-tachometer-alt"></i><span>INICIO</span></a>
        </li>
        <li class="nav-item active">
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
                <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                    <i class="fa fa-bars"></i>
                </button>
                <div class="d-none d-sm-inline-block mr-auto ml-md-3 my-2 my-md-0 mw-100">
                    <h1 class="h3 mb-0 text-gray-800 font-weight-bold">PROCESO DE SOLICITUD</h1>
                </div>
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item dropdown no-arrow mx-1">
                        <a class="nav-link" href="#"><i class="fas fa-bell fa-fw"></i>
                            <span class="badge badge-danger badge-counter">3+</span></a>
                    </li>
                    <div class="topbar-divider d-none d-sm-block"></div>
                    <li class="nav-item dropdown no-arrow">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="mr-2 d-none d-lg-inline text-gray-600 small">${sessionScope.usuario.nombres}</span>
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

                <%-- Avisos de error --%>
                <c:if test="${param.error == 'motivo'}">
                    <div class="alert alert-danger alert-dismissible fade show shadow mb-4" role="alert">
                        <i class="fas fa-exclamation-triangle mr-2"></i> Debes escribir el motivo de la solicitud.
                        <button type="button" class="close" data-dismiss="alert"><span>&times;</span></button>
                    </div>
                </c:if>
                <c:if test="${param.error == 'vacia'}">
                    <div class="alert alert-danger alert-dismissible fade show shadow mb-4" role="alert">
                        <i class="fas fa-exclamation-triangle mr-2"></i> Agrega al menos un producto a la cajita.
                        <button type="button" class="close" data-dismiss="alert"><span>&times;</span></button>
                    </div>
                </c:if>
                <c:if test="${param.error == 'db'}">
                    <div class="alert alert-danger alert-dismissible fade show shadow mb-4" role="alert">
                        <i class="fas fa-exclamation-triangle mr-2"></i> Ocurrió un error al guardar la solicitud. Intenta de nuevo.
                        <button type="button" class="close" data-dismiss="alert"><span>&times;</span></button>
                    </div>
                </c:if>

                <form id="solicitudForm" method="post"
                      action="${pageContext.request.contextPath}/ProcesoSolicitudSolicitanteServlet">
                    <input type="hidden" name="action" value="enviar">

                    <div class="row">
                        <%-- ============ TABLA DE PRODUCTOS SELECCIONADOS ============ --%>
                        <div class="col-12">
                            <div class="card shadow mb-4">
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-admin">Tabla de productos seleccionados</h6>
                                    <a class="btn btn-admin shadow-sm"
                                       href="${pageContext.request.contextPath}/NuevaSolicitudSolicitanteServlet">
                                        <i class="fas fa-plus fa-sm text-white-50"></i> Agregar productos
                                    </a>
                                </div>
                                <div class="card-body p-0">
                                    <div class="table-responsive">
                                        <table class="table table-hover table-striped text-gray-800 mb-0">
                                            <thead class="bg-light text-dark text-center">
                                                <tr>
                                                    <th class="align-middle">Código</th>
                                                    <th class="align-middle">Imagen</th>
                                                    <th class="align-middle">Producto</th>
                                                    <th class="align-middle">Stock actual</th>
                                                    <th class="align-middle">Cantidad solicitada</th>
                                                    <th class="align-middle">Acción</th>
                                                </tr>
                                            </thead>
                                            <tbody class="text-sm text-center">
                                                <c:forEach var="item" items="${cajita}">
                                                    <tr>
                                                        <td class="align-middle">${item.sku}</td>
                                                        <td class="align-middle">
                                                            <%-- La imagen se asigna por JavaScript segun el id del producto --%>
                                                            <img data-pid="${item.idProductos}"
                                                                 alt="${item.nombre}" class="rounded"
                                                                 style="width:50px;height:50px;object-fit:cover;"
                                                                 onerror="imgFallback(this)">
                                                        </td>
                                                        <td class="align-middle text-left">${item.nombre}</td>
                                                        <td class="align-middle">${item.stockActual}</td>
                                                        <td class="align-middle" style="width:160px;">
                                                            <div class="input-group input-group-sm mx-auto" style="width:120px;">
                                                                <div class="input-group-prepend">
                                                                    <button class="btn btn-outline-secondary px-2" type="button"
                                                                            onclick="modificarCantidad('cant_${item.idProductos}', -1, ${item.stockActual})">
                                                                        <i class="fas fa-minus"></i></button>
                                                                </div>
                                                                <input type="number" id="cant_${item.idProductos}"
                                                                       name="cantidad_${item.idProductos}"
                                                                       class="form-control text-center font-weight-bold form-control-sm"
                                                                       value="${item.cantidad}" min="1" max="${item.stockActual}"
                                                                       oninput="validarCantidad(this, ${item.stockActual})">
                                                                <div class="input-group-append">
                                                                    <button class="btn btn-outline-secondary px-2" type="button"
                                                                            onclick="modificarCantidad('cant_${item.idProductos}', 1, ${item.stockActual})">
                                                                        <i class="fas fa-plus"></i></button>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td class="align-middle">
                                                            <a class="btn btn-outline-danger btn-sm"
                                                               href="${pageContext.request.contextPath}/ProcesoSolicitudSolicitanteServlet?action=eliminar&id=${item.idProductos}"
                                                               title="Quitar producto">
                                                                <i class="fas fa-trash"></i></a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>

                                                <c:if test="${empty cajita}">
                                                    <tr>
                                                        <td colspan="6" class="text-center text-muted py-5">
                                                            <i class="fas fa-box-open fa-2x mb-2"></i><br>
                                                            La cajita está vacía. Agrega productos desde "Nueva Solicitud".
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%-- ============ PROPÓSITO Y ENVÍO ============ --%>
                        <div class="col-lg-8 mx-auto">
                            <div class="card shadow-sm mb-4 border-left-soli">
                                <div class="card-header py-3 bg-white border-bottom-0">
                                    <h5 class="m-0 font-weight-bold text-dark">
                                        <i class="fas fa-edit text-warning mr-2"></i>Propósito de solicitud</h5>
                                </div>
                                <div class="card-body pt-0">
                                    <div class="form-group">
                                        <textarea class="form-control" id="motivo" name="motivo" rows="5"
                                                  placeholder="Escriba el motivo de su solicitud..."></textarea>
                                        <div class="invalid-feedback">
                                            Por favor, escriba una justificación para enviar la solicitud.
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-end mt-4">
                                        <button type="submit" class="btn btn-admin px-4"
                                                <c:if test="${empty cajita}">disabled</c:if>>
                                            Enviar solicitud <i class="fas fa-paper-plane ml-1"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </form>

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

<script>
    // ====================================================================
    //  URLs de las imágenes de cada producto (clave = id del producto).
    //  Debe ser la misma lista que la de Nueva_solicitud_solicitante.jsp.
    // ====================================================================
    var imagenesProductos = {
        1: "https://wongfood.vtexassets.com/arquivos/ids/528434/Monopoly-Nacional-Refresh-3-194924360.jpg?v=637825638728370000",
        2: "https://oechsle.vteximg.com.br/arquivos/ids/7505304-1000-1000/276846.jpg?v=637819672141670000",
        3: "https://http2.mlstatic.com/D_NQ_NP_812555-MPE44911060056_022021-O.webp",
        4: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXBG4RH-jhftry-FSUFW56OQWcK5A1F2Bv4w&s",
        5: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSO8GJBFaOs1mBB10eNq_FtNsHGS1M1wTOnyw&s"
    };

    // Imagen de respaldo cuando un producto no tiene URL asignada o falla al cargar
    function imgFallback(img) {
        img.onerror = null;
        img.src = "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='50' height='50'%3E%3Crect width='50' height='50' fill='%23f1f1f1'/%3E%3C/svg%3E";
    }

    // Asignar a cada producto su imagen segun el id
    document.querySelectorAll('img[data-pid]').forEach(function (img) {
        var url = imagenesProductos[img.getAttribute('data-pid')];
        if (url) { img.src = url; } else { imgFallback(img); }
    });

    // Botones + / - de cantidad
    function modificarCantidad(id, delta, maximo) {
        var input = document.getElementById(id);
        var val = parseInt(input.value);
        if (isNaN(val)) val = 1;
        val = val + delta;
        if (val < 1) val = 1;
        if (val > maximo) val = maximo;
        input.value = val;
    }

    // Validación de la cantidad escrita a mano
    function validarCantidad(input, maximo) {
        var val = parseInt(input.value);
        if (isNaN(val) || val < 1) input.value = 1;
        else if (val > maximo) input.value = maximo;
    }

    // Antes de enviar: validar que se haya escrito el motivo
    document.getElementById('solicitudForm').addEventListener('submit', function (e) {
        var motivo = document.getElementById('motivo');
        if (!motivo.value.trim()) {
            e.preventDefault();
            motivo.classList.add('is-invalid');
            motivo.focus();
        }
    });
</script>

</body>
</html>
