<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Nueva Solicitud - Solicitante</title>

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
            <div class="sidebar-brand-text mx-3">CLAN INVETORY</div>
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
                    <h1 class="h3 mb-0 text-gray-800 font-weight-bold">NUEVA SOLICITUD</h1>
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
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
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

                <%-- Aviso de producto agregado a la cajita --%>
                <c:if test="${param.msg == 'agregado'}">
                    <div class="alert alert-success alert-dismissible fade show shadow mb-4" role="alert">
                        <i class="fas fa-check-circle mr-2"></i> Producto agregado a la cajita.
                        <button type="button" class="close" data-dismiss="alert"><span>&times;</span></button>
                    </div>
                </c:if>
                <c:if test="${param.msg == 'repetido'}">
                    <div class="alert alert-warning alert-dismissible fade show shadow mb-4" role="alert">
                        <i class="fas fa-exclamation-circle mr-2"></i> Ese producto ya está en la cajita.
                        <button type="button" class="close" data-dismiss="alert"><span>&times;</span></button>
                    </div>
                </c:if>

                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-admin">Lista de productos disponibles</h6>
                    </div>
                    <div class="card-body">

                        <%-- Filtro de categoría + botón Ver cajita --%>
                        <div class="row mb-4 px-3 align-items-end">
                            <div class="col-md-4">
                                <label class="font-weight-bold text-dark mb-2">Filtrar por Categoría:</label>
                                <select id="filtroCategoria" class="form-control">
                                    <option value="todas">Todas las categorías</option>
                                    <c:forEach var="cat" items="${listaCategorias}">
                                        <option value="${cat.idCategorias}">${cat.nombre}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-8 text-right">
                                <a href="${pageContext.request.contextPath}/ProcesoSolicitudSolicitanteServlet"
                                   class="btn btn-admin shadow-sm position-relative mt-4">
                                    <i class="fas fa-box-open mr-2"></i> Ver cajita
                                    <span class="badge badge-pill badge-danger" id="contador-cajita">${cajitaCount}</span>
                                </a>
                            </div>
                        </div>

                        <div class="px-3 mb-4 border-bottom pb-2">
                            <h4 id="titulo-categoria" class="font-weight-bold text-admin text-left m-0">Todas las categorías</h4>
                        </div>

                        <%-- ============ LISTA DE PRODUCTOS ============ --%>
                        <div class="container-fluid px-3">
                            <div class="row" id="lista-productos">
                                <c:forEach var="p" items="${listaProductos}">
                                    <div class="col-md-3 mb-4 producto-item" data-categoria="${p.idCategorias}">
                                        <div class="card card-solicitante h-100 text-center border-0">
                                            <%-- La imagen se asigna por JavaScript segun el id del producto --%>
                                            <img data-pid="${p.idProductos}"
                                                 class="card-img-top p-4" alt="${p.nombre}"
                                                 style="height: 200px; object-fit: contain;"
                                                 onerror="imgFallback(this)">
                                            <div class="card-body d-flex flex-column pt-0">
                                                <h5 class="card-title font-weight-bold text-dark mb-1">${p.nombre}</h5>
                                                <p class="card-text text-muted small mb-3">${p.nombreCategoria}</p>
                                                <div class="mb-3 mt-auto">
                                                    <c:choose>
                                                        <c:when test="${p.estadoStock == 'critico'}">
                                                            <span class="badge badge-danger px-3 py-2" style="font-size:.85rem;">
                                                                <i class="fas fa-circle mr-1" style="font-size:.6rem;"></i>Disponible: ${p.stockActual}</span>
                                                        </c:when>
                                                        <c:when test="${p.estadoStock == 'bajo'}">
                                                            <span class="badge badge-warning text-dark px-3 py-2" style="font-size:.85rem;">
                                                                <i class="fas fa-circle mr-1" style="font-size:.6rem;"></i>Disponible: ${p.stockActual}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge badge-success px-3 py-2" style="font-size:.85rem;">
                                                                <i class="fas fa-circle mr-1" style="font-size:.6rem;"></i>Disponible: ${p.stockActual}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <c:choose>
                                                    <c:when test="${p.stockActual > 0}">
                                                        <a href="${pageContext.request.contextPath}/NuevaSolicitudSolicitanteServlet?action=agregar&id=${p.idProductos}"
                                                           class="btn btn-admin btn-block">Agregar a la cajita</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button class="btn btn-secondary btn-block" disabled>Sin stock</button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>

                                <c:if test="${empty listaProductos}">
                                    <div class="col-12 text-center text-muted py-5">
                                        <i class="fas fa-box-open fa-2x mb-2"></i><br>No hay productos disponibles.
                                    </div>
                                </c:if>
                            </div>
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

<script>
    // ====================================================================
    //  URLs de las imágenes de cada producto (clave = id del producto).
    //  Si agregas productos nuevos, añade aquí su id y su enlace.
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
        img.src = "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='200' height='200'%3E%3Crect width='200' height='200' fill='%23f1f1f1'/%3E%3Ctext x='50%25' y='50%25' font-size='16' fill='%23999' text-anchor='middle' dy='.3em'%3ESin imagen%3C/text%3E%3C/svg%3E";
    }

    // Asignar a cada producto su imagen segun el id
    document.querySelectorAll('img[data-pid]').forEach(function (img) {
        var url = imagenesProductos[img.getAttribute('data-pid')];
        if (url) { img.src = url; } else { imgFallback(img); }
    });

    // Filtrar las tarjetas de producto por categoría
    document.getElementById('filtroCategoria').addEventListener('change', function () {
        var categoria = this.value;
        document.getElementById('titulo-categoria').innerText =
            this.options[this.selectedIndex].text;
        document.querySelectorAll('.producto-item').forEach(function (box) {
            if (categoria === 'todas' || box.getAttribute('data-categoria') === categoria) {
                box.style.display = 'block';
            } else {
                box.style.display = 'none';
            }
        });
    });
</script>

</body>
</html>
