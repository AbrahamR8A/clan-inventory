let dataTable;

const dataTableOptions = {
  pageLength: 4,
  destroy:true,
  lengthChange: false,
  searching: false,
  info: false,

  //scrollX: "2000px",

  columnDefs: [
      {className:"centered",targets:[0, 1, 2, 3, 4, 5] },
      {orderable: false,targets:[4, 5]},
      //{width: "15%",targets:[2] }
    ],

  language:{
    lengthMenu: "Mostrar _MENU_ registros por pagina",
    zeroRecords: "Ningún usuario encontrado",
    info: "Mostrando de _START_ a _END_ de un total de _TOTAL_ registros",
    infoEmpty: "Ningún usuario encontrado",
    search: "Buscar",
    loadingRecords: "Cargando...",
    paginate: {
      first: "Primero",
      last: "Último",
      next: "Siguiente",
      previous: "Anterior",
    }
  }
};

// Call the dataTables jQuery plugin
$(document).ready(function() {
  dataTable = $('#dataTable').DataTable(dataTableOptions);
});



