<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Nueva Cuenta - ClanVault Dashboard</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style_register.css">
</head>
<body>

<div id="tsparticles"></div>

<div class="video-background">
    <video autoplay muted loop playsinline>
        <source src="#" type="video/mp4">
    </video>
</div>
<div class="video-overlay"></div>

<div class="login-container register-container">
    <div class="login-card register-card">

        <div class="login-header">
            <div class="logo">
                <img src="<%= request.getContextPath() %>/img/quintaola_logo.png" alt="Logo Quinta Ola" class="navbar-logo">
            </div>
            <h1>Crear Cuenta Administrativa</h1>
            <p class="slogan">Gestiona tu propio equipo y recursos de manera eficiente.</p>
        </div>

        <div id="errorAlert" style="display: none;">
            <div class="alert alert-glass" role="alert" id="errorMessageDiv">
                <i class="fas fa-exclamation-triangle mr-2"></i>
                <span id="errorMessageText"></span>
            </div>
        </div>

        <form method="POST" action="#" novalidate id="registerForm">
            
            <div class="row-inputs">
                <div class="form-floating">
                    <i class="fas fa-user input-icon"></i>
                    <input type="text" class="form-control" id="nombres" name="nombres" placeholder="Nombres" required>
                    <label for="nombres">Nombres</label>
                </div>
                
                <div class="form-floating">
                    <i class="fas fa-user-tag input-icon"></i>
                    <input type="text" class="form-control" id="apellidos" name="apellidos" placeholder="Apellidos" required>
                    <label for="apellidos">Apellidos</label>
                </div>
            </div>

            <div class="form-floating">
                <i class="fas fa-envelope input-icon"></i>
                <input type="email" class="form-control" id="email" name="email" placeholder="Correo Electrónico" required autocomplete="username">
                <label for="email">Correo Electrónico</label>
            </div>
            
            <div class="row-inputs">
                <div class="form-floating">
                    <i class="fas fa-lock input-icon"></i>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Contraseña" required autocomplete="new-password">
                    <label for="password">Contraseña</label>
                </div>
                
                <div class="form-floating">
                    <i class="fas fa-lock input-icon"></i>
                    <input type="password" class="form-control" id="repeatPassword" name="repeatPassword" placeholder="Repetir Contraseña" required autocomplete="new-password">
                    <label for="repeatPassword">Repetir Contraseña</label>
                </div>
            </div>

            <button type="submit" class="btn btn-login-submit mt-2" id="btnRegister">
                <i class="fas fa-user-plus mr-2"></i>
                Registrar Cuenta
            </button>
        </form>

        <div class="text-center mt-4">
            <a href="<%= request.getContextPath() %>/login.jsp" class="btn-home-link">
                <i class="fas fa-sign-in-alt mr-2"></i> ¿Ya tienes una cuenta? ¡Inicia sesión!
            </a>
        </div>
        
        <div class="text-center mt-3">
            <a href="<%= request.getContextPath() %>/forgot-password.jsp" style="color: #fff; text-decoration: underline; font-size: 0.9rem;">
                ¿Olvidaste tu contraseña?
            </a>
        </div>


    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/tsparticles-slim@2.12.0/tsparticles.slim.bundle.min.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        
        // Control de los labels flotantes
        const inputs = document.querySelectorAll('.form-control');
        inputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.classList.add('focused');
            });
            input.addEventListener('blur', function() {
                if (!this.value) this.parentElement.classList.remove('focused');
            });
            if (input.value) input.parentElement.classList.add('focused');
        });

        // Lógica de validación del formulario
        const form = document.getElementById('registerForm');
        form.addEventListener('submit', function(e) {
            let isValid = true;
            let errorMessage = "Por favor, complete todos los campos requeridos.";
            
            inputs.forEach(input => input.classList.remove('is-invalid'));
            const errorAlert = document.getElementById('errorAlert');
            if (errorAlert) errorAlert.style.display = 'none';

            inputs.forEach(input => {
                if (!input.value.trim()) {
                    input.classList.add('is-invalid');
                    isValid = false;
                }
            });

            const pwd = document.getElementById('password').value;
            const rpwd = document.getElementById('repeatPassword').value;

            if (pwd && rpwd && pwd !== rpwd) {
                document.getElementById('password').classList.add('is-invalid');
                document.getElementById('repeatPassword').classList.add('is-invalid');
                isValid = false;
                errorMessage = "Las contraseñas no coinciden.";
            }

            if (!isValid) {
                e.preventDefault();
                if (errorAlert) {
                    document.getElementById('errorMessageText').textContent = errorMessage;
                    errorAlert.style.display = 'block';
                }
            }
        });

        // Lógica de Partículas (manteniendo color amarillo predominante)
        tsParticles.load("tsparticles", {
            particles: {
                number: { value: 60, density: { enable: true, value_area: 800 } },
                color: { value: ["#f6cf0b", "#7203c1", "#ff2a9e"] }, 
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
