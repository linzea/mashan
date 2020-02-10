var manageBatch = function () {
    var actionsTemplate = $("#actionsTemplate").html();
    var manageBatchShow = function () {
        var option = {
            data: {
                type: 'remote',
                source: {
                    read: {
                        url: 'getManageBatchDataList'
                    }
                },
                pageSize: 10,
                saveState: {
                    cookie: true,
                    webstorage: true
                }
            },
            layout: {
                theme: 'default', // datatable theme
                class: '',        // custom wrapper class
                scroll: false,    // 启用滚动条
                footer: false     // 页脚启用,隐藏
            },
            sortable: true,
            filterable: false,
            pagination: true,
            columns: [
                {title: "#", width: 40, template: function (row) {
                    return row.rowIndex+1;
                }},
                {field: "batch_number", title: "批次号", width: 150},
                {field: "gardenName", title: "茶园名称", width: 150},
                {field: "create_time", title: "创建时间", sortable: 'asc', width: 150},
                {
                    field: "Actions",
                    width: 100,
                    title: "操作",
                    sortable: false,
                    overflow: 'visible',
                    template: function (row) {
                        var dropup = (row.getIndex() - row.getIndex()) <= 4 ? 'dropup' : '';
                        return actionsTemplate.replace(/#rowId#/g, row.id);
                    }
                }]
        }
        var datatable = $('.manage_batch_ajax').mDatatable(option);

        var query = datatable.getDataSourceQuery();

        $('#m_form_search').on('keyup', function (e) {
            var query = datatable.getDataSourceQuery();
            query.generalSearch = $(this).val().toLowerCase();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(query.generalSearch);

        $('#m_form_tea_garden').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.tea_garden_id = $(this).val().toLowerCase();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(typeof query.tea_garden_id !== 'undefined' ? query.tea_garden_id : '');
        $('.datatableRoload').on('click', function () {
            location.reload()
        });
        $('.select_selectpicker').selectpicker();
    };


    /**
     * 表单验证
     * 新增与编辑
     */
    var manageBatchForm = function () {
        $( "#manage_batch_edit_form" ).validate({
            rules: {
                teaGardenId:{required: true,},
                batchNumber:{required: true,optionalCheck: true},
            },
            submitHandler: function (form){
                blockUiOpen('.manageBatchEdit .modal-content');
                request(
                    "saveManageBatch",
                    "post",
                    $("#manage_batch_edit_form").serialize(),
                    function(result){
                        if(result.message){
                            ToastrMsg(result.data,"success","topRight",'.manageBatchEdit .modal-content',"reload",true);
                        }else{
                            ToastrMsg(result.data,"error","topRight",'.manageBatchEdit .modal-content');
                        }
                    }
                )
            }
        });
    }

    /**
     * 重置表单
     */
    var removeValue = function(type){
        if(type == 'edit'){
            $(".manageBatchEdit .modal-title").text("批次编辑").attr("disabled",true)
            $(".manageBatchEdit [name='save']").val('edit')
            $(".reset-btn").addClass("m--hide");
        }else{
            $(".manageBatchEdit .modal-title").text("批次新增")
            $(".manageBatchEdit [name='save']").val('add');
            $(".reset-btn").removeClass("m--hide");
        }
        $(".manageBatchEdit [name='id']").val('')
        $(".manageBatchEdit [name='batchNumber']").val("").attr("disabled",false);
        $(".manageBatchEdit [name='teaGardenId']").val('').attr("disabled",false);
        $(".manageBatchEdit [name='description']").val('');
        $('.status_switch').bootstrapSwitch('state',false);
        $(".manageBatchEdit [name='status']").val("")
        $(".teaGardenEdit .form-control-feedback").remove()
        $(".manageBatchEdit div").removeClass("has-danger")
        $(".manageBatchEdit div").removeClass("has-success")
    }

    /**
     * 新增
     */
    var addManageBatch = function () {
        $(".addManageBatch").on('click',function(){
            removeValue('add')
        })
    }

    /**
     * 获取信息,并移除上一轮错误信息
     */
    var editManageBatchItem = function () {
        $("#manage_batch_list").on("click", ".editManageBatchItem", function () {
            removeValue('edit')
            var id = $(this).attr("item");
            if(id != ""){
                request(
                    "getManageBatchItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            $("#manage_batch_edit_form [name='id']").val(result.data.id)
                            $("#manage_batch_edit_form [name='batchNumber']").val(result.data.batchNumber).attr("disabled",true);
                            $("#manage_batch_edit_form [name='teaGardenId']").val(result.data.teaGardenId).attr("disabled",true);
                            $("#manage_batch_edit_form [name='status']").val(result.data.status)
                            if(result.data.status == 1){
                                $('.status_switch').bootstrapSwitch('state',true);
                            }else{
                                $('.status_switch').bootstrapSwitch('state',false);
                            }
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#manage_batch_list');
                        }
                    })
            }
        })
    }


    /**
     * 删除
     */
    var delManageBatchItem = function () {
        $("#manage_batch_list ").on("click", ".delManageBatchItem", function () {
            blockUiOpen('#manage_batch_list');
            var self = $(this);
            var id = self.attr("item");
            if(id != ""){
                request(
                    "delManageBatchItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            self.parents("tr").remove();
                            ToastrMsg(result.data,"success","topRight",'#manage_batch_list');
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#manage_batch_list');
                        }
                    })
            }
        })
    }

    /**
     * 获取数据
     */
    var getMsuData = function () {
        $(".manageBatchEdit .la-hand-o-up").on("click",function () {
            var treeGar = $(".manageBatchEdit .teaGardenId").val(),
                save    = $(".manageBatchEdit [name='save']").val();
            if (treeGar != "" && save == "add"){
                var tree_attr = $(".teaGardenId  option:selected").attr("tree_attr"),
                    area_code = $(".teaGardenId  option:selected").attr("area_code");
                request(
                    "getMsuData",
                    'get',
                    {},
                    function (result) {
                        if(result.message){
                            $("#batchNumber").val(area_code+"-"+tree_attr+"-"+result.data)
                        }else{
                            ToastrMsg('获取失败,请稍后再试.',"warning","topRight",'#modalBloukUi');
                        }
                    })
            }else{
                if (save == "edit"){
                    return false;
                }else{
                    ToastrMsg("请选择茶园信息.","warning","topRight",'#manage_batch_list');
                }
            }
        })
    }

    return {
        init: function () {
            addManageBatch();
            editManageBatchItem();
            delManageBatchItem();
            manageBatchShow();
            manageBatchForm();
            getMsuData();
        }
    };
}();



jQuery(document).ready(function () {
    manageBatch.init();
    $('.status_switch').bootstrapSwitch();
    $('.status_switch').on('switchChange.bootstrapSwitch', function (event,state) {
        if(state==true){
            $(this).parents("div").find(".status_switch_parent").find("[name='status']").val(1)
        }else{
            $(this).parents("div").find(".status_switch_parent").find("[name='status']").val(2)
        }
    });
});