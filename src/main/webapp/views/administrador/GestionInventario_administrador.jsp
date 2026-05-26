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

    <title>Gestión de inventario-Administrador</title>

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
            <a class="sidebar-brand d-flex align-items-center justify-content-center"
               href="${pageContext.request.contextPath}/InicioAdminServlet">
                <div class="logo-quintaola-box">
                    <img src="${pageContext.request.contextPath}/img/quintaola_logo.png"
                         alt="Quinta Ola"
                         class="logo-quintaola-sidebar">
                </div>
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
                    <span>GESTIÓN DE USUARIOS</span></a>
            </li>

            <!-- Divider -->
            <!--<hr class="sidebar-divider">-->

            <%-- Nav Item - GESTION DE INVENTARIO --%>
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/ProductosServlet">
                    <i class="fas fa-fw fa-box mr"></i>
                    <span>GESTIÓN DE INVENTARIO</span></a>
            </li>

            <!-- Divider -->
            <!--<hr class="sidebar-divider">-->

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

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
                    
                    <!-- Section Title (Topbar) -->
                    <div class="d-none d-sm-inline-block mr-auto ml-md-3 my-2 my-md-0 mw-100">
                        <h1 class="h3 mb-0 text-gray-800 font-weight-bold">GESTIÓN DE INVENTARIO</h1>
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

                    <div id="actionToast" class="alert alert-success alert-dismissible shadow mb-4" role="alert" style="display: none;">
                        <i class="fas fa-check-circle mr-2"></i>
                        <strong>¡Éxito!</strong> <span id="toastMessage">El producto se ha añadido correctamente.</span>
                        
                        <button type="button" class="close" onclick="$('#actionToast').fadeOut();">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <!-- Page Heading -->

                    <!-- Main Content -->

                    <div class="card shadow mb-4">
                        <!-- DataTales Example -->
                        <div class="card shadow mb-4">
                            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                <h6 class="m-0 font-weight-bold text-admin">Tabla de Inventario Actual</h6>
                                
                                <button type="button" class="btn btn-admin shadow-sm" data-toggle="modal" data-target="#modalCrearProducto">
                                    <i class="fas fa-plus fa-sm text-white-50"></i> Nuevo Producto
                                </button>

                            </div>
                                <div class="card-body">

                                    <%-- Formulario de filtros (GET al servidor, igual que usuarios) --%>
                                    <form action="${pageContext.request.contextPath}/ProductosServlet" method="GET" class="w-100 mb-4">
                                        <div class="row no-gutters align-items-center mb-3">

                                            <div class="col-md-4 pr-2">
                                                <input type="text" name="buscar" class="form-control"
                                                    placeholder="Buscar por nombre o código..."
                                                    value="${busquedaActual}">
                                            </div>

                                            <div class="col-md-3 pr-2">
                                                <select name="filtro_categoria" class="form-control select2" style="width:100%;">
                                                    <option value="">Filtrar por Categoría...</option>
                                                    <c:forEach var="cat" items="${listaCategorias}">
                                                        <option value="${cat.idCategorias}"
                                                            ${categoriaActual == cat.idCategorias ? 'selected' : ''}>
                                                            ${cat.nombre}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <div class="col-md-2 pr-2">
                                                <select name="filtro_estado" class="form-control select2" style="width:100%;">
                                                    <option value="">Filtrar por Estado...</option>
                                                    <option value="optimo"  ${estadoActual == 'optimo'  ? 'selected' : ''}>Óptimo</option>
                                                    <option value="bajo"    ${estadoActual == 'bajo'    ? 'selected' : ''}>Bajo</option>
                                                    <option value="critico" ${estadoActual == 'critico' ? 'selected' : ''}>Crítico</option>
                                                </select>
                                            </div>

                                            <div class="col-md-3 d-flex justify-content-between">
                                                <button type="submit" class="btn btn-admin flex-grow-1 mr-2" style="height:38px;">
                                                    <i class="fas fa-filter fa-sm mr-1"></i>
                                                </button>
                                                <a href="${pageContext.request.contextPath}/ProductosServlet" class="btn btn-light shadow-sm">
                                                    <i class="fas fa-eraser text-secondary"></i>
                                                </a>
                                            </div>

                                        </div>
                                    </form>

                                <div class="table-responsive">
                                    <table id="dataTable" class="table table-hover text-gray-800">
                                        <thead class="bg-light">
                                            <tr>
                                                <th class="centered font-weight-bold">Código</th>
                                                <th class="centered font-weight-bold">Producto</th>
                                                <th class="centered font-weight-bold">Categoría</th>
                                                <th class="centered font-weight-bold">Stock</th>
                                                <th class="centered font-weight-bold">Estado</th>
                                                <th class="centered font-weight-bold">Acción</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:choose>
                                                <c:when test="${not empty listaProductos}">
                                                    <c:forEach var="producto" items="${listaProductos}">
                                                        <tr>
                                                            <td>SKU: ${producto.siglaCategoria}-${producto.codigo}</td>
                                                            <td>${producto.nombre}</td>
                                                            <td>${producto.nombreCategoria}</td>
                                                            <td>${producto.stockActual}</td>
                                                            <td class="text-center align-middle">
                                                                <c:choose>
                                                                    <c:when test="${producto.estadoStock == 'critico'}">
                                                                        <span class="badge badge-danger px-2 py-1">Crítico</span>
                                                                    </c:when>
                                                                    <c:when test="${producto.estadoStock == 'bajo'}">
                                                                        <span class="badge badge-advertencia px-2 py-1">Bajo</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge badge-success px-2 py-1">Óptimo</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td>
                                                                <button type="button" class="btn btn-sm shadow-sm btn-editar-producto"
                                                                    data-id="${producto.idProductos}"
                                                                    data-codigo="${producto.codigo}"
                                                                    data-nombre="${producto.nombre}"
                                                                    data-stock="${producto.stockActual}"
                                                                    data-stockbajo="${producto.stockBajo}"
                                                                    data-stockcritico="${producto.stockCritico}"
                                                                    data-categoria="${producto.idCategorias}"
                                                                    data-activo="${producto.activo}"
                                                                    data-descripcion="${producto.descripcion}">
                                                                    <i class="fa-solid fa-pencil"></i>
                                                                </button>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <tr>
                                                        <td colspan="6" class="text-center">No se encontraron productos.</td>
                                                    </tr>
                                                </c:otherwise>
                                            </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                </div>

                                <hr class="m-0">
                                
                                <div class="p-3 text-center bg-light">
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
                    <h5 class="modal-title" id="exampleModalLabel">¿Desea salir?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Seleccione "Cerrar sesión" a continuación si desea finalizar su sesión actual</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancelar</button>
                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/login.jsp">Cerrar Sesión</a>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalCrearProducto" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content border-0 shadow-lg rounded-lg">
                <div class="modal-header bg-white">
                    <h5 class="m-0 font-weight-bold text-admin">Registrar Nuevo Producto</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body p-4">
                    <div class="row">
                        <div class="col-lg-7">
                            <form id="formNuevoProducto" class="text-left" method="POST"
                                action="${pageContext.request.contextPath}/ProductosServlet"
                                enctype="multipart/form-data">
                                <div class="form-row mb-3">
                                    <div class="form-group col-md-4">
                                        <label class="font-weight-bold text-dark small">Código</label>
                                        <input type="text" class="form-control" id="inputCodigo" name="codigo" placeholder="Ej: 0101" required>
                                    </div>
                                    <div class="form-group col-md-8">
                                        <label class="font-weight-bold text-dark small">Producto</label>
                                        <input type="text" class="form-control" id="inputProducto" name="nombre" placeholder="Nombre del producto..." required>
                                    </div>
                                </div>
                                <div class="form-row mb-3">
                                    <div class="form-group col-md-4">
                                        <label class="font-weight-bold text-dark small">Stock Inicial</label>
                                        <input type="number" class="form-control" id="inputStock" name="stock_actual" min="0" placeholder="0" required>
                                    </div>
                                    <div class="form-group col-md-8">
                                        <label class="font-weight-bold text-dark small">Categoría</label>
                                        <select id="inputCategoria" name="id_categorias" class="form-control border-left-success" required>
                                            <option value="">Seleccione una categoría...</option>
                                            <c:forEach var="cat" items="${listaCategorias}">
                                                <option value="${cat.idCategorias}">${cat.nombre}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group mb-0">
                                    <label class="font-weight-bold text-dark small">Detalles del producto</label>
                                    <textarea class="form-control" id="inputDetalles" name="descripcion" rows="3"
                                        placeholder="Descripción, marca, color o especificaciones..."></textarea>
                                </div>
                                <!-- Campos ocultos para stock_bajo y stock_critico con valores por defecto -->
                                <input type="hidden" name="stock_bajo" value="10">
                                <input type="hidden" name="stock_critico" value="5">
                            </form>
                        </div>

                        <div class="col-lg-5 d-flex flex-column align-items-center justify-content-between border-left">
                            <div class="foto-container text-center w-100 mb-3 d-flex flex-column align-items-center">
                                <img id="previewCrear" src="${pageContext.request.contextPath}/img/box-placeholder.svg"
                                    class="rounded-circle mb-2 border"
                                    style="width:110px;height:110px;object-fit:cover;
                                           display:none;">
                                <div id="placeholderCrear" class="mb-2 p-4 bg-light rounded-circle border"
                                    style="width:110px;height:110px;display:inline-flex;align-items:center;justify-content:center;">
                                    <i class="fas fa-box-open fa-3x text-gray-300"></i>
                                </div>
                                <label for="inputImagenCrear" class="btn btn-outline-secondary btn-sm px-3 mt-2 mb-0" style="cursor:pointer;">
                                    Subir Imagen
                                </label>
                                <input type="file" id="inputImagenCrear" name="imagen" accept="image/*"
                                    class="d-none" form="formNuevoProducto">
                            </div>
                            <div class="w-100 text-center mt-auto">
                                <button type="button" class="btn btn-admin btn-block shadow-sm" id="btnRegistrarProducto" disabled>
                                    Registrar Producto
                                </button>
                                <button type="button" class="btn btn-light btn-block btn-sm mt-2" data-dismiss="modal">Cancelar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- Modal confirmación Registrar --%>
    <div class="modal fade" id="modalConfirmarRegistro" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content border-bottom-admin shadow-lg rounded-lg">
                <div class="modal-body text-center p-5">
                    <h4 class="text-dark font-weight-bold">¿Registrar Producto?</h4>
                    <p class="mb-4 text-left">
                        Verifique que los datos del nuevo producto sean correctos:<br><br>
                        - <strong>Código:</strong> <span id="resumenCodigo" class="font-weight-bold"></span><br>
                        - <strong>Producto:</strong> <span id="resumenProducto" class="font-weight-bold"></span><br>
                        - <strong>Stock:</strong> <span id="resumenStock" class="font-weight-bold"></span> unidades<br>
                        - <strong>Categoría:</strong> <span id="resumenCategoria" class="font-weight-bold"></span><br>
                    </p>
                    <button type="button" class="btn btn-secondary rounded-pill px-4 mr-2" data-dismiss="modal">Cancelar</button>
                    <button type="button" id="btnConfirmarAccionFinal" class="btn btn-admin px-4">Sí, registrar</button>
                </div>
            </div>
        </div>
    </div>

    <%-- Modal Editar Producto --%>
    <div class="modal fade" id="modalEditarProducto" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content border-0 shadow-lg rounded-lg">
                <div class="modal-header bg-white">
                    <h5 class="m-0 font-weight-bold text-admin">Editar Producto</h5>
                    <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                </div>
                <div class="modal-body p-4">
                    <div class="alert alert-warning py-2 mb-3">
                        <div class="custom-control custom-checkbox">
                            <input type="checkbox" class="custom-control-input" id="checkConfirmarEdicionProducto">
                            <label class="custom-control-label font-weight-bold" for="checkConfirmarEdicionProducto">
                                Confirmo que deseo editar los datos de este producto
                            </label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-8">
                            <form id="formEditarProducto" method="POST"
                                action="${pageContext.request.contextPath}/ProductosServlet"
                                enctype="multipart/form-data">
                                <input type="hidden" name="action" id="editActionProducto" value="editar">
                                <input type="hidden" name="id_producto" id="editIdProducto">
                                <div class="form-row mb-3">
                                    <div class="form-group col-md-4">
                                        <label class="font-weight-bold text-dark small">Código</label>
                                        <input type="text" class="form-control" id="editCodigoProducto" name="codigo" required disabled>
                                    </div>
                                    <div class="form-group col-md-8">
                                        <label class="font-weight-bold text-dark small">Nombre</label>
                                        <input type="text" class="form-control" id="editNombreProducto" name="nombre" required disabled>
                                    </div>
                                </div>
                                <div class="form-row mb-3">
                                    <div class="form-group col-md-6">
                                        <label class="font-weight-bold text-dark small">Umbral Stock Bajo</label>
                                        <input type="number" class="form-control" id="editStockBajo" name="stock_bajo" min="0" required disabled>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label class="font-weight-bold text-dark small">Umbral Stock Crítico</label>
                                        <input type="number" class="form-control" id="editStockCritico" name="stock_critico" min="0" required disabled>
                                    </div>
                                </div>
                                <div class="form-group mb-3">
                                    <label class="font-weight-bold text-dark small">Categoría</label>
                                    <select id="editCategoriaProducto" name="id_categorias" class="form-control border-left-success" disabled>
                                        <c:forEach var="cat" items="${listaCategorias}">
                                            <option value="${cat.idCategorias}">${cat.nombre}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group mb-3">
                                    <label class="font-weight-bold text-dark small">Detalles del producto</label>
                                    <textarea class="form-control" id="editDescripcionProducto" name="descripcion"
                                        rows="2" placeholder="Descripción, marca, color o especificaciones..."
                                        disabled></textarea>
                                </div>
                                <div class="form-group mb-0">
                                    <label class="font-weight-bold text-dark small">Imagen del producto</label>
                                    <label for="inputImagenEditar" class="btn btn-outline-secondary btn-sm w-100" style="cursor:pointer;">
                                        <i class="fas fa-upload mr-1"></i> Cambiar imagen
                                    </label>
                                    <input type="file" id="inputImagenEditar" name="imagen" accept="image/*" class="d-none" disabled>
                                </div>
                            </form>
                        </div>
                        <div class="col-lg-4 d-flex flex-column align-items-center justify-content-center border-left">
                            <img id="previewEditar"
                                style="width:110px;height:110px;object-fit:cover;border-radius:50%;display:none;"
                                class="mb-2 border" alt="Foto del producto">
                            <div id="placeholderEditar"
                                class="mb-2 p-4 bg-light rounded-circle border"
                                style="width:110px;height:110px;display:inline-flex;align-items:center;justify-content:center;">
                                <i class="fas fa-fw fa-box-open fa-3x text-gray-300"></i>
                            </div>
                            <div class="w-100 text-center mt-3">
                                <button type="button" class="btn btn-admin btn-block shadow-sm mb-3" id="btnGuardarProducto" disabled>Guardar Cambios</button>
                                <button type="button" class="btn btn-danger btn-block shadow-sm d-none" id="btnDesactivarProducto" disabled><i class="fas fa-ban mr-1"></i> Desactivar</button>
                                <button type="button" class="btn btn-success btn-block shadow-sm d-none" id="btnActivarProducto" disabled><i class="fas fa-check mr-1"></i> Activar</button>
                                <button type="button" class="btn btn-light btn-block btn-sm mt-2" data-dismiss="modal">Cancelar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- Modal confirmación Desactivar producto --%>
    <div class="modal fade" id="modalConfirmarDesactivarProducto" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content border-bottom-danger">
                <div class="modal-body text-center p-5">
                    <h4 class="text-dark font-weight-bold">¿Desactivar Producto?</h4>
                    <p class="mb-4 text-left">¿Estás seguro? El producto dejará de estar disponible en el sistema.</p>
                    <button type="button" class="btn btn-secondary rounded-pill px-4 mr-2" data-dismiss="modal">Cancelar</button>
                    <button type="button" id="btnConfirmarDesactivarProducto" class="btn btn-danger px-4">Sí, desactivar</button>
                </div>
            </div>
        </div>
    </div>

    <%-- Modal confirmación Activar producto --%>
    <div class="modal fade" id="modalConfirmarActivarProducto" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content border-bottom-success">
                <div class="modal-body text-center p-5">
                    <h4 class="text-dark font-weight-bold">¿Activar Producto?</h4>
                    <p class="mb-4 text-left">¿Estás seguro? El producto volverá a estar disponible en el sistema.</p>
                    <button type="button" class="btn btn-secondary rounded-pill px-4 mr-2" data-dismiss="modal">Cancelar</button>
                    <button type="button" id="btnConfirmarActivarProducto" class="btn btn-success px-4">Sí, activar</button>
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
    <script src="${pageContext.request.contextPath}/js/demo/datatables-GestInventarioAdmin.js"></script>

    <script>
    $(document).ready(function() {
        $('.select2').select2({ theme: 'bootstrap4', width: '100%' });
    });
    </script>

    <script>
    document.addEventListener("DOMContentLoaded", function() {
        // ── Modal CREAR ──────────────────────────────────────────────────────
        const Codigo       = document.getElementById("inputCodigo");
        const Producto     = document.getElementById("inputProducto");
        const Stock        = document.getElementById("inputStock");
        const Categoria    = document.getElementById("inputCategoria");
        const btnRegistrar = document.getElementById("btnRegistrarProducto");
        const inputImgCrear   = document.getElementById("inputImagenCrear");
        const previewCrear    = document.getElementById("previewCrear");
        const placeholderCrear = document.getElementById("placeholderCrear");

        function evaluarBotonCrear() {
            btnRegistrar.disabled = !(
                Codigo.value.trim() && Producto.value.trim() &&
                Stock.value.trim()  && Categoria.value
            );
        }
        [Codigo, Producto, Stock].forEach(el => el.addEventListener("input", evaluarBotonCrear));
        Categoria.addEventListener("change", evaluarBotonCrear);

        // Preview imagen al crear
        inputImgCrear.addEventListener("change", function() {
            if (this.files && this.files[0]) {
                const reader = new FileReader();
                reader.onload = e => {
                    previewCrear.src = e.target.result;
                    previewCrear.style.display = "block";
                    placeholderCrear.style.display = "none";
                };
                reader.readAsDataURL(this.files[0]);
            }
        });

        $('#btnRegistrarProducto').on('click', function() {
            $('#resumenCodigo').text(Codigo.value.trim());
            $('#resumenProducto').text(Producto.value.trim());
            $('#resumenStock').text(Stock.value.trim());
            $('#resumenCategoria').text(Categoria.options[Categoria.selectedIndex].text);
            $('#modalCrearProducto').modal('hide');
            $('#modalConfirmarRegistro').modal('show');
        });

        $('#btnConfirmarAccionFinal').on('click', function() {
            $('#modalConfirmarRegistro').modal('hide');
            document.getElementById("formNuevoProducto").submit();
        });

        // ── Modal EDITAR ─────────────────────────────────────────────────────
        const formEditar   = document.getElementById('formEditarProducto');
        const editAction   = document.getElementById('editActionProducto');
        const checkEditar  = document.getElementById('checkConfirmarEdicionProducto');
        const btnGuardar   = document.getElementById('btnGuardarProducto');
        const btnDesact    = document.getElementById('btnDesactivarProducto');
        const btnAct       = document.getElementById('btnActivarProducto');
        const inputImgEditar     = document.getElementById('inputImagenEditar');
        const previewEditar      = document.getElementById('previewEditar');
        const placeholderEditar  = document.getElementById('placeholderEditar');
        const camposEditar = ['editCodigoProducto','editNombreProducto','editStockBajo','editStockCritico','editCategoriaProducto','editDescripcionProducto'];

        function actualizarEdicion() {
            const ok = checkEditar.checked;
            camposEditar.forEach(id => document.getElementById(id).disabled = !ok);
            inputImgEditar.disabled = !ok;
            btnGuardar.disabled = !ok;
            if (!btnDesact.classList.contains('d-none')) btnDesact.disabled = !ok;
            if (!btnAct.classList.contains('d-none'))   btnAct.disabled   = !ok;
        }
        checkEditar.addEventListener('change', actualizarEdicion);

        // Preview imagen al cambiar en edición
        inputImgEditar.addEventListener('change', function() {
            if (this.files && this.files[0]) {
                const reader = new FileReader();
                reader.onload = e => {
                    previewEditar.src = e.target.result;
                    previewEditar.style.display = 'block';
                    placeholderEditar.style.display = 'none';
                };
                reader.readAsDataURL(this.files[0]);
            }
        });

        $('#modalEditarProducto').on('show.bs.modal', function() {
            checkEditar.checked = false;
            actualizarEdicion();
        });

        document.querySelectorAll('.btn-editar-producto').forEach(btn => {
            btn.addEventListener('click', function() {
                document.getElementById('editIdProducto').value        = this.dataset.id;
                document.getElementById('editCodigoProducto').value    = this.dataset.codigo;
                document.getElementById('editNombreProducto').value    = this.dataset.nombre;
                document.getElementById('editStockBajo').value         = this.dataset.stockbajo;
                document.getElementById('editStockCritico').value      = this.dataset.stockcritico;
                document.getElementById('editCategoriaProducto').value = this.dataset.categoria;
                document.getElementById('editDescripcionProducto').value = this.dataset.descripcion || '';
                const activo = parseInt(this.dataset.activo);
                btnDesact.classList.toggle('d-none', activo !== 1);
                btnAct.classList.toggle('d-none',    activo === 1);
                // Cargar foto desde el servidor
                const idProducto = this.dataset.id;
                const fotoUrl = '${pageContext.request.contextPath}/ProductosServlet?action=foto&id=' + idProducto + '&t=' + Date.now();
                previewEditar.onload = () => {
                    previewEditar.style.display = 'block';
                    placeholderEditar.style.display = 'none';
                };
                previewEditar.onerror = () => {
                    previewEditar.style.display = 'none';
                    placeholderEditar.style.display = 'flex';
                };
                previewEditar.src = fotoUrl;
                $('#modalEditarProducto').modal('show');
            });
        });

        btnGuardar.addEventListener('click', function() {
            editAction.value = 'editar';
            camposEditar.forEach(id => document.getElementById(id).disabled = false);
            inputImgEditar.disabled = false;
            formEditar.submit();
        });

        btnDesact.addEventListener('click', function() {
            $('#modalEditarProducto').modal('hide');
            $('#modalConfirmarDesactivarProducto').modal('show');
        });
        btnAct.addEventListener('click', function() {
            $('#modalEditarProducto').modal('hide');
            $('#modalConfirmarActivarProducto').modal('show');
        });
        document.getElementById('btnConfirmarDesactivarProducto').addEventListener('click', function() {
            editAction.value = 'desactivar';
            document.getElementById('editIdProducto').disabled = false;
            formEditar.submit();
        });
        document.getElementById('btnConfirmarActivarProducto').addEventListener('click', function() {
            editAction.value = 'activar';
            document.getElementById('editIdProducto').disabled = false;
            formEditar.submit();
        });

        // ── Toast de éxito por parámetro msg en URL ──────────────────────────
        const params = new URLSearchParams(window.location.search);
        const msg = params.get('msg');
        if (msg) {
            const textos = {
                'success':           'El producto se ha registrado correctamente.',
                'edit_success':      'El producto se ha actualizado correctamente.',
                'deactivate_success':'El producto ha sido desactivado.',
                'activate_success':  'El producto ha sido reactivado exitosamente.',
                'error':             '❌ Error al guardar el producto. Verifique el código y que no exista duplicado.'
            };
            if (textos[msg]) {
                $('#toastMessage').text(textos[msg]);
                $('#actionToast').fadeIn();
                setTimeout(() => $('#actionToast').fadeOut(), 5000);
                window.history.replaceState(null, null, window.location.pathname);
            }
        }
    });
    </script>

</body>
</html>
