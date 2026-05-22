let dataTable;

const dataTableOptions = {
  pageLength: 5,
  destroy:true,

  //scrollX: "2000px",

  lengthMenu:[5, 10, 25],

  columnDefs: [
      {className:"centered",targets:[0, 3, 4, 5] },
      //{width: "15%",targets:[2] }
    ],

  language:{
    lengthMenu: "Mostrar _MENU_ registros por pagina",
    zeroRecords: "Ningún registro encontrado",
    info: "Mostrando de _START_ a _END_ de un total de _TOTAL_ registros",
    infoEmpty: "Ningún registro encontrado",
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



