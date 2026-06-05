<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="es">

        <head>

            <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
            <meta name="description" content="">
            <meta name="author" content="">

            <title>Gestion de usuarios-Administrador</title>

            <!-- Custom fonts for this template-->
            <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
                type="text/css">
            <link
                href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
                rel="stylesheet">

            <!-- Custom styles for this template-->
            <link href="${pageContext.request.contextPath}/css/sb-admin-2.min.css" rel="stylesheet">

            <style>
                .badge-depo {
                    background-color: #23b1be !important;
                    color: #ffffff !important;
                }

                .badge-superadmin {
                    background: linear-gradient(135deg, #ff2a9e 0%, #7203c1 100%) !important;
                    color: #ffffff !important;
                }
            </style>

            <!-- Custom styles for this page -->
            <link href="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.min.css"
                rel="stylesheet">

            <!-- Font Awesome -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"
                integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw=="
                crossorigin="anonymous" referrerpolicy="no-referrer" />

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
                    <li class="nav-item active">
                        <a class="nav-link" href="${pageContext.request.contextPath}/UsuariosServlet">
                            <i class="fas fa-fw fa-users mr"></i>
                            <span>GESTION DE USUARIOS</span></a>
                    </li>

                    <!-- Nav Item - GESTION DE INVENTARIO -->
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/ProductosServlet">
                            <i class="fas fa-fw fa-box mr"></i>
                            <span>GESTION DE INVENTARIO</span></a>
                    </li>

                    <!-- Nav Item - Nueva orden de ingreso -->
                    <li class="nav-item">
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

                <!-- Content Wrapper -->
                <div id="content-wrapper" class="d-flex flex-column">

                    <!-- Main Content -->
                    <div id="content">

                        <!-- Topbar -->
                        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                            <!-- Section Title (Topbar) -->
                            <div class="d-none d-sm-inline-block mr-auto ml-md-3 my-2 my-md-0 mw-100">
                                <h1 class="h3 mb-0 text-gray-800 font-weight-bold">GESTION DE USUARIOS</h1>
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

                            <div id="actionToast" class="alert alert-success alert-dismissible shadow mb-4" role="alert"
                                style="display: none;">
                                <i class="fas fa-check-circle mr-2"></i>
                                <strong>¡Éxito!</strong> <span id="toastMessage">El usuario se ha registrado
                                    correctamente.</span>

                                <button type="button" class="close" onclick="$('#actionToast').fadeOut();">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>

                            <!-- Page Heading -->

                            <!-- Main Content -->

                            <div class="card shadow mb-4">
                                <!-- DataTales Example -->
                                <div class="card shadow mb-4">
                                    <div
                                        class="card-header py-3 d-flex flex-row align-items-center justify-content-between">

                                        <div>

                                            <h6 class="m-0 font-weight-bold text-admin">Tabla de administración de personal</h6>
                                            <small class="text-muted d-block mt-1" style="font-size:0.78rem;">
                                                Listado de todos los integrantes registrados en el sistema. Permite gestionar roles, estados y datos de acceso.
                                            </small>

                                        </div>

                                        <button type="button" class="btn btn-admin shadow-sm" data-toggle="modal"
                                            data-target="#modalCrearUsuario">
                                            <i class="fas fa-plus fa-sm text-white-50"></i> Nuevo Usuario
                                        </button>

                                    </div>
                                    <div class="card-body">
                                        <form action="${pageContext.request.contextPath}/UsuariosServlet" method="GET" class="w-100 mb-4">
                                            <div class="row no-gutters align-items-center mb-3">

                                                <div class="col-md-3 pr-2">
                                                    <%-- label --%>
                                                    <input type="text" name="buscar" class="form-control" placeholder="Buscar por nombre o correo..." value="${busquedaActual}">
                                                </div>

                                                <div class="col-md-3 pr-2">
                                                    <%-- <label class="small font-weight-bold text-dark">Por Usuario:</label> --%>
                                                    <select name="filtro_usuario_id" class="form-control select2" style="width: 100%;">
                                                        <option value="">Filtrar por Usuario...</option>
                                                        <c:forEach var="u" items="${listaCompletaUsuarios}">
                                                            <option value="${u.idUsuarios}" ${usuarioActual == u.idUsuarios ? 'selected' : ''}>
                                                                    ${u.nombres} ${u.apellidoPaterno} ${u.apellidoMaterno}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>

                                                <div class="col-md-2 pr-2">
                                                    <%--<label class="small font-weight-bold text-dark">Por Rol:</label>--%>
                                                    <select name="filtro_rol" class="form-control select2" style="width: 100%;">
                                                        <option value="">Filtrar por Rol...</option>
                                                        <option value="administrador" ${rolActual == 'administrador' ? 'selected' : ''}>Administrador</option>
                                                        <option value="coordinador" ${rolActual == 'coordinador' ? 'selected' : ''}>Coordinador</option>
                                                        <option value="solicitante" ${rolActual == 'solicitante' ? 'selected' : ''}>Solicitante</option>
                                                        <option value="encargado_deposito" ${rolActual == 'encargado_deposito' ? 'selected' : ''}>Encargado de depósito</option>
                                                    </select>
                                                </div>

                                                <div class="col-md-2 pr-2">
                                                    <%--<label class="small font-weight-bold text-dark">Por Estado:</label>--%>
                                                    <select name="filtro_estado" class="form-control select2" style="width: 100%;">
                                                        <option value="">Filtrar por Estado...</option>
                                                        <option value="1" ${estadoActual == '1' ? 'selected' : ''}>Activo</option>
                                                        <option value="0" ${estadoActual == '0' ? 'selected' : ''}>Inactivo</option>
                                                        <%-- <option value="2" ${estadoActual == '2' ? 'selected' : ''}>Pendiente</option> --%>
                                                    </select>

                                                </div>

                                                <div class="col-md-2 d-flex justify-content-between">
                                                    <button type="submit" class="btn btn-admin flex-grow-1 mr-2" style="height: 38px;">
                                                        <i class="fas fa-filter fa-sm mr-1"></i>
                                                    </button>
                                                    <a href="${pageContext.request.contextPath}/UsuariosServlet" class="btn btn-light shadow-sm">
                                                        <i class="fas fa-eraser text-secondary"></i>
                                                    </a>
                                                </div>
                                            </div>
                                        </form>
                                        <div class="table-responsive">

                                            <table id="dataTable" class="table table-hover text-gray-800">
                                                <thead class="bg-light">
                                                    <tr>
                                                        <th class="centered font-weight-bold">Usuario</th>
                                                        <th class="centered font-weight-bold">Correo</th>
                                                        <th class="centered font-weight-bold">Roles</th>
                                                        <th class="centered font-weight-bold">Estado</th>
                                                        <th class="centered font-weight-bold">Acción</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:choose>
                                                        <c:when test="${not empty listaUsuarios}">
                                                            <c:forEach var="usuario" items="${listaUsuarios}">
                                                                <tr>
                                                                    <td>${usuario.nombres} ${usuario.apellidoPaterno}
                                                                        ${usuario.apellidoMaterno}</td>

                                                                    <td>
                                                                        <span class="correo-text">${usuario.correo}</span>
                                                                        <button type="button"
                                                                                class="btn btn-sm shadow-sm btn-copiar-correo"
                                                                                data-correo="${usuario.correo}"
                                                                                title="Copiar correo">
                                                                            <i class="far fa-copy"></i>
                                                                        </button>
                                                                    </td>

                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when
                                                                                test="${usuario.rol == 'administrador'}">
                                                                                <span
                                                                                    class="badge badge-admin px-2 py-1">Administrador</span>
                                                                            </c:when>
                                                                            <c:when
                                                                                test="${usuario.rol == 'superadmin'}">
                                                                                <span
                                                                                    class="badge badge-superadmin px-2 py-1">Super
                                                                                    Administrador</span>
                                                                            </c:when>
                                                                            <c:when
                                                                                test="${usuario.rol == 'coordinador'}">
                                                                                <span
                                                                                    class="badge badge-coord px-2 py-1">Coordinador</span>
                                                                            </c:when>
                                                                            <c:when
                                                                                test="${usuario.rol == 'encargado_deposito'}">
                                                                                <span
                                                                                    class="badge badge-depo px-2 py-1">Encargado
                                                                                    de depósito</span>
                                                                            </c:when>
                                                                            <c:when
                                                                                test="${usuario.rol == 'solicitante'}">
                                                                                <span
                                                                                    class="badge badge-soli px-2 py-1">Solicitante</span>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <span
                                                                                    class="badge badge-secondary px-2 py-1">${usuario.rol}</span>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>

                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${usuario.activo == 1}">Activo</c:when>
                                                                            <%--<c:when test="${usuario.activo == 2}">
                                                                                Pendiente</c:when>--%>
                                                                            <c:otherwise>Inactivo</c:otherwise>
                                                                        </c:choose>
                                                                    </td>

                                                                    <td>
                                                                        <button type="button"
                                                                            class="btn btn-sm shadow-sm btn-editar"
                                                                            data-id="${usuario.idUsuarios}"
                                                                            data-nombres="${usuario.nombres}"
                                                                            data-apellidop="${usuario.apellidoPaterno}"
                                                                            data-apellidom="${usuario.apellidoMaterno}"
                                                                            data-correo="${usuario.correo}"
                                                                            data-rol="${usuario.rol}"
                                                                            data-activo="${usuario.activo}">
                                                                            <i class="fa-solid fa-pencil"></i>
                                                                        </button>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <tr>
                                                                <td colspan="5" class="text-center">No se encontraron
                                                                    usuarios registrados.</td>
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
                        <div class="modal-body">Seleccione "Cerrar sesión" a continuación si desea finalizar su sesión
                            actual</div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancelar</button>
                            <a class="btn btn-primary" href="${pageContext.request.contextPath}/LogoutServlet">Cerrar Sesión</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="modalCrearUsuario" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                    <div class="modal-content border-0 shadow-lg rounded-lg">
                        <div class="modal-header bg-white">
                            <h5 class="m-0 font-weight-bold text-admin">Registrar Nuevo Integrante</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body p-4">
                            <div class="row">
                                <div class="col-lg-7">
                                    <form id="formNuevoUsuario" class="text-left" method="POST"
                                        action="${pageContext.request.contextPath}/UsuariosServlet"
                                        enctype="multipart/form-data">
                                        <div class="form-group mb-3">
                                            <label class="font-weight-bold text-dark small">Nombre/s</label>
                                            <input type="text" class="form-control" id="inputNombre" name="nombres"
                                                placeholder="Ingrese nombres..." required>
                                        </div>

                                        <div class="form-row mb-2">
                                            <div class="form-group col-md-6">
                                                <label class="font-weight-bold text-dark small">Apellido Paterno</label>
                                                <input type="text" class="form-control" id="inputApePaterno"
                                                    name="apellido_paterno" required>
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label class="font-weight-bold text-dark small">Apellido Materno</label>
                                                <input type="text" class="form-control" id="inputApeMaterno"
                                                    name="apellido_materno" required>
                                            </div>
                                        </div>

                                        <div class="form-group mb-3">
                                            <label class="font-weight-bold text-dark small">Correo Electrónico</label>
                                            <input type="email" class="form-control" id="inputCorreo"
                                                name="correo_electronico" placeholder="ejemplo@correo.com" required>
                                        </div>

                                        <div class="form-row mb-2">
                                            <div class="form-group col-md-6">
                                                <label class="font-weight-bold text-dark small">Crear contraseña</label>
                                                <input type="password" class="form-control" id="inputPass"
                                                    name="password" required>
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label class="font-weight-bold text-dark small">Confirmar
                                                    contraseña</label>
                                                <input type="password" class="form-control" id="inputPassConf"
                                                    name="confirm_password" required>
                                            </div>
                                        </div>

                                        <div class="form-group mb-3">
                                            <button type="button" class="btn btn-admin btn-sm px-3">Generar
                                                Contraseña</button>
                                        </div>

                                        <div class="form-group mb-0">
                                            <label class="font-weight-bold text-dark small">Asignar Rol</label>
                                            <select id="inputRol" name="rol" class="form-control border-left-success">
                                                <option value="solicitante">Solicitante</option>
                                                <option value="coordinador">Coordinador</option>
                                                <option value="encargado_deposito">Encargado de Depósito</option>
                                                <option value="administrador">Administrador</option>
                                            </select>
                                        </div>
                                    </form>
                                </div>

                                <div
                                    class="col-lg-5 d-flex flex-column align-items-center justify-content-center border-left">
                                    <%-- Zona de foto de perfil para nuevo usuario --%>
                                    <div class="foto-container text-center w-100 mb-3 d-flex flex-column align-items-center">
                                        <div id="fotoPreviewNuevo"
                                            class="mb-2 rounded-circle d-inline-block border overflow-hidden"
                                            style="width:110px;height:110px;background:#f8f9fc;display:flex!important;align-items:center;justify-content:center;">
                                            <i class="fas fa-user-plus fa-3x text-gray-300" id="iconoFotoNuevo"></i>
                                            <img id="imgPreviewNuevo" src="#" alt="preview"
                                                style="display:none;width:110px;height:110px;object-fit:cover;">
                                        </div>
                                        <br>
                                        <%-- El input file va DENTRO del form para que se envíe --%>
                                        <input type="file" id="inputFotoNuevo" name="foto_perfil"
                                            accept="image/*" class="d-none" form="formNuevoUsuario">
                                        <button type="button" class="btn btn-outline-secondary btn-sm px-3"
                                            onclick="document.getElementById('inputFotoNuevo').click()">
                                            <i class="fas fa-camera mr-1"></i> Subir Imagen
                                        </button>
                                        <small class="text-muted mt-1" id="nombreArchivoNuevo">Ningún archivo</small>
                                    </div>

                                    <div class="w-100 text-center mt-3">
                                        <button type="button" class="btn btn-admin btn-block shadow-sm"
                                            id="btnRegistrarUsuario" disabled>
                                            Finalizar Registro
                                        </button>
                                        <button type="button" class="btn btn-light btn-block btn-sm mt-2"
                                            data-dismiss="modal">
                                            Cancelar
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="modalConfirmarRegistro" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content border-bottom-admin">
                        <div class="modal-body text-center p-5">
                            <h4 class="text-dark font-weight-bold">¿Registrar Usuario?</h4>
                            <p class="mb-4 text-left">
                                ¿Estás seguro de que deseas registrar al usuario con los siguientes datos?<br><br>
                                - <strong>Nombre:</strong> <span id="resumenNombre" class="font-weight-bold"></span><br>
                                - <strong>Correo:</strong> <span id="resumenCorreo" class="font-weight-bold"></span><br>
                                - <strong>Rol:</strong> <span id="resumenRol" class="font-weight-bold"></span><br><br>
                                Si le da a registrar se le enviará un correo al nuevo usuario.
                            </p>

                            <button type="button" class="btn btn-secondary rounded-pill px-4 mr-2"
                                data-dismiss="modal">Cancelar</button>
                            <button type="button" id="btnConfirmarAccionFinal" class="btn btn-admin px-4">Sí,
                                registrar</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="modalEditarUsuario" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                    <div class="modal-content border-0 shadow-lg rounded-lg">
                        <div class="modal-header bg-white">
                            <h5 class="m-0 font-weight-bold text-admin">Editar Integrante</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body p-4">
                            <%-- Checkbox de confirmación --%>
                            <div class="alert alert-warning py-2 mb-3" id="editarAlertaConfirm">
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="checkConfirmarEdicion">
                                    <label class="custom-control-label font-weight-bold" for="checkConfirmarEdicion">
                                        Confirmo que deseo editar los datos de este usuario
                                    </label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-7">
                                    <form id="formEditarUsuario" class="text-left" method="POST"
                                        action="${pageContext.request.contextPath}/UsuariosServlet"
                                        enctype="multipart/form-data">
                                        <input type="hidden" name="action" id="editAction" value="editar">
                                        <input type="hidden" name="id_usuario" id="editIdUsuario">

                                        <div class="form-group mb-3">
                                            <label class="font-weight-bold text-dark small">Nombre/s</label>
                                            <input type="text" class="form-control" id="editNombre" name="nombres"
                                                required disabled>
                                        </div>

                                        <div class="form-row mb-2">
                                            <div class="form-group col-md-6">
                                                <label class="font-weight-bold text-dark small">Apellido Paterno</label>
                                                <input type="text" class="form-control" id="editApePaterno"
                                                    name="apellido_paterno" required disabled>
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label class="font-weight-bold text-dark small">Apellido Materno</label>
                                                <input type="text" class="form-control" id="editApeMaterno"
                                                    name="apellido_materno" required disabled>
                                            </div>
                                        </div>

                                        <div class="form-group mb-3">
                                            <label class="font-weight-bold text-dark small">Correo Electrónico</label>
                                            <input type="email" class="form-control" id="editCorreo"
                                                name="correo_electronico" required disabled>
                                        </div>

                                        <div class="form-group mb-0">
                                            <label class="font-weight-bold text-dark small">Asignar Rol</label>
                                            <select id="editRol" name="rol" class="form-control border-left-success" disabled>
                                                <option value="solicitante">Solicitante</option>
                                                <option value="coordinador">Coordinador</option>
                                                <option value="encargado_deposito">Encargado de Depósito</option>
                                                <option value="administrador">Administrador</option>
                                            </select>
                                        </div>
                                    </form>
                                </div>

                                <div
                                    class="col-lg-5 d-flex flex-column align-items-center justify-content-center border-left">
                                    <%-- Zona de foto de perfil en edición --%>
                                    <div class="foto-container text-center w-100 mb-3 d-flex flex-column align-items-center">
                                        <div id="fotoPreviewEditar"
                                            class="mb-2 rounded-circle d-inline-block border overflow-hidden"
                                            style="width:110px;height:110px;background:#f8f9fc;display:flex!important;align-items:center;justify-content:center;">
                                            <i class="fas fa-user-edit fa-3x text-gray-300" id="iconoFotoEditar"></i>
                                            <img id="imgPreviewEditar" src="#" alt="preview"
                                                style="display:none;width:110px;height:110px;object-fit:cover;">
                                        </div>
                                        <input type="file" id="inputFotoEditar" name="foto_perfil_editar"
                                            accept="image/*" class="d-none" form="formEditarUsuario" disabled>
                                        <button type="button" id="btnSubirFotoEditar"
                                            class="btn btn-outline-secondary btn-sm px-3 mt-2" disabled
                                            onclick="document.getElementById('inputFotoEditar').click()">
                                            <i class="fas fa-camera mr-1"></i> Cambiar Foto
                                        </button>
                                        <small class="text-muted mt-1" id="nombreArchivoEditar">Sin cambios</small>
                                    </div>

                                    <div class="w-100 text-center mt-3">
                                        <button type="button" class="btn btn-admin btn-block shadow-sm mb-3"
                                            id="btnGuardarEdicion" disabled>
                                            Guardar Cambios
                                        </button>
                                        <%-- Botón Desactivar: visible solo si el usuario está activo --%>
                                        <button type="button" class="btn btn-danger btn-block shadow-sm d-none"
                                            id="btnDesactivarUsuario" disabled>
                                            <i class="fas fa-user-slash mr-1"></i> Desactivar Usuario
                                        </button>
                                        <%-- Botón Activar: visible solo si el usuario está inactivo --%>
                                        <button type="button" class="btn btn-success btn-block shadow-sm d-none"
                                            id="btnActivarUsuario" disabled>
                                            <i class="fas fa-user-check mr-1"></i> Activar Usuario
                                        </button>
                                        <button type="button" class="btn btn-light btn-block btn-sm mt-2"
                                            data-dismiss="modal">
                                            Cancelar
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Modal de confirmación: Desactivar --%>
            <div class="modal fade" id="modalConfirmarDesactivacion" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content border-bottom-danger">
                        <div class="modal-body text-center p-5">
                            <h4 class="text-dark font-weight-bold">¿Desactivar Usuario?</h4>
                            <p class="mb-4 text-left">
                                ¿Estás seguro de que deseas desactivar a este usuario? Esta acción le impedirá acceder
                                al sistema.
                            </p>
                            <button type="button" class="btn btn-secondary rounded-pill px-4 mr-2"
                                data-dismiss="modal">Cancelar</button>
                            <button type="button" id="btnConfirmarDesactivar" class="btn btn-danger px-4">Sí,
                                desactivar</button>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Modal de confirmación: Activar --%>
            <div class="modal fade" id="modalConfirmarActivacion" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content border-bottom-success">
                        <div class="modal-body text-center p-5">
                            <h4 class="text-dark font-weight-bold">¿Activar Usuario?</h4>
                            <p class="mb-4 text-left">
                                ¿Estás seguro de que deseas reactivar a este usuario? Esto le permitirá volver a acceder
                                al sistema con su rol asignado.
                            </p>
                            <button type="button" class="btn btn-secondary rounded-pill px-4 mr-2"
                                data-dismiss="modal">Cancelar</button>
                            <button type="button" id="btnConfirmarActivar" class="btn btn-success px-4">Sí,
                                activar</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="modalErrorSuperAdmin" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content border-bottom-danger">
                        <div class="modal-body text-center p-5">
                            <h4 class="text-dark font-weight-bold">Acción Denegada</h4>
                            <p class="mb-4 text-left">
                                No tienes permisos para editar o desactivar a un usuario con el rol de Super
                                Administrador.
                            </p>
                            <button type="button" class="btn btn-secondary rounded-pill px-4"
                                data-dismiss="modal">Entendido</button>
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
            <script src="${pageContext.request.contextPath}/js/demo/datatables-GestUsuaraiosAdmin.js"></script>

            <script>
                $(document).ready(function () {
                    // 1. Inicializar Select2 con el tema de Bootstrap 4
                    $('.select2').select2({
                        theme: 'bootstrap4',
                        width: '100%'
                    });

                });
            </script>

            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    // 1. Capturamos los campos del modal de creación
                    const Nombre = document.getElementById("inputNombre");
                    const ApellidoP = document.getElementById("inputApePaterno");
                    const ApellidoM = document.getElementById("inputApeMaterno");
                    const Correo = document.getElementById("inputCorreo");
                    const Pass = document.getElementById("inputPass");
                    const PassConf = document.getElementById("inputPassConf");
                    const inputRol = document.getElementById("inputRol");
                    const btnRegistrarUsuarioBtn = document.getElementById("btnRegistrarUsuario");

                    // Función que evalúa si el botón de "Finalizar Registro" debe habilitarse
                    function evaluarBoton() {
                        // Verificamos que ningún campo esté vacío
                        let camposLlenos = Nombre.value.trim() !== "" &&
                            ApellidoP.value.trim() !== "" &&
                            ApellidoM.value.trim() !== "" &&
                            Correo.value.trim() !== "" &&
                            Pass.value.trim() !== "" &&
                            PassConf.value.trim() !== "" &&
                            inputRol.value !== "";

                        // Verificamos que las contraseñas coincidan
                        let passwordsCoinciden = Pass.value === PassConf.value;

                        // Si todo está lleno y las contraseñas son iguales, habilitamos el botón
                        if (camposLlenos && passwordsCoinciden) {
                            btnRegistrarUsuarioBtn.disabled = false;
                        } else {
                            btnRegistrarUsuarioBtn.disabled = true;
                        }
                    }

                    // 3. Escuchamos el ingreso de datos en tiempo real
                    [Nombre, ApellidoP, ApellidoM, Correo, Pass, PassConf].forEach(el => el.addEventListener("input", evaluarBoton));
                    inputRol.addEventListener("change", evaluarBoton);

                    // Preview de foto en el modal de creación
                    document.getElementById('inputFotoNuevo').addEventListener('change', function() {
                        const file = this.files[0];
                        if (file && file.type.startsWith('image/')) {
                            const reader = new FileReader();
                            reader.onload = function(e) {
                                document.getElementById('imgPreviewNuevo').src = e.target.result;
                                document.getElementById('imgPreviewNuevo').style.display = 'block';
                                document.getElementById('iconoFotoNuevo').style.display = 'none';
                            };
                            reader.readAsDataURL(file);
                            document.getElementById('nombreArchivoNuevo').textContent = file.name;
                        }
                    });

                    // 4. Al hacer clic en "Finalizar Registro", ocultamos el primer modal y abrimos el resumen
                    $('#btnRegistrarUsuario').on('click', function () {
                        let nombreCompleto = Nombre.value.trim() + " " + ApellidoP.value.trim() + " " + ApellidoM.value.trim();

                        // Inyectamos los datos en el segundo modal
                        $('#resumenNombre').text(nombreCompleto);
                        $('#resumenCorreo').text(Correo.value.trim());
                        $('#resumenRol').text(inputRol.value);

                        // Ocultamos uno antes de abrir el otro para evitar superposición de capas oscuras
                        $('#modalCrearUsuario').modal('hide');
                        $('#modalConfirmarRegistro').modal('show');
                    });

                    // 5. Al hacer clic en "Sí, registrar", disparamos el mensaje de éxito reutilizable
                    $('#btnConfirmarAccionFinal').on('click', function () {
                        // Cerramos la ventana de confirmación final
                        $('#modalConfirmarRegistro').modal('hide');


                        // Enviamos el formulario. ESTO es lo que dispara la llamada al Servlet
                        document.getElementById("formNuevoUsuario").submit();

                    });
                });
            </script>

            <script>
                window.onload = function () {
                    // Buscamos si la URL trae el parámetro msg=success
                    const urlParams = new URLSearchParams(window.location.search);
                    const msg = urlParams.get('msg');
                    if (msg) {
                        let text = '';
                        if (msg === 'success') {
                            text = 'El usuario se ha registrado correctamente.';
                        } else if (msg === 'edit_success') {
                            text = 'El usuario se ha actualizado correctamente.';
                        } else if (msg === 'deactivate_success') {
                            text = 'El usuario ha sido desactivado.';
                        } else if (msg === 'activate_success') {
                            text = 'El usuario ha sido reactivado exitosamente.';
                        }

                        if (text !== '') {
                            $('#toastMessage').text(text);
                            $('#actionToast').fadeIn();

                            // La ocultamos a los 5 segundos
                            setTimeout(() => {
                                $('#actionToast').fadeOut();
                            }, 5000);

                            // Limpiamos la URL para que no vuelva a salir si el usuario recarga la página manualmente
                            window.history.replaceState(null, null, window.location.pathname);
                        }
                    }
                };
            </script>


            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    // Script para Modal de Edición
                    const btnEditarList = document.querySelectorAll('.btn-editar');
                    const formEditar = document.getElementById('formEditarUsuario');
                    const editAction = document.getElementById('editAction');
                    const btnGuardarEdicion = document.getElementById('btnGuardarEdicion');
                    const btnDesactivarUsuario = document.getElementById('btnDesactivarUsuario');
                    const btnActivarUsuario = document.getElementById('btnActivarUsuario');
                    const checkConfirmar = document.getElementById('checkConfirmarEdicion');
                    const camposEditar = ['editNombre', 'editApePaterno', 'editApeMaterno', 'editCorreo', 'editRol'];

                    // Variable para guardar el id del usuario en edición (necesario para cargar la foto)
                    let idUsuarioEnEdicion = null;

                    // Función para habilitar/deshabilitar los campos según el checkbox
                    function actualizarEstadoEdicion() {
                        const habilitado = checkConfirmar.checked;
                        camposEditar.forEach(id => {
                            document.getElementById(id).disabled = !habilitado;
                        });
                        btnGuardarEdicion.disabled = !habilitado;
                        // Solo habilitamos el botón que esté visible
                        if (!btnDesactivarUsuario.classList.contains('d-none')) {
                            btnDesactivarUsuario.disabled = !habilitado;
                        }
                        if (!btnActivarUsuario.classList.contains('d-none')) {
                            btnActivarUsuario.disabled = !habilitado;
                        }
                        document.getElementById('inputFotoEditar').disabled = !habilitado;
                        document.getElementById('btnSubirFotoEditar').disabled = !habilitado;
                    }

                    checkConfirmar.addEventListener('change', actualizarEstadoEdicion);

                    // Al abrir el modal: resetear el checkbox y bloquear campos
                    $('#modalEditarUsuario').on('show.bs.modal', function () {
                        checkConfirmar.checked = false;
                        actualizarEstadoEdicion();
                        // Limpiar foto previa (se cargará en shown.bs.modal para evitar conflictos de timing)
                        document.getElementById('imgPreviewEditar').style.display = 'none';
                        document.getElementById('imgPreviewEditar').src = '#';
                        document.getElementById('iconoFotoEditar').style.display = 'inline';
                        document.getElementById('inputFotoEditar').value = '';
                        document.getElementById('nombreArchivoEditar').textContent = 'Sin cambios';
                    });

                    // Una vez el modal está visible (animación terminada), cargamos la foto actual del usuario
                    $('#modalEditarUsuario').on('shown.bs.modal', function () {
                        if (idUsuarioEnEdicion) {
                            const imgEditar = document.getElementById('imgPreviewEditar');
                            const iconoEditar = document.getElementById('iconoFotoEditar');
                            const urlFoto = '${pageContext.request.contextPath}/UsuariosServlet?action=foto&id=' + idUsuarioEnEdicion;
                            imgEditar.onerror = function() {
                                imgEditar.style.display = 'none';
                                iconoEditar.style.display = 'inline';
                            };
                            imgEditar.onload = function() {
                                imgEditar.style.display = 'block';
                                iconoEditar.style.display = 'none';
                            };
                            imgEditar.src = urlFoto;
                        }
                    });

                    btnEditarList.forEach(btn => {
                        btn.addEventListener('click', function () {
                            const rol = this.getAttribute('data-rol');
                            if (rol === 'superadmin') {
                                $('#modalErrorSuperAdmin').modal('show');
                                return;
                            }

                            // Guardar id para cargarlo en shown.bs.modal
                            idUsuarioEnEdicion = this.getAttribute('data-id');

                            // Llenar el formulario con los datos del botón
                            document.getElementById('editIdUsuario').value = idUsuarioEnEdicion;
                            document.getElementById('editNombre').value = this.getAttribute('data-nombres');
                            document.getElementById('editApePaterno').value = this.getAttribute('data-apellidop');
                            document.getElementById('editApeMaterno').value = this.getAttribute('data-apellidom');
                            document.getElementById('editCorreo').value = this.getAttribute('data-correo');
                            document.getElementById('editRol').value = this.getAttribute('data-rol');

                            // Mostrar el botón correcto según el estado del usuario
                            const activo = parseInt(this.getAttribute('data-activo'));
                            if (activo === 1) {
                                btnDesactivarUsuario.classList.remove('d-none');
                                btnActivarUsuario.classList.add('d-none');
                            } else {
                                btnDesactivarUsuario.classList.add('d-none');
                                btnActivarUsuario.classList.remove('d-none');
                            }

                            $('#modalEditarUsuario').modal('show');
                        });
                    });

                    // Preview de foto al seleccionar archivo en edición
                    document.getElementById('inputFotoEditar').addEventListener('change', function() {
                        const file = this.files[0];
                        if (file && file.type.startsWith('image/')) {
                            const reader = new FileReader();
                            reader.onload = function(e) {
                                document.getElementById('imgPreviewEditar').src = e.target.result;
                                document.getElementById('imgPreviewEditar').style.display = 'block';
                                document.getElementById('iconoFotoEditar').style.display = 'none';
                                document.getElementById('imgPreviewEditar').onerror = null;
                            };
                            reader.readAsDataURL(file);
                            document.getElementById('nombreArchivoEditar').textContent = file.name;
                        }
                    });

                    btnGuardarEdicion.addEventListener('click', function () {
                        editAction.value = "editar";
                        // Los campos disabled no se envían en el POST → los habilitamos justo antes del submit
                        camposEditar.forEach(id => {
                            document.getElementById(id).disabled = false;
                        });
                        document.getElementById('inputFotoEditar').disabled = false;
                        formEditar.submit();
                    });

                    // Botón Desactivar
                    btnDesactivarUsuario.addEventListener('click', function () {
                        $('#modalEditarUsuario').modal('hide');
                        $('#modalConfirmarDesactivacion').modal('show');
                    });

                    // Botón Activar
                    btnActivarUsuario.addEventListener('click', function () {
                        $('#modalEditarUsuario').modal('hide');
                        $('#modalConfirmarActivacion').modal('show');
                    });

                    document.getElementById('btnConfirmarDesactivar').addEventListener('click', function () {
                        editAction.value = "desactivar";
                        formEditar.submit();
                    });

                    document.getElementById('btnConfirmarActivar').addEventListener('click', function () {
                        editAction.value = "activar";
                        // Habilitamos campos antes del submit para que id_usuario se envíe
                        document.getElementById('editIdUsuario').disabled = false;
                        formEditar.submit();
                    });
                });
            </script>


            <!-- Script para copiar correo sin alerta flotante -->
            <script>
                document.addEventListener("DOMContentLoaded", function () {

                    function copiarTexto(texto) {
                        if (navigator.clipboard && window.isSecureContext) {
                            return navigator.clipboard.writeText(texto);
                        }

                        const inputTemporal = document.createElement("textarea");
                        inputTemporal.value = texto;
                        inputTemporal.style.position = "fixed";
                        inputTemporal.style.left = "-9999px";
                        inputTemporal.style.top = "0";

                        document.body.appendChild(inputTemporal);
                        inputTemporal.focus();
                        inputTemporal.select();

                        return new Promise(function (resolve, reject) {
                            try {
                                const copiado = document.execCommand("copy");

                                if (copiado) {
                                    resolve();
                                } else {
                                    reject();
                                }
                            } catch (error) {
                                reject(error);
                            } finally {
                                document.body.removeChild(inputTemporal);
                            }
                        });
                    }

                    document.addEventListener("click", function (event) {
                        const boton = event.target.closest(".btn-copiar-correo");

                        if (!boton) return;

                        const correo = boton.getAttribute("data-correo");

                        if (!correo || correo.trim() === "") return;

                        const icono = boton.querySelector("i");
                        const iconoOriginal = icono.className;
                        const tituloOriginal = boton.getAttribute("title") || "Copiar correo";

                        copiarTexto(correo.trim())
                            .then(function () {
                                icono.className = "fas fa-check text-success";
                                boton.setAttribute("title", "Correo copiado");

                                setTimeout(function () {
                                    icono.className = iconoOriginal;
                                    boton.setAttribute("title", tituloOriginal);
                                }, 1200);
                            })
                            .catch(function () {
                                icono.className = "fas fa-times text-danger";
                                boton.setAttribute("title", "No se pudo copiar");

                                setTimeout(function () {
                                    icono.className = iconoOriginal;
                                    boton.setAttribute("title", tituloOriginal);
                                }, 1200);
                            });
                    });
                });
            </script>
        </body>

        </html>