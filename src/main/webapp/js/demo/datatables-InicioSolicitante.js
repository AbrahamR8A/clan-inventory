// DataTable de la Tabla de Actividad Reciente (Inicio del Solicitante)
let dataTable;

const dataTableOptions = {
  pageLength: 4,
  destroy: true,
  lengthMenu: [4, 8, 12],

  columnDefs: [
    { className: "centered", targets: [0, 1, 3, 4] },
    { orderable: false, targets: [4] }   // columna Acción
  ],

  language: {
    lengthMenu: "Mostrar _MENU_ registros por pagina",
    zeroRecords: "Ninguna solicitud encontrada",
    info: "Mostrando de _START_ a _END_ de un total de _TOTAL_ registros",
    infoEmpty: "Ninguna solicitud encontrada",
    infoFiltered: "(filtrado de _MAX_ registros en total)",
    search: "Buscar",
    loadingRecords: "Cargando...",
    paginate: {
      first: "Primero",
      last: "Último",
      next: "Siguiente",
      previous: "Anterior"
    }
  }
};

$(document).ready(function () {
  dataTable = $('#dataTable').DataTable(dataTableOptions);
  // Se expone globalmente para que el filtro "Por Estado" pueda usarlo
  window.dataTable = dataTable;
});
