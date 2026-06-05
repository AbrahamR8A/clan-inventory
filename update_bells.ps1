$viewsDir = "c:\Users\AbrahamR8A\Documents\Proyecto CLAN_INVENTORY\clan-inventory\src\main\webapp\views"

$dynamicBell = @"
                        <!-- Nav Item - Alerts -->
                        <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-bell fa-fw"></i>
                                <!-- Counter - Alerts -->
                                <c:if test="`$"{notificacionesNoLeidas > 0}"`}">
                                    <span class="badge badge-danger badge-counter">`$"{notificacionesNoLeidas}"`}</span>
                                </c:if>
                            </a>
                            <!-- Dropdown - Alerts -->
                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="alertsDropdown">
                                <h6 class="dropdown-header bg-admin text-white border-0">
                                    Centro de Alertas
                                </h6>

                                <c:forEach var="notif" items="`$"{listaNotificaciones}"`}">
                                    <a class="dropdown-item d-flex align-items-center" href="#">
                                        <div class="mr-3">
                                            <div class="icon-circle bg-`$"{notif.tipo}"`}">
                                                <c:choose>
                                                    <c:when test="`$"{notif.tipo == 'success'}"`}"><i class="fas fa-check text-white"></i></c:when>
                                                    <c:when test="`$"{notif.tipo == 'warning'}"`}"><i class="fas fa-exclamation-triangle text-white"></i></c:when>
                                                    <c:when test="`$"{notif.tipo == 'danger'}"`}"><i class="fas fa-exclamation-circle text-white"></i></c:when>
                                                    <c:otherwise><i class="fas fa-info text-white"></i></c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div>
                                            <div class="small text-gray-500">`$"{notif.fechaCreacion}"`}</div>
                                            <span class="`$"{notif.leido ? '' : 'font-weight-bold'}"`}">`$"{notif.mensaje}"`}</span>
                                        </div>
                                    </a>
                                </c:forEach>
                                <c:if test="`$"{empty listaNotificaciones}"`}">
                                     <a class="dropdown-item text-center small text-gray-500" href="#">No hay notificaciones</a>
                                </c:if>
                            </div>
                        </li>
"@

# Corregir los escapes que usa Powershell para strings con $ (queremos mantener ${variable})
$dynamicBell = $dynamicBell.Replace('`$"{', '${')
$dynamicBell = $dynamicBell.Replace('}"`}', '}')

$pattern1 = '<li\s+class="nav-item\s+dropdown\s+no-arrow\s+mx-1"\s*>\s*<a\s+class="nav-link"\s+href="#"\s*>\s*<i\s+class="fas\s+fa-bell\s+fa-fw"\s*>\s*</i>\s*</a>\s*</li>'
$pattern2 = '<li\s+class="nav-item\s+dropdown\s+no-arrow\s+mx-1"\s*>\s*<a\s+class="nav-link"\s+dropdown-toggle\s+href="#"\s*>\s*<i\s+class="fas\s+fa-bell\s+fa-fw"\s*>\s*</i>\s*</a>\s*</li>'

$utf8NoBom = New-Object System.Text.UTF8Encoding $False
$count = 0

Get-ChildItem -Path $viewsDir -Filter "*.jsp" -Recurse | ForEach-Object {
    if ($_.Name -ne "inicio_administrador.jsp") {
        $content = [System.IO.File]::ReadAllText($_.FullName)
        
        if (-not ($content -match "alertsDropdown")) {
            $newContent = [regex]::Replace($content, $pattern1, $dynamicBell, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
            
            # intentamos el otro patrón de inicio_solicitante si es distinto
            $newContent = [regex]::Replace($newContent, $pattern2, $dynamicBell, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)

            # Si es otra variación donde solo hay <a><i></i></a>
            $pattern3 = '<a\s+class="nav-link"\s+href="#"\s*>\s*<i\s+class="fas\s+fa-bell\s+fa-fw"\s*>\s*</i>\s*</a>'
            $newContent = [regex]::Replace($newContent, $pattern3, $dynamicBell, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)

            if ($newContent -ne $content) {
                [System.IO.File]::WriteAllText($_.FullName, $newContent, $utf8NoBom)
                $count++
                Write-Host "Modificado: $($_.FullName)"
            }
        }
    }
}
Write-Host "Total modificados: $count"
