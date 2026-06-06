// DataTables - Inicio Solicitante
// Inicializa la tabla y expone la instancia en window.dataTable
// para que el filtro de estado del JSP pueda usarla.

$(document).ready(function () {

    window.dataTable = $('#dataTable').DataTable({
        pageLength: 6,
        destroy: true,
        searching: true,   // necesario para que el filtro por columna funcione

        lengthMenu: [6, 8, 10],

        columnDefs: [
            { className: "text-center align-middle", targets: [0, 1, 3, 4] },
            { orderable: false, targets: [4] }   // columna Acción no ordenable
        ],

        language: {
            lengthMenu: "Mostrar _MENU_ registros por página",
            zeroRecords: "No se encontraron solicitudes",
            info: "Mostrando de _START_ a _END_ de _TOTAL_ solicitudes",
            infoEmpty: "No hay solicitudes para mostrar",
            search: "Buscar:",
            loadingRecords: "Cargando...",
            paginate: {
                first:    "Primero",
                last:     "Último",
                next:     "Siguiente",
                previous: "Anterior"
            }
        }
    });

});
