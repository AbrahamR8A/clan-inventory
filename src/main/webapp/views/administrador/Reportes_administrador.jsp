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

    <title>Reportes-Administrador</title>

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

            <!-- Nav Item - GESTION DE USUARIOS -->
            <li class="nav-item">
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

            <!-- Divider -->
            <!--<hr class="sidebar-divider">-->

            <!-- Nav Item - REPORTES -->
            <li class="nav-item active">
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
                        <h1 class="h3 mb-0 text-gray-800 font-weight-bold">REPORTES</h1>
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

                    <div id="actionToast" class="alert alert-success alert-dismissible fade show shadow mb-4" role="alert" style="display: none;">
                        <i class="fas fa-check-circle mr-2"></i>
                        <strong>¡Éxito!</strong> <span id="toastMessage">La solicitud ha sido procesada.</span>
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <!--<div class="d-sm-flex align-items-center justify-content-between mb-4">-->

                    <!-- Page Heading -->

                    <!-- Main Content -->
                    <div class="card-body">
                        
                        <div class="row">

                            <div class="col-lg-8">

                                <div class="card shadow mb-4">
                                    <!-- DataTales Example -->
                                    <div class="card shadow mb-4">
                                        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                            <h6 class="m-0 font-weight-bold text-admin">Tabla de Consumo del Mes</h6>
                                            
                                            <a href="#" class="btn btn-admin shadow-sm">
                                                <i class="fa-solid fa-file-excel"></i> Exportar a Excel
                                            </a>

                                        </div>
                                        <div class="card-body">

                                                <div class="row mb-3">
                                                    <div class="col-md-3">
                                                        <label class="small font-weight-bold text-dark">Selecciona un mes:</label>
                                                        <select id="filtroCategoria" class="form-control select2" style="width: 100%;">
                                                            <option value="">mes</option>
                                                            <option value="m1">Enero</option>
                                                            <option value="m2">Febrero</option>
                                                            <option value="m3">Marzo</option>
                                                            <option value="m4">Abril</option>
                                                            <option value="m5">Mayo</option>
                                                            <option value="m6">Junio</option>
                                                            <option value="m7">Julio</option>
                                                            <option value="m8">Agosto</option>
                                                            <option value="m9">Septiembre</option>
                                                            <option value="m10">Octubre</option>
                                                            <option value="m11">Noviembre</option>
                                                            <option value="m12">Diciembre</option>
                                                        </select>
                                                    </div>
                                                    
                                                    <div class="col-md-3">
                                                        <label class="small font-weight-bold text-dark">Selecciona un año:</label>
                                                        <select id="filtroEstado" class="form-control select2" style="width: 100%;">
                                                            <option value="">año</option>
                                                            <option value="a2026">2026</option>
                                                            <option value="a2025">2024</option>
                                                            <option value="a2024">2023</option>
                                                        </select>
                                                    </div>
                                                    
                                                    <div class="col-md-auto mt-4">
                                                        <button id="filtrar" type="button" class="btn btn-admin">
                                                            <i class="fas fa-filter fa-sm mr-1"></i>Filtrar
                                                        </button>
                                                    </div>
                                                </div>

                                                <div class="row mb-4">

                                                    <div class="col-xl-3 col-md-6 mb-4">
                                                        <div class="card border-left-coord shadow h-100 py-2">
                                                            <div class="card-body">
                                                                <div class="row no-gutters align-items-center">
                                                                    <div class="col mr-2">
                                                                        <div class="text-xs font-weight-bold text-coord text-uppercase mb-1">
                                                                            SOLICITUDES TOTALES</div>
                                                                        <div class="h5 mb-0 font-weight-bold text-gray-800">18</div>
                                                                    </div>
                                                                    <div class="col-auto">
                                                                        <i class="fas fa-user-check fa-2x text-gray-300"></i>
                                                                    </div>
                                                                    
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-xl-3 col-md-6 mb-4">
                                                        <div class="card border-left-success shadow h-100 py-2">
                                                            <div class="card-body">
                                                                <div class="row no-gutters align-items-center">
                                                                    <div class="col mr-2">
                                                                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                                            SOLICITUDES APROBADAS</div>
                                                                        <div class="h5 mb-0 font-weight-bold text-gray-800">25</div>
                                                                    </div>
                                                                    <div class="col-auto">
                                                                        <i class="fas fa-check fa-2x text-gray-300"></i>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-xl-3 col-md-6 mb-4">
                                                        <div class="card border-left-primary shadow h-100 py-2">
                                                            <div class="card-body">
                                                                <div class="row no-gutters align-items-center">
                                                                    <div class="col mr-2">
                                                                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                                            SOLICITUDES ENTREGADAS</div>
                                                                        <div class="h5 mb-0 font-weight-bold text-gray-800">8</div>
                                                                    </div>
                                                                    <div class="col-auto">
                                                                        <i class="fa-solid fa-truck fa-2x text-gray-300"></i>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-xl-3 col-md-6 mb-4">
                                                        <div class="card border-left-danger shadow h-100 py-2">
                                                            <div class="card-body">
                                                                <div class="row no-gutters align-items-center">
                                                                    <div class="col mr-2">
                                                                        <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">
                                                                            SOLICITUDES RECHAZADAS</div>
                                                                        <div class="h5 mb-0 font-weight-bold text-gray-800">320</div>
                                                                    </div>
                                                                    <div class="col-auto">
                                                                        <i class="fa-solid fa-x fa-2x text-gray-300"></i>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>

                                            <div class="table-responsive">

                                                <table id="dataTable" class="table table-hover table-striped text-gray-800" >
                                                    <thead class="bg-light">
                                                        <tr>
                                                            <th class="centered font-weight-bold">Código</th>
                                                            <th class="centered font-weight-bold">Producto</th>
                                                            <th class="centered font-weight-bold">Categoría</th>
                                                            <th class="centered font-weight-bold">Stock<br>inicial</th>
                                                            <th class="centered font-weight-bold">Entrada del<br>mes</th>
                                                            <th class="centered font-weight-bold">Salida del<br>mes</th>
                                                            <th class="centered font-weight-bold">Stock<br>final</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>SKU: L-0101</td>
                                                            <td>Polo talla M</td>
                                                            <td>Merchandising intitucional</td>
                                                            <td>45</td>
                                                            <td>4</td>
                                                            <td>10</td>
                                                            <td>39</td>
                                                        </tr>
                                                        <tr>
                                                            <td>SKU: L-0202</td>
                                                            <td>Juegos de bloques</td>
                                                            <td>Materiales lúdicos y juegos educativos</td>
                                                            <td>2</td>
                                                            <td>5</td>
                                                            <td>7</td>
                                                            <td>0</td>
                                                        </tr>
                                                        <tr>
                                                            <td>SKU: L-0200</td>
                                                            <td>Kit de higiene</td>
                                                            <td>Kits de ayuda humanitaria</td>
                                                            <td>9</td>
                                                            <td>10</td>
                                                            <td>5</td>
                                                            <td>14</td>
                                                        </tr>
                                                        <tr>
                                                            <td>SKU: L-0303</td>
                                                            <td>Tijera y cartulina</td>
                                                            <td>Utilería para talleres</td>
                                                            <td>0</td>
                                                            <td>10</td>
                                                            <td>5</td>
                                                            <td>5</td>
                                                        </tr>
                                                        <tr>
                                                            <td>SKU: L-0202</td>
                                                            <td>Legos</td>
                                                            <td>Materiales lúdicos y juegos educativos</td>
                                                            <td>2</td>
                                                            <td>6</td>
                                                            <td>4</td>
                                                            <td>4</td>
                                                        </tr>
                                                        <tr>
                                                            <td>SKU: L-0101</td>
                                                            <td>Polo talla L</td>
                                                            <td>Merchandising intitucional</td>
                                                            <td>45</td>
                                                            <td>20</td>
                                                            <td>40</td>
                                                            <td>25</td>
                                                        </tr>
                                                        <tr>
                                                            <td>SKU: L-0101</td>
                                                            <td>Polo talla S</td>
                                                            <td>Merchandising intitucional</td>
                                                            <td>45</td>
                                                            <td>10</td>
                                                            <td>30</td>
                                                            <td>25</td>
                                                        </tr>
                                                        <tr>
                                                            <td>SKU: L-0101</td>
                                                            <td>Polo talla S</td>
                                                            <td>Merchandising intitucional</td>
                                                            <td>45</td>
                                                            <td>10</td>
                                                            <td>30</td>
                                                            <td>25</td>
                                                        </tr>
                                                        
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                               
                            </div>
                            
                            <div class="col-lg-4">
                                
                                <!-- Bar Chart -->
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-admin">Productos más solicitados</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="chart-bar">
                                            <canvas id="myBarChart"></canvas>
                                        </div>
                                        <hr>
                                        Styling for the bar chart can be found in the
                                        <code>/js/demo/chart-bar-demo.js</code> file.
                                    </div>
                                </div>

                                <!-- Card Header - Dropdown -->
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-admin">Consumo por categoría</h6>
                                    </div>
                                    <!-- Card Body -->
                                    <div class="card-body">
                                        <div class="chart-pie pt-4">
                                            <canvas id="myPieChart"></canvas>
                                        </div>
                                        <hr>
                                        Styling for the donut chart can be found in the
                                        <code>/js/demo/chart-pie-demo.js</code> file.
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

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/login.jsp">Logout</a>
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
    <script src="${pageContext.request.contextPath}/js/demo/datatables-ReportesAdmin.js"></script>

        <!-- Page level plugins -->
    <script src="${pageContext.request.contextPath}/vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="${pageContext.request.contextPath}/js/demo/chart-area-demo.js"></script>
    <script src="${pageContext.request.contextPath}/js/demo/chart-pie-demo.js"></script>
    <script src="${pageContext.request.contextPath}/js/demo/chart-bar-demo.js"></script>
