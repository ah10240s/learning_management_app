import 'admin-lte/plugins/datatables/jquery.dataTables';
import 'admin-lte/plugins/datatables-bs4/js/dataTables.bootstrap4';
import 'admin-lte/plugins/datatables-responsive/js/dataTables.responsive';
import 'admin-lte/plugins/datatables-responsive/js/responsive.bootstrap4';

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