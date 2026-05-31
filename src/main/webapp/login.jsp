<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    // Si ya hay sesion activa, redirigir al Inicio del rol correspondiente
    if (session != null && session.getAttribute("usuario") != null) {
        response.sendRedirect(request.getContextPath() + "/LoginServlet");
        return;
    }

    // Lectura del parametro de error que envia el LoginServlet
    String errorParam = request.getParameter("error");
    String mensajeError = null;
    if ("credenciales".equals(errorParam)) {
        mensajeError = "Correo o contraseña incorrectos.";
    } else if ("campos".equals(errorParam)) {
        mensajeError = "Debes ingresar tu correo y tu contraseña.";
    }
%>
    <!doctype html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - ClanVault Dashboard</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap"
            rel="stylesheet">

        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style_login.css">
    </head>

    <body>

        <div id="tsparticles"></div>

        <div class="video-background">
            <video autoplay muted loop playsinline>
                <source src="#" type="video/mp4">

            </video>
        </div>
        <div class="video-overlay"></div>

        <div class="login-container">
            <div class="login-card">

                <div class="login-header">
                    <div class="logo">
                        <img src="<%= request.getContextPath() %>/img/quintaola_logo.png" alt="Logo Quinta Ola"
                            class="navbar-logo">
                    </div>
                    <h1>Bienvenido</h1>
                    <p class="slogan">El arsenal de tu inventario, bajo control.</p>
                </div>

                <div id="errorAlert" style="display: <%= mensajeError != null ? "block" : "none" %>;">
                    <div class="alert alert-glass" role="alert" id="errorMessageDiv">
                        <i class="fas fa-exclamation-triangle mr-2"></i>
                        <span id="errorMessageText"><%= mensajeError != null ? mensajeError : "" %></span>
                    </div>
                </div>

                <form method="POST" action="<%= request.getContextPath() %>/LoginServlet" novalidate id="loginForm">

                    <div class="form-floating">
                        <i class="fas fa-user input-icon"></i>
                        <input type="text" class="form-control" id="email" name="email"
                            placeholder="Usuario, email o ID" required autocomplete="username">
                        <label for="email">Usuario, email o ID de Miembro</label>
                    </div>

                    <small class="d-block mb-3 text-white-50" style="font-size: 0.85rem; line-height: 1.4;">
                        <i class="fas fa-info-circle mr-1"></i>
                        Los miembros pueden usar su ID asignado (ej: CLAN-001) para iniciar sesión.
                    </small>

                    <div class="form-floating">
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" class="form-control" id="password" name="password"
                            placeholder="Contraseña" required autocomplete="current-password">
                        <label for="password">Contraseña</label>
                    </div>

                    <div class="text-right mb-3">
                        <a href="<%= request.getContextPath() %>/forgot-password.jsp"
                            style="color: #fff; text-decoration: underline; font-size: 0.9rem;">
                            <i class="fas fa-key mr-1"></i>¿Olvidaste tu contraseña?
                        </a>
                    </div>

                    <button type="submit" class="btn btn-login-submit" id="btnLogin">
                        <i class="fas fa-sign-in-alt mr-2"></i>
                        Ingresar al Dashboard
                    </button>
                </form>

                <div class="text-center mt-3">
                    <a href="<%= request.getContextPath() %>/index.jsp" class="btn-home-link">
                        <i class="fas fa-home mr-2"></i> Volver al Inicio
                    </a>
                </div>

                <div class="text-center mt-3">
                    <a href="<%= request.getContextPath() %>/register.jsp" class="btn-home-link-yellow">
                        <i class="fas fa-user-plus mr-2"></i> Crear cuenta administrativa
                    </a>
                </div>

            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/tsparticles-slim@2.12.0/tsparticles.slim.bundle.min.js"></script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {

                // --- 1. Lógica de validación del formulario (Frontend) ---
                const form = document.querySelector('form');
                const emailInput = document.getElementById('email');
                const passwordInput = document.getElementById('password');

                form.addEventListener('submit', function (e) {
                    let isValid = true;
                    emailInput.classList.remove('is-invalid');
                    passwordInput.classList.remove('is-invalid');

                    const errorAlert = document.getElementById('errorAlert');
                    if (errorAlert) errorAlert.style.display = 'none';

                    if (!emailInput.value.trim()) {
                        emailInput.classList.add('is-invalid');
                        isValid = false;
                    }

                    if (!passwordInput.value.trim()) {
                        passwordInput.classList.add('is-invalid');
                        isValid = false;
                    }

                    if (!isValid) {
                        e.preventDefault();
                        if (errorAlert) {
                            const errorMessageText = document.getElementById('errorMessageText');
                            if (errorMessageText) errorMessageText.textContent = 'Por favor, complete todos los campos.';
                            errorAlert.style.display = 'block';
                        }
                    }
                });

                // Control de los labels flotantes
                const inputs = document.querySelectorAll('.form-control');
                inputs.forEach(input => {
                    input.addEventListener('focus', function () {
                        this.parentElement.classList.add('focused');
                    });
                    input.addEventListener('blur', function () {
                        if (!this.value) this.parentElement.classList.remove('focused');
                    });
                    if (input.value) input.parentElement.classList.add('focused');
                });

                // --- 2. Lógica de Partículas configurada con colores ClanVault ---
                tsParticles.load("tsparticles", {
                    particles: {
                        number: { value: 60, density: { enable: true, value_area: 800 } },
                        color: { value: ["#7203c1", "#ff2a9e", "#23b1be"] },
                        shape: { type: "circle" },
                        opacity: { value: 0.6, random: true },
                        size: { value: 4, random: { enable: true, minimumValue: 1 } },
                        links: {
                            color: "#ffffff",
                            distance: 150,
                            enable: true,
                            opacity: 0.2,
                            width: 1,
                        },
                        move: {
                            enable: true,
                            speed: 1.5,
                            direction: "none",
                            out_mode: "out",
                        },
                    },
                    interactivity: {
                        events: {
                            onhover: { enable: true, mode: "grab" },
                            onclick: { enable: true, mode: "push" },
                        },
                        modes: {
                            grab: { distance: 140, links: { opacity: 0.5 } },
                            push: { particles_nb: 4 },
                        },
                    },
                    retina_detect: true,
                });
            });
        </script>
    </body>

    </html>