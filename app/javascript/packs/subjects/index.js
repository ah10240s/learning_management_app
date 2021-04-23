//import '/node_modules/admin-lte/plugins/datatables/jquery.dataTables';
//import '/node_modules/admin-lte/plugins/datatables-bs4/js/dataTables.bootstrap4';
//import '/node_modules/admin-lte/plugins/datatables-responsive/js/dataTables.responsive';
//import '/node_modules/admin-lte/plugins/datatables-responsive/js/responsive.bootstrap4';


require('datatables.net');
require('datatables.net-bs4');
require('datatables.net-responsive');
require('datatables.net-responsive-bs4');

require('datatables.net-buttons-bs4');



import '../../stylesheets/subjects/index.scss';

var ja_DataTable = {
                "sProcessing":   "処理中...",
                "sLengthMenu":   "_MENU_ 件表示",
                "sZeroRecords":  "データはありません。",
                "sInfo":         " _TOTAL_ 件中 _START_ から _END_ まで表示",
                "sInfoEmpty":    " 0 件中 0 から 0 まで表示",
                "sInfoFiltered": "（全 _MAX_ 件より抽出）",
                "sInfoPostFix":  "",
                "sSearch":       "検索:",
                "sUrl":          "",
                "oPaginate": {
                    "sFirst":    "先頭",
                    "sPrevious": "前",
                    "sNext":     "次",
                    "sLast":     "最終"
                }
            };

$(function() {
    $('#users_example').DataTable({
        "paging": true,
        "lengthChange": true,
        "searching": true,
        "ordering": true,
        "info": true,
        "autoWidth": false,
        "responsive": true,
        "language": ja_DataTable
    });
});

$(function() {
    $('#users_example2').DataTable({
        "paging": true,
        "lengthChange": false,
        "searching": false,
        "ordering": true,
        "info": true,
        "autoWidth": false,
        "responsive": true,
        "language": ja_DataTable
    });
});