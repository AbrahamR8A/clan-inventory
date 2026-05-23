<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recuperar Contraseña - ClanVault Dashboard</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style_forgot_password.css">
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
    <div class="login-card forgot-card">

        <div class="login-header forgot-header">
            <div class="logo">
                <img src="<%= request.getContextPath() %>/img/quintaola_logo.png" alt="Logo Quinta Ola" class="navbar-logo">
            </div>
            <h1>¿Olvidaste tu contraseña?</h1>
        </div>

        <p class="forgot-info-text">
            Lo entendemos, a veces surgen imprevistos. Introduce tu correo electrónico a continuación y te enviaremos un enlace para restablecer tu contraseña.
        </p>

        <div id="errorAlert" style="display: none;">
            <div class="alert alert-glass" role="alert" id="errorMessageDiv">
                <i class="fas fa-exclamation-triangle mr-2"></i>
                <span id="errorMessageText"></span>
            </div>
        </div>

        <form method="POST" action="#" novalidate id="forgotForm">
            
            <div class="form-floating">
                <i class="fas fa-envelope input-icon"></i>
                <input type="email" class="form-control" id="email" name="email" placeholder="Correo Electrónico" required autocomplete="email">
                <label for="email">Correo Electrónico</label>
            </div>

            <button type="submit" class="btn btn-login-submit mt-3" id="btnRecover">
                <i class="fas fa-paper-plane mr-2"></i>
                Reestablecer contraseña
            </button>
        </form>

        <div class="text-center mt-4">
            <a href="<%= request.getContextPath() %>/login.jsp" class="btn-home-link">
                <i class="fas fa-sign-in-alt mr-2"></i> Volver a Iniciar Sesión
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

        // Lógica de validación
        const form = document.getElementById('forgotForm');
        form.addEventListener('submit', function(e) {
            let isValid = true;
            
            inputs.forEach(input => input.classList.remove('is-invalid'));
            const errorAlert = document.getElementById('errorAlert');
            if (errorAlert) errorAlert.style.display = 'none';

            inputs.forEach(input => {
                if (!input.value.trim()) {
                    input.classList.add('is-invalid');
                    isValid = false;
                }
            });

            if (!isValid) {
                e.preventDefault();
                if (errorAlert) {
                    document.getElementById('errorMessageText').textContent = "Por favor, ingresa tu correo electrónico.";
                    errorAlert.style.display = 'block';
                }
            }
        });

        // Partículas (amarillo predominante)
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
