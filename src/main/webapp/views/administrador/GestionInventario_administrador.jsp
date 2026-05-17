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

    <title>Gestion de inventario-Administrador</title>

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

            <!-- Divider -->
            <!--<hr class="sidebar-divider">-->

            <!-- Nav Item - GESTION DE USUARIOS -->
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/UsuariosServlet">
                    <i class="fas fa-fw fa-users mr"></i>
                    <span>GESTION DE USUARIOS</span></a>
            </li>

            <!-- Divider -->
            <!--<hr class="sidebar-divider">-->

            <!-- Nav Item - GESTION DE INVENTARIO -->
            <li class="nav-item active">
                <a class="nav-link" href="GestionInventario_administrador.jsp">
                    <i class="fas fa-fw fa-box mr"></i>
                    <span>GESTION DE INVENTARIO</span></a>
            </li>

            <!-- Divider -->
            <!--<hr class="sidebar-divider">-->

            <!-- Nav Item - REPORTES -->
            <li class="nav-item">
                <a class="nav-link" href="Reportes_administrador.jsp">
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
                        <h1 class="h3 mb-0 text-gray-800 font-weight-bold">GESTION DE INVENTARIO</h1>
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

                                <div class="row mb-3">
                                    <div class="col-md-3">
                                        <label class="small font-weight-bold text-dark">Por Categoría:</label>
                                        <select id="filtroCategoria" class="form-control select2" style="width: 100%;">
                                            <option value="">Todas las categotrías</option>
                                            <option value="Merchandising">Merchandising intitucional</option>
                                            <option value="Materiales">Materiales lúdicos y juegos educativos</option>
                                            <option value="Kits">Kits de ayuda humanitaria</option>
                                            <option value="Utileria">Utilería para talleres</option>
                                        </select>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <label class="small font-weight-bold text-dark">Por Estado:</label>
                                        <select id="filtroEstado" class="form-control select2" style="width: 100%;">
                                            <option value="">Todos los estados</option>
                                            <option value="Pendiente">Óptimo</option>
                                            <option value="Aprobada">Bajo</option>
                                            <option value="Rechazada">Crítico</option>
                                        </select>
                                    </div>
                                    
                                    <div class="col-md-1 mt-4">
                                        <button id="filtrar" type="button" class="btn btn-admin">
                                            <i class="fas fa-filter fa-sm mr-1"></i>Filtrar
                                        </button>
                                    </div>

                                </div>

                                <div class="table-responsive">

                                    <table id="dataTable" class="table table-hover table-striped text-gray-800" >
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
                                            <tr>
                                                <td>SKU: L-0101</td>
                                                <td>Polo talla M</td>
                                                <td>Merchandising intitucional</td>
                                                <td>45</td>
                                                <td class="text-center align-middle"><i class="fas fa-circle text-success"></i></td>
                                                <td>
                                                    <button class="btn btn-sm shadow-sm"><i class="fa-solid fa-eye"></i></button>
                                                    <button class="btn btn-sm shadow-sm"><i class="fa-solid fa-pencil"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>SKU: L-0202</td>
                                                <td>Juegos de bloques</td>
                                                <td>Materiales lúdicos y juegos educativos</td>
                                                <td>2</td>
                                                <td class="text-center align-middle"><i class="fas fa-circle text-danger"></i></td>
                                                <td>
                                                    <button class="btn btn-sm shadow-sm"><i class="fa-solid fa-eye"></i></button>
                                                    <button class="btn btn-sm shadow-sm"><i class="fa-solid fa-pencil"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>SKU: L-0200</td>
                                                <td>Kit de higiene</td>
                                                <td>Kits de ayuda humanitaria</td>
                                                <td>9</td>
                                                <td class="text-center align-middle"><i class="fas fa-circle text-advertencia"></i></td>
                                                <td>
                                                    <button class="btn btn-sm shadow-sm"><i class="fa-solid fa-eye"></i></button>
                                                    <button class="btn btn-sm shadow-sm"><i class="fa-solid fa-pencil"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>SKU: L-0303</td>
                                                <td>Tijera y cartulina</td>
                                                <td>Utilería para talleres</td>
                                                <td>0</td>
                                                <td class="text-center align-middle"><i class="fas fa-circle text-advertencia"></i></td>
                                                <td>
                                                    <button class="btn btn-sm shadow-sm"><i class="fa-solid fa-eye"></i></button>
                                                    <button class="btn btn-sm shadow-sm"><i class="fa-solid fa-pencil"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>SKU: L-0202</td>
                                                <td>Legos</td>
                                                <td>Materiales lúdicos y juegos educativos</td>
                                                <td>2</td>
                                                <td class="text-center align-middle"><i class="fas fa-circle text-danger"></i></td>
                                                <td>
                                                    <button class="btn btn-sm shadow-sm"><i class="fa-solid fa-eye"></i></button>
                                                    <button class="btn btn-sm shadow-sm"><i class="fa-solid fa-pencil"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>SKU: L-0101</td>
                                                <td>Polo talla M</td>
                                                <td>Merchandising intitucional</td>
                                                <td>45</td>
                                                <td class="text-center align-middle"><i class="fas fa-circle text-success"></i></td>
                                                <td>
                                                    <button class="btn btn-sm shadow-sm"><i class="fa-solid fa-eye"></i></button>
                                                    <button class="btn btn-sm shadow-sm"><i class="fa-solid fa-pencil"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>SKU: L-0101</td>
                                                <td>Polo talla M</td>
                                                <td>Merchandising intitucional</td>
                                                <td>45</td>
                                                <td class="text-center align-middle"><i class="fas fa-circle text-success"></i></td>
                                                <td>
                                                    <button class="btn btn-sm shadow-sm"><i class="fa-solid fa-eye"></i></button>
                                                    <button class="btn btn-sm shadow-sm"><i class="fa-solid fa-pencil"></i></button>
                                                </td>
                                            </tr>
                                            
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
                            <form id="formNuevoProducto" class="text-left">
                                <div class="form-row mb-3">
                                    <div class="form-group col-md-4">
                                        <label class="font-weight-bold text-dark small">Código</label>
                                        <input type="text" class="form-control" id="inputCodigo" placeholder="Ej: MAT-001" required>
                                    </div>
                                    <div class="form-group col-md-8">
                                        <label class="font-weight-bold text-dark small">Producto</label>
                                        <input type="text" class="form-control" id="inputProducto" placeholder="Nombre del producto..." required>
                                    </div>
                                </div>

                                <div class="form-row mb-3">
                                    <div class="form-group col-md-4">
                                        <label class="font-weight-bold text-dark small">Stock Inicial</label>
                                        <input type="number" class="form-control" id="inputStock" min="0" placeholder="0" required>
                                    </div>
                                    <div class="form-group col-md-8">
                                        <label class="font-weight-bold text-dark small">Categoría</label>
                                        <select id="inputCategoria" class="form-control border-left-success" required>
                                            <option value="">Seleccione una categoría...</option>
                                            <option value="Merchandising institucional">Merchandising institucional</option>
                                            <option value="Materiales lúdicos y juegos educativos">Materiales lúdicos y juegos educativos</option>
                                            <option value="Kits de ayuda humanitaria">Kits de ayuda humanitaria</option>
                                            <option value="Utilería para talleres">Utilería para talleres</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group mb-0">
                                    <label class="font-weight-bold text-dark small">Detalles del producto</label>
                                    <textarea class="form-control" id="inputDetalles" rows="4" placeholder="Escriba la descripción, marca, color o especificaciones importantes del producto..." required></textarea>
                                </div>
                            </form>
                        </div>

                        <div class="col-lg-5 d-flex flex-column align-items-center justify-content-between border-left">
                            <div class="foto-container text-center w-100 mb-3">
                                <div class="foto-placeholder mb-2 p-4 bg-light rounded-circle d-inline-block border">
                                    <i class="fas fa-box-open fa-3x text-gray-300"></i>
                                </div>
                                <br>
                                <button type="button" class="btn btn-outline-secondary btn-sm px-3">Subir Imagen</button>
                            </div>

                            <div class="w-100 text-center mt-auto">
                                <button type="button" class="btn btn-admin btn-block shadow-sm" id="btnRegistrarProducto" disabled>
                                    Registrar Producto
                                </button>
                                <button type="button" class="btn btn-light btn-block btn-sm mt-2" data-dismiss="modal">
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
            <div class="modal-content border-bottom-admin shadow-lg rounded-lg">
                <div class="modal-body text-center p-5">
                    <h4 class="text-dark font-weight-bold">¿Registrar Producto?</h4>
                    <p class="mb-4 text-left">
                        Verifique que los datos del nuevo producto sean correctos antes de ingresarlos al sistema:<br><br>
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
        // 1. Inicializar Select2 con el tema de Bootstrap 4
        $('.select2').select2({
            theme: 'bootstrap4', 
            width: '100%'
        });

        // 2. Conectar los filtros a tu tabla
        // Filtro de Categoría (Busca en la columna 2)
        $('#filtroCategoria').on('change', function() {
            dataTable.column(2).search(this.value).draw();
        });

        // Filtro de Estado (Busca en la columna 4)
        $('#filtroEstado').on('change', function() {
            dataTable.column(4).search(this.value).draw();
        });
    });
    </script>

    <script>
    document.addEventListener("DOMContentLoaded", function() {
        // 1. Capturamos los inputs del producto
        const Codigo = document.getElementById("inputCodigo");
        const Producto = document.getElementById("inputProducto");
        const Stock = document.getElementById("inputStock");
        const Categoria = document.getElementById("inputCategoria");
        const Detalles = document.getElementById("inputDetalles");
        const btnRegistrar = document.getElementById("btnRegistrarProducto");
        
        // 2. Función que evalúa si habilitar el botón de envío
        function evaluarBoton() {
            if (Codigo.value.trim() !== "" && 
                Producto.value.trim() !== "" &&
                Stock.value.trim() !== "" &&
                Categoria.value.trim() !== "" &&
                Detalles.value.trim() !== "" ) {
                
                btnRegistrar.disabled = false;
            } else {
                btnRegistrar.disabled = true;
            }
        }
        
        // 3. Escuchamos los cambios en los inputs en tiempo real
        Codigo.addEventListener("input", evaluarBoton);
        Producto.addEventListener("input", evaluarBoton);
        Stock.addEventListener("input", evaluarBoton);
        Categoria.addEventListener("change", evaluarBoton); // select usa 'change'
        Detalles.addEventListener("input", evaluarBoton);

        // 4. Lógica al presionar "Registrar Producto" (Llenar y abrir confirmación)
        $('#btnRegistrarProducto').on('click', function() {
            // Pasamos los valores a los spans del resumen
            $('#resumenCodigo').text(Codigo.value.trim());
            $('#resumenProducto').text(Producto.value.trim());
            $('#resumenStock').text(Stock.value.trim());
            $('#resumenCategoria').text(Categoria.value.trim());
            
            // Ocultamos el modal principal y abrimos la confirmación
            $('#modalCrearProducto').modal('hide');
            $('#modalConfirmarRegistro').modal('show');
        });

        // 5. Al hacer clic en "Sí, registrar", disparamos el mensaje de éxito reutilizable
        $('#btnConfirmarAccionFinal').on('click', function() {
            // Cerramos la ventana de confirmación final
            $('#modalConfirmarRegistro').modal('hide');

            // Limpiamos los datos del formulario de manera segura
            document.getElementById("formNuevoProducto").reset();
            evaluarBoton(); // Vuelve a deshabilitar el botón

            // Mostramos la alerta superior con animación suave (fadeIn)
            $('#toastMessage').text('El producto se ha añadido correctamente.');
            $('#actionToast').fadeIn();

            // Ocultamos la alerta suavemente (fadeOut) después de 5 segundos
            setTimeout(() => {
                $('#actionToast').fadeOut();
            }, 5000);
        });
    });
    </script>

</body>

</html>
