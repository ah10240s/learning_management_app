import '/node_modules/admin-lte/plugins/datatables/jquery.dataTables';


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