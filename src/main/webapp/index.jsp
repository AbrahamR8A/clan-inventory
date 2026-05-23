<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Dashboard de Inventario de Clan - Control preciso de recursos, miembros y armería en tiempo real.">
    <title>Clan Inventory | Dashboard Administrativo</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

    <link href="<%= request.getContextPath() %>/css/style_index.css" rel="stylesheet">
</head>

<body>

    <nav class="navbar navbar-expand-lg navbar-custom fixed-top">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="#">
                <img src="<%= request.getContextPath() %>/img/quintaola_logo.png" alt="Logo Quinta Ola" class="navbar-logo">
            </a>
            
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon">
                    <i class="fas fa-bars text-admin"></i>
                </span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item"><a class="nav-link nav-link-custom active" href="#inicio">Inicio</a></li>
                    <li class="nav-item"><a class="nav-link nav-link-custom" href="#caracteristicas">Características</a></li>
                    <li class="nav-item"><a class="nav-link nav-link-custom" href="#beneficios">Ventajas</a></li>
                </ul>
                <a href="<%= request.getContextPath() %>/login.jsp" class="btn btn-login-custom mt-3 mt-lg-0">Ingresar</a>
            </div>
        </div>
    </nav>

    <section class="hero-section" id="inicio">
        <div class="container text-center hero-content" data-aos="fade-up">
            <span class="hero-badge">SISTEMA ADMINISTRATIVO IWEB</span>
            <h1 class="hero-title">Gestión Inteligente para tu Clan</h1>
            <p class="hero-subtitle">
                Toma el control absoluto de tus recursos. Monitorea el inventario, gestiona los roles de tus miembros y mantén un registro de todos los ítems y entregas en un solo dashboard.
            </p>
            <div class="hero-buttons">
                <a href="#caracteristicas" class="btn btn-hero-primary">Explorar Módulos</a>
            </div>
        </div>
    </section>

    <section class="features-section" id="caracteristicas">
        <div class="container">
            <div class="section-header" data-aos="fade-up">
                <span class="section-badge">FUNCIONALIDADES</span>
                <h2 class="section-title">Todo el Arsenal en una Sola Plataforma</h2>
                <p class="section-description">
                    Sistema integrado para maximizar la organización y eficiencia del clan en cada evento.
                </p>
            </div>

            <div class="row">
                <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="feature-card-modern">
                        <div class="feature-icon-modern"><i class="fas fa-boxes"></i></div>
                        <h3 class="feature-title">Inventario en Tiempo Real</h3>
                        <p class="feature-description">Monitorea tus recursos y materiales al instante. Recibe alertas de escasez y mantén un control preciso del banco del clan.</p>
                        <ul class="list-unstyled mt-3">
                            <li><i class="fas fa-check text-success mr-2"></i>Alertas de stock bajo</li>
                            <li><i class="fas fa-check text-success mr-2"></i>Trazabilidad de ítems</li>
                        </ul>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="feature-card-modern">
                        <div class="feature-icon-modern"><i class="fas fa-handshake"></i></div>
                        <h3 class="feature-title">Préstamos y Entregas</h3>
                        <p class="feature-description">Administra el equipo asignado a cada miembro. Automatiza el registro de quién tiene qué y evita la pérdida de ítems valiosos.</p>
                        <ul class="list-unstyled mt-3">
                            <li><i class="fas fa-check text-success mr-2"></i>Registro de responsables</li>
                            <li><i class="fas fa-check text-success mr-2"></i>Historial de transacciones</li>
                        </ul>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="300">
                    <div class="feature-card-modern">
                        <div class="feature-icon-modern"><i class="fas fa-users"></i></div>
                        <h3 class="feature-title">Gestión de Roles</h3>
                        <p class="feature-description">Asigna roles (Administrador, Coordinador, Solicitante) con permisos diferenciados. Controla quién puede retirar o depositar en el banco.</p>
                        <ul class="list-unstyled mt-3">
                            <li><i class="fas fa-check text-success mr-2"></i>Control de accesos</li>
                            <li><i class="fas fa-check text-success mr-2"></i>Perfiles jerárquicos</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="benefits-section" id="beneficios">
        <div class="container">
            <div class="section-header" data-aos="fade-up">
                <span class="section-badge">VENTAJAS</span>
                <h2 class="section-title">¿Por Qué Usar Este Dashboard?</h2>
            </div>
            <div class="row align-items-center">
                <div class="col-lg-6" data-aos="fade-right">
                    <div class="benefit-item">
                        <div class="benefit-icon"><i class="fas fa-bolt"></i></div>
                        <div class="benefit-content">
                            <h4>Interfaz Rápida y Responsiva</h4>
                            <p>Accede desde tu PC, laptop o móvil. Un diseño adaptado gracias a Bootstrap 4 para consultas rápidas durante eventos o raids.</p>
                        </div>
                    </div>
                    <div class="benefit-item">
                        <div class="benefit-icon"><i class="fas fa-shield-alt"></i></div>
                        <div class="benefit-content">
                            <h4>Auditoría Completa</h4>
                            <p>Registro detallado de acciones para mantener la transparencia en el manejo de recursos comunes del grupo.</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6" data-aos="fade-left">
                    <div class="benefit-item">
                        <div class="benefit-icon"><i class="fas fa-chart-pie"></i></div>
                        <div class="benefit-content">
                            <h4>Estadísticas Claras</h4>
                            <p>Visualiza en tiempo real los aportes de los miembros y la distribución del inventario mediante tablas y reportes precisos.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="cta-section" id="contacto">
        <div class="container">
            <div class="cta-content" data-aos="zoom-in">
                <h2 class="cta-title">¿Listo para Organizar tu Clan?</h2>
                <div class="hero-buttons mt-4">
                    <a href="<%= request.getContextPath() %>/login.jsp" class="btn btn-hero-primary">
                        <i class="fas fa-sign-in-alt mr-2"></i>Ir al Dashboard
                    </a>
                </div>
            </div>
        </div>
    </section>

    <footer class="footer-modern">
        <div class="container text-center">
            <div class="footer-brand mb-3">
                <img src="<%= request.getContextPath() %>/img/quintaola_logo.png" alt="Logo Quinta Ola" class="navbar-logo">
            </div>
            <p class="footer-description mx-auto" style="max-width: 500px;">
                Proyecto desarrollado para la gestión eficiente de inventarios y roles de usuarios mediante un entorno web estructurado.
            </p>
            <div class="footer-bottom">
                <p class="mb-0">&copy; 2026 Dashboard Administrativo de Clan. Todos los derechos reservados.</p>
            </div>
        </div>
    </footer>

    <div id="tsparticles"></div>

    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script src="https://cdn.jsdelivr.net/npm/tsparticles@2.12.0/tsparticles.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    
    <script src="<%= request.getContextPath() %>/js/demo/scrip_index.js"></script>

    </body>
</html>