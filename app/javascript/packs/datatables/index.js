
require('datatables.net');
require('datatables.net-bs4');
require('datatables.net-responsive');
require('datatables.net-responsive-bs4');

require('datatables.net-buttons-bs4');



import '../../stylesheets/datatables/index.scss';
//require('../../stylesheets/datatables/index.scss');

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
    $('.dashboard_datatable').DataTable({
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




$(function() {
    $('.normal_datatable').DataTable({
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



/*
$(function() {
    $('#normal_datatable').DataTable({
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
    $('#normal_datatable_second').DataTable({
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

    var table = $('#dashboard_studyplan_datatable').dataTable({
        "paging": true,
        "lengthChange": false,
        "searching": false,
        "ordering": true,
        "info": true,
        "autoWidth": false,
        "responsive": true,
        "language": ja_DataTable
    });
    table.state.clear();
    table.destroy();
    $("#dashboard_studyplan_datatable tbody").empty();
    table.draw();
    //table.draw();
    //$('#dashboard_studyplan_datatable').DataTable().destroy();
});

$(function() {
    $('#dashboard_subject_datatable').DataTable({
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

*/