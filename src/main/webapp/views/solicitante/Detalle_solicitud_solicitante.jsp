<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Detalle de Solicitud - Solicitante</title>

    <!-- Fuentes e iconos -->
    <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,300,400,600,700,800,900" rel="stylesheet">

    <!-- Tema SB Admin 2 -->
    <link href="${pageContext.request.contextPath}/css/sb-admin-2.min.css" rel="stylesheet">

    <style>
        .timeline-steps { display:flex; justify-content:space-between; align-items:center;
            position:relative; margin-bottom:30px; padding:0 10%; }
        .timeline-steps::before { content:''; position:absolute; top:50%; left:10%; right:10%;
            height:4px; background-color:#e0e0e0; z-index:1; transform:translateY(-50%); }
        .timeline-step { position:relative; z-index:2; text-align:center; background:#f8f9fc; padding:0 10px; }
        .timeline-step .circle { width:30px; height:30px; border-radius:50%; background-color:#e0e0e0;
            color:#fff; display:flex; align-items:center; justify-content:center;
            margin:0 auto 5px auto; font-weight:bold; border:3px solid #fff; }
        .timeline-step.active .circle { background-color:#f6cf0b; }
        .timeline-step.completed .circle { background-color:#1cc88a; }
        .timeline-step.rejected .circle { background-color:#e74a3b; }
        .timeline-step .label { font-size:.85rem; color:#555; font-weight:600; }
    </style>
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
        <li class="nav-item">
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
                <div class="d-none d-sm-inline-block mr-auto ml-md-3 my-2 my-md-0 mw-100">
                    <h1 class="h3 mb-0 text-gray-800 font-weight-bold">DETALLE DE SOLICITUD</h1>
                </div>
                <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                    <i class="fa fa-bars"></i>
                </button>
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
                <div class="card-body">

                    <c:set var="est" value="${solicitud.estado}" />

                    <%-- ============ LÍNEA DE TIEMPO ============ --%>
                    <div class="timeline-steps mt-2 mb-5">

                        <div class="timeline-step completed">
                            <div class="circle"><i class="fas fa-check"></i></div>
                            <div class="label mt-2">Creada</div>
                        </div>

                        <div class="timeline-step ${est == 'pendiente' ? 'active' : 'completed'}">
                            <div class="circle"><i class="fas fa-clock"></i></div>
                            <div class="label mt-2">En Revisión</div>
                        </div>

                        <c:choose>
                            <c:when test="${est == 'rechazada'}">
                                <div class="timeline-step rejected">
                                    <div class="circle"><i class="fas fa-times"></i></div>
                                    <div class="label mt-2">Rechazada</div>
                                </div>
                            </c:when>
                            <c:when test="${est == 'aprobada' or est == 'entregada'}">
                                <div class="timeline-step completed">
                                    <div class="circle"><i class="fas fa-check"></i></div>
                                    <div class="label mt-2">Aprobada</div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="timeline-step">
                                    <div class="circle"><i class="fas fa-thumbs-up"></i></div>
                                    <div class="label mt-2">Aprobada/Rechazada</div>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <c:choose>
                            <c:when test="${est == 'entregada'}">
                                <div class="timeline-step completed">
                                    <div class="circle"><i class="fas fa-check"></i></div>
                                    <div class="label mt-2">Entregada</div>
                                </div>
                            </c:when>
                            <c:when test="${est == 'aprobada'}">
                                <div class="timeline-step active">
                                    <div class="circle"><i class="fas fa-truck"></i></div>
                                    <div class="label mt-2">Entregada</div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="timeline-step">
                                    <div class="circle"><i class="fas fa-truck"></i></div>
                                    <div class="label mt-2">Entregada</div>
                                </div>
                            </c:otherwise>
                        </c:choose>

                    </div>

                    <div class="row">
                        <div class="col-lg-8">

                            <div class="mb-4 text-dark">
                                <p class="mb-1"><strong>ID de solicitud:</strong> #${solicitud.idSolicitudes}</p>
                                <p class="mb-1"><strong>Fecha y hora de la solicitud:</strong> ${solicitud.fechaSolicitud}</p>
                                <p class="mb-1"><strong>Estado actual:</strong>
                                    <c:choose>
                                        <c:when test="${est == 'pendiente'}">
                                            <span class="badge badge-warning px-2 py-1">En Revisión</span>
                                        </c:when>
                                        <c:when test="${est == 'aprobada'}">
                                            <span class="badge badge-success px-2 py-1">Aprobada</span>
                                        </c:when>
                                        <c:when test="${est == 'rechazada'}">
                                            <span class="badge badge-danger px-2 py-1">Rechazada</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-info px-2 py-1">Entregada</span>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>

                            <div class="mb-4">
                                <h6 class="font-weight-bold text-dark">Propósito:</h6>
                                <div class="p-3 bg-light border rounded text-dark">
                                    ${solicitud.proposito}
                                </div>
                            </div>

                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-admin">Materiales solicitados</h6>
                                </div>
                                <div class="table-responsive mb-0 shadow-sm">
                                    <table class="table table-hover table-striped text-gray-800 text-center mb-0" width="100%">
                                        <thead class="bg-light text-dark">
                                            <tr>
                                                <th>Código</th>
                                                <th>Producto</th>
                                                <th>Categoría</th>
                                                <th>Cantidad solicitada</th>
                                                <th>Stock actual</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="d" items="${detalles}">
                                                <tr>
                                                    <td class="align-middle">${d.sku}</td>
                                                    <td class="align-middle text-left">${d.nombre}</td>
                                                    <td class="align-middle">${d.categoria}</td>
                                                    <td class="align-middle">${d.cantidad}</td>
                                                    <td class="align-middle">${d.stockActual}</td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty detalles}">
                                                <tr><td colspan="5" class="text-muted py-4">Sin materiales registrados.</td></tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <div class="mt-4">
                                <a href="${pageContext.request.contextPath}/InicioSolicitanteServlet" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left mr-1"></i> Volver a Inicio
                                </a>
                            </div>
                        </div>

                        <%-- ============ MOTIVO DE RECHAZO (solo si fue rechazada) ============ --%>
                        <div class="col-lg-4">
                            <c:if test="${est == 'rechazada'}">
                                <div class="card shadow-sm mb-4 border-left-danger">
                                    <div class="card-header py-3 bg-white">
                                        <h6 class="m-0 font-weight-bold text-danger">Motivo de Rechazo</h6>
                                    </div>
                                    <div class="card-body">
                                        <p class="text-dark mb-0">
                                            <c:choose>
                                                <c:when test="${not empty solicitud.comentarioRechazo}">
                                                    ${solicitud.comentarioRechazo}
                                                </c:when>
                                                <c:otherwise>
                                                    No se registró un comentario de rechazo.
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                </div>
                            </c:if>
                        </div>

                    </div>

                </div>
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

</body>
</html>
