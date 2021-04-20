//import '/node_modules/admin-lte/plugins/datatables/jquery.dataTables';
//import '/node_modules/admin-lte/plugins/datatables-bs4/js/dataTables.bootstrap4';
//import '/node_modules/admin-lte/plugins/datatables-responsive/js/dataTables.responsive';
//import '/node_modules/admin-lte/plugins/datatables-responsive/js/responsive.bootstrap4';


require('datatables.net');
require('datatables.net-bs4');
require('datatables.net-responsive');
require('datatables.net-responsive-bs4');






import '../../stylesheets/subjects/index.scss';

$(function() {
    $('#users_example').DataTable({
        "paging": true,
        "lengthChange": true,
        "searching": true,
        "ordering": true,
        "info": true,
        "autoWidth": false,
        "responsive": true,
        "language":{ url: "http://cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Japanese.json" }
    });
});