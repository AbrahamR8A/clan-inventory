import os
import re

views_dir = r"c:\Users\AbrahamR8A\Documents\Proyecto CLAN_INVENTORY\clan-inventory\src\main\webapp\views"

# El bloque dinámico que queremos inyectar
dynamic_bell = """                        <!-- Nav Item - Alerts -->
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
                        </li>"""

# Expresiones regulares para encontrar los diferentes patrones del bloque de la campana
# Patron 1: El que vimos en inicio_solicitante.jsp
# <li class="nav-item dropdown no-arrow mx-1">
#     <a class="nav-link" href="#"><i class="fas fa-bell fa-fw"></i></a>
# </li>
pattern1 = re.compile(
    r'<li\s+class="nav-item\s+dropdown\s+no-arrow\s+mx-1"\s*>\s*<a\s+class="nav-link"\s+href="#"\s*>\s*<i\s+class="fas\s+fa-bell\s+fa-fw"\s*>\s*</i>\s*</a>\s*</li>',
    re.IGNORECASE | re.DOTALL
)

count = 0
for root, dirs, files in os.walk(views_dir):
    for file in files:
        if file.endswith(".jsp") and file != "inicio_administrador.jsp":
            filepath = os.path.join(root, file)
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()

            # Skip if already has dropdown
            if "alertsDropdown" in content and "notificacionesNoLeidas" in content:
                continue

            new_content = pattern1.sub(dynamic_bell, content)
            
            if new_content != content:
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(new_content)
                count += 1
                print(f"Modificado: {filepath}")

print(f"Total modificados: {count}")
