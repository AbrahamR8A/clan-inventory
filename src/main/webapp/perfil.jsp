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

    <title>Perfil - Clan Inventory</title>

    <!-- Custom fonts for this template-->
    <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="${pageContext.request.contextPath}/css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"
        integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <%-- Usuario que se mostrará en el perfil.
             Si el servlet envía usuarioPerfil, se usa ese objeto; si no, se toma el usuario de sesión. --%>
        <c:set var="usuarioActualPerfil" value="${empty usuarioPerfil ? sessionScope.usuario : usuarioPerfil}" />
        <c:set var="rolActual" value="${usuarioActualPerfil.rol}" />

        <%-- ====================== SIDEBAR SEGÚN ROL ====================== --%>
        <c:choose>
            <c:when test="${rolActual == 'administrador'}">
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
            </c:when>

            <c:when test="${rolActual == 'coordinador'}">
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
            </c:when>

            <c:when test="${rolActual == 'encargado_deposito'}">
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
            </c:when>

            <c:when test="${rolActual == 'solicitante'}">
                <!-- Sidebar -->
                <ul class="navbar-nav bg-gradient-admin sidebar sidebar-dark accordion" id="accordionSidebar">

                    <!-- Sidebar - Brand -->
                    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/InicioSolicitanteServlet">
                        <div class="sidebar-brand-icon rotate-n-15">
                            <i class="fas fa-laugh-wink"></i>
                        </div>
                        <div class="sidebar-brand-text mx-3">CLAN INVETORY</div>
                    </a>

                    <!-- Divider -->
                    <hr class="sidebar-divider my-0">

                    <!-- Nav Item - INICIO -->
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/InicioSolicitanteServlet">
                            <i class="fas fa-fw fa-tachometer-alt"></i>
                            <span>INICIO</span></a>
                    </li>

                    <!-- Nav Item - NUEVA SOLICITUD -->
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/NuevaSolicitudSolicitanteServlet">
                            <i class="fas fa-fw fa-box"></i>
                            <span>NUEVA SOLICITUD</span></a>
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
                <!-- Sidebar genérica para superadmin u otros roles sin vista específica cargada -->
                <ul class="navbar-nav bg-gradient-admin sidebar sidebar-dark accordion" id="accordionSidebar">

                    <!-- Sidebar - Brand -->
                    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/PerfilServlet">
                        <div class="sidebar-brand-icon rotate-n-15">
                            <i class="fas fa-laugh-wink"></i>
                        </div>
                        <div class="sidebar-brand-text mx-3">CLAN INVENTORY</div>
                    </a>

                    <!-- Divider -->
                    <hr class="sidebar-divider my-0">

                    <!-- Nav Item - PERFIL -->
                    <li class="nav-item active">
                        <a class="nav-link" href="${pageContext.request.contextPath}/PerfilServlet">
                            <i class="fas fa-fw fa-user"></i>
                            <span>PERFIL</span></a>
                    </li>

                    <!-- Divider -->
                    <hr class="sidebar-divider d-none d-md-block">

                    <!-- Sidebar Toggler (Sidebar) -->
                    <div class="text-center d-none d-md-inline">
                        <button class="rounded-circle border-0" id="sidebarToggle"></button>
                    </div>

                </ul>
                <!-- End of Sidebar -->
            </c:otherwise>
        </c:choose>
        <%-- ====================== FIN SIDEBAR SEGÚN ROL ====================== --%>

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Section Title (Topbar) -->
                    <div class="d-none d-sm-inline-block mr-auto ml-md-3 my-2 my-md-0 mw-100">
                        <h1 class="h3 mb-0 text-gray-800 font-weight-bold">PERFIL</h1>
                    </div>

                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">

                        <%-- Todos los usuarios tienen notificaciones, excepto superadmin según el requerimiento general. --%>
                        <c:if test="${rolActual != 'superadmin'}">
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
                        </c:if>

                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">
                                    ${sessionScope.nombreCompleto}
                                </span>
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

                    <%-- Mensajes enviados por el servlet luego de intentar actualizar la contraseña. --%>
                    <c:if test="${not empty mensajeExito}">
                        <div class="alert alert-success alert-dismissible fade show shadow mb-4" role="alert">
                            <i class="fas fa-check-circle mr-2"></i>
                            <strong>¡Éxito!</strong> ${mensajeExito}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>

                    <c:if test="${not empty mensajeError}">
                        <div class="alert alert-danger alert-dismissible fade show shadow mb-4" role="alert">
                            <i class="fas fa-exclamation-circle mr-2"></i>
                            <strong>Error:</strong> ${mensajeError}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>

                    <c:if test="${param.msg == 'password_ok'}">
                        <div class="alert alert-success alert-dismissible fade show shadow mb-4" role="alert">
                            <i class="fas fa-check-circle mr-2"></i>
                            <strong>¡Éxito!</strong> La contraseña se actualizó correctamente.
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>

                    <c:if test="${param.msg == 'password_error'}">
                        <div class="alert alert-danger alert-dismissible fade show shadow mb-4" role="alert">
                            <i class="fas fa-exclamation-circle mr-2"></i>
                            <strong>Error:</strong> No se pudo actualizar la contraseña. Verifique los datos ingresados.
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>

                    <c:choose>
                        <c:when test="${not empty usuarioActualPerfil}">

                            <!-- Page Heading -->
                            <div class="d-sm-flex align-items-center justify-content-between mb-4">
                                <h1 class="h3 mb-0 text-gray-800">Mi perfil</h1>
                            </div>

                            <div class="row">

                                <%-- ====================== INFORMACIÓN DEL USUARIO ====================== --%>
                                <div class="col-lg-8">
                                    <div class="card shadow mb-4">
                                        <div class="card-header py-3">
                                            <h6 class="m-0 font-weight-bold text-admin">
                                                <i class="fas fa-id-card mr-2"></i>Información personal
                                            </h6>
                                        </div>
                                        <div class="card-body">
                                            <div class="row mb-3">
                                                <div class="col-md-6 mb-3">
                                                    <label class="small font-weight-bold text-gray-800">Código de usuario</label>
                                                    <input type="text" class="form-control" value="${usuarioActualPerfil.idUsuarios}" readonly>
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="small font-weight-bold text-gray-800">Estado</label>
                                                    <div class="form-control bg-light">
                                                        <c:choose>
                                                            <c:when test="${usuarioActualPerfil.activo == 1}">
                                                                <span class="badge badge-success px-2 py-1">Activo</span>
                                                            </c:when>
                                                            <c:when test="${usuarioActualPerfil.activo == 2}">
                                                                <span class="badge badge-warning px-2 py-1">Pendiente</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge badge-secondary px-2 py-1">Inactivo</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row mb-3">
                                                <div class="col-md-4 mb-3">
                                                    <label class="small font-weight-bold text-gray-800">Nombres</label>
                                                    <input type="text" class="form-control" value="${usuarioActualPerfil.nombres}" readonly>
                                                </div>
                                                <div class="col-md-4 mb-3">
                                                    <label class="small font-weight-bold text-gray-800">Apellido paterno</label>
                                                    <input type="text" class="form-control" value="${usuarioActualPerfil.apellidoPaterno}" readonly>
                                                </div>
                                                <div class="col-md-4 mb-3">
                                                    <label class="small font-weight-bold text-gray-800">Apellido materno</label>
                                                    <input type="text" class="form-control" value="${usuarioActualPerfil.apellidoMaterno}" readonly>
                                                </div>
                                            </div>

                                            <div class="row mb-3">
                                                <div class="col-md-6 mb-3">
                                                    <label class="small font-weight-bold text-gray-800">Correo electrónico</label>
                                                    <input type="email" class="form-control" value="${usuarioActualPerfil.correo}" readonly>
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="small font-weight-bold text-gray-800">Rol</label>
                                                    <div class="form-control bg-light">
                                                        <c:choose>
                                                            <c:when test="${usuarioActualPerfil.rol == 'administrador'}">
                                                                <span class="badge badge-admin px-2 py-1">Administrador</span>
                                                            </c:when>
                                                            <c:when test="${usuarioActualPerfil.rol == 'superadmin'}">
                                                                <span class="badge badge-superadmin px-2 py-1">Super Administrador</span>
                                                            </c:when>
                                                            <c:when test="${usuarioActualPerfil.rol == 'coordinador'}">
                                                                <span class="badge badge-coord px-2 py-1">Coordinador</span>
                                                            </c:when>
                                                            <c:when test="${usuarioActualPerfil.rol == 'encargado_deposito'}">
                                                                <span class="badge badge-depo px-2 py-1">Encargado de depósito</span>
                                                            </c:when>
                                                            <c:when test="${usuarioActualPerfil.rol == 'solicitante'}">
                                                                <span class="badge badge-soli px-2 py-1">Solicitante</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge badge-secondary px-2 py-1">${usuarioActualPerfil.rol}</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-6 mb-3">
                                                    <label class="small font-weight-bold text-gray-800">Fecha de Registro</label>
                                                    <input type="text" class="form-control" value="Miembro registrado" readonly>
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="small font-weight-bold text-gray-800">ID del creador</label>
                                                    <input type="text" class="form-control" value="${empty usuarioActualPerfil.idCreador ? 'No registrado' : usuarioActualPerfil.idCreador}" readonly>
                                                </div>
                                            </div>

                                            <div class="alert alert-info mb-0" role="alert">
                                                <i class="fas fa-info-circle mr-2"></i>
                                                Esta información es solo de lectura. Desde esta vista únicamente puedes cambiar tu contraseña.
                                            </div>

                                            <hr class="my-4">

                                            <h6 class="font-weight-bold text-admin mb-3">
                                                <i class="fas fa-lock mr-2"></i>Cambiar contraseña
                                            </h6>
                                            <form id="formCambioContrasenia" action="${pageContext.request.contextPath}/PerfilServlet" method="POST">
                                                <input type="hidden" name="action" value="cambiarContrasenia">
                                                <input type="hidden" name="idUsuario" value="${usuarioActualPerfil.idUsuarios}">

                                                <div class="row">
                                                    <div class="col-md-4 form-group">
                                                        <label class="small font-weight-bold text-gray-800" for="contraseniaActual">Contraseña actual</label>
                                                        <input type="password" class="form-control" id="contraseniaActual" name="contraseniaActual" required>
                                                    </div>

                                                    <div class="col-md-4 form-group">
                                                        <label class="small font-weight-bold text-gray-800" for="nuevaContrasenia">Nueva contraseña</label>
                                                        <input type="password" class="form-control" id="nuevaContrasenia" name="nuevaContrasenia" required>
                                                    </div>

                                                    <div class="col-md-4 form-group">
                                                        <label class="small font-weight-bold text-gray-800" for="confirmarContrasenia">Confirmar nueva contraseña</label>
                                                        <input type="password" class="form-control" id="confirmarContrasenia" name="confirmarContrasenia" required>
                                                    </div>
                                                </div>

                                                <div id="mensajeValidacionPassword" class="alert alert-danger py-2 d-none" role="alert"></div>

                                                <div class="text-right mt-2">
                                                    <button type="button" id="btnAbrirConfirmacionPassword" class="btn btn-admin shadow-sm">
                                                        <i class="fas fa-key mr-1"></i> Actualizar contraseña
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <%-- ====================== FIN INFORMACIÓN DEL USUARIO ====================== --%>

                                <%-- ====================== PERFIL Y SEGURIDAD ====================== --%>
                                <div class="col-lg-4">
                                    <div class="card shadow mb-4">
                                        <div class="card-header py-3">
                                            <h6 class="m-0 font-weight-bold text-admin">
                                                <i class="fas fa-user-circle mr-2"></i>Foto de perfil
                                            </h6>
                                        </div>
                                        <div class="card-body text-center">
                                            <img class="rounded-circle img-fluid mb-3"
                                                 src="${pageContext.request.contextPath}/PerfilServlet?action=foto&id=${usuarioActualPerfil.idUsuarios}"
                                                 onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/img/undraw_profile.svg';"
                                                 alt="Foto de perfil">
                                            <h5 class="font-weight-bold text-gray-800 mb-1">
                                                ${usuarioActualPerfil.nombres} ${usuarioActualPerfil.apellidoPaterno}
                                            </h5>
                                            <p class="text-muted mb-0">${usuarioActualPerfil.correo}</p>
                                        </div>
                                    </div>

                                <%-- ====================== FIN PERFIL Y SEGURIDAD ====================== --%>

                            </div>
                        </c:when>

                        <c:otherwise>
                            <div class="alert alert-warning shadow" role="alert">
                                <i class="fas fa-exclamation-triangle mr-2"></i>
                                No se encontró información del usuario en sesión. Vuelva a iniciar sesión.
                            </div>
                        </c:otherwise>
                    </c:choose>

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

    <!-- Modal de confirmación para cambio de contraseña -->
    <div class="modal fade" id="modalConfirmarPassword" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Confirmar cambio de contraseña</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    ¿Está seguro de que desea actualizar su contraseña? Después del cambio deberá usar la nueva contraseña en el próximo inicio de sesión.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    <button type="button" id="btnConfirmarCambioPassword" class="btn btn-admin">Confirmar</button>
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

    <!-- Script para validar el formulario de cambio de contraseña -->
    <script>
        $(document).ready(function() {
            $('#btnAbrirConfirmacionPassword').on('click', function() {
                var contraseniaActual = $('#contraseniaActual').val().trim();
                var nuevaContrasenia = $('#nuevaContrasenia').val().trim();
                var confirmarContrasenia = $('#confirmarContrasenia').val().trim();
                var mensaje = $('#mensajeValidacionPassword');

                mensaje.addClass('d-none').text('');

                if (contraseniaActual === '' || nuevaContrasenia === '' || confirmarContrasenia === '') {
                    mensaje.removeClass('d-none').text('Debe completar todos los campos para cambiar la contraseña.');
                    return;
                }

                if (nuevaContrasenia !== confirmarContrasenia) {
                    mensaje.removeClass('d-none').text('La nueva contraseña y la confirmación no coinciden.');
                    return;
                }

                if (contraseniaActual === nuevaContrasenia) {
                    mensaje.removeClass('d-none').text('La nueva contraseña debe ser diferente a la contraseña actual.');
                    return;
                }

                $('#modalConfirmarPassword').modal('show');
            });

            $('#btnConfirmarCambioPassword').on('click', function() {
                $('#formCambioContrasenia').submit();
            });
        });
    </script>

</body>

</html>
