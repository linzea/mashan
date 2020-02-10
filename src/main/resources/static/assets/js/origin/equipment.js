var equipment = function () {
    var actionsTemplate = $("#actionsTemplate").html();
    var status = {
        2: {'title': '禁用', 'class': ' m-badge--warning'},
        1: {'title': '启用', 'class': ' m-badge--success'}
    };
    /**
     * 获取列表数据
     */
    var getEquipmentDataList = function () {
        var option = {
            data: {
                type: 'remote',
                source: {
                    read: {
                        url: 'getEquipmentDataList'
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
            columns: [{ field: "unitName", title: "设备名称", width: 100 },
                { field: "unitNo", title: "资产编号", width: 100 },
                { field: "equName", title: "设备用途", width: 100 },
                { field: "unitType", title: "设备型号", width: 100 },
                { field: "unitCycle", title: "维护周期", width: 100 },
                { field: "status", title: "状态", width: 100,
                template: function (row) {
                    return '<span class="m-badge ' + status[row.status].class + ' m-badge--wide">' + status[row.status].title + '</span>';
                }
            },{ field: "createName", title: "记录人", width: 100
            },{ field: "Actions", width: 100, title: "操作", sortable: false, overflow: 'visible',
                template: function (row) {
                    var dropup = (row.getIndex() - row.getIndex()) <= 4 ? 'dropup' : '';
                    return actionsTemplate.replace(/#rowId#/g, row.id);
                }
            }]
        }
        var datatable = $('.equipment_list').mDatatable(option);
        var query = datatable.getDataSourceQuery();
        $('#status').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.status = $(this).val();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(typeof query.status !== 'undefined' ? query.status : '');
        $('#m_form_search').on('keyup', function (e) {
            var query = datatable.getDataSourceQuery();
            query.generalSearch = $(this).val().toLowerCase();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(query.generalSearch);

        $('.datatableRoload').on('click', function () {
            location.reload()
        });
        $('.select_selectpicker').selectpicker();
    };


    /**
     * 新增与编辑表单验证
     * 加工设置
     */
    var equipmentEditForm = function () {
        $( "#equipment_edit_form" ).validate({
            rules: {
                unitName: {required: true},
                unitNo: {required: true},
                unitUsage: {required: true},
                unitType: { required: true},
                unitCycle: {required: true,digits:true,maxlength:2},
                unitClear: {required: true,digits:true,maxlength:2},
                description: {nameCheck:true},
                dicTeaAttr: {required: true},
                pickArea: {required: true}
            },
            submitHandler: function (form){
                blockUiOpen('.equipmentEditModal .modal-content');
                request(
                    "saveOrUpdateEquipment",
                    "post",
                    $("#equipment_edit_form").serialize(),
                    function(result){
                        if(result.message){
                            ToastrMsg(result.data,"success","topRight",'.equipmentEditModal .modal-content',"reload",true);
                        }else{
                            ToastrMsg(result.data,"error","topRight",'.equipmentEditModal .modal-content');
                        }
                    }
                )
            }
        });
    }
    /**
     * 获取所编辑的数据
     */
    var editEquipmentItem = function () {
        $("#equipment_list").on("click", ".editEquipmentItem", function () {
            removeValue('edit')
            var id = $(this).attr("item");
            if(id != ""){
                request(
                    "editEquipmentItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            $(".equipmentEditModal [name='id']").val(result.data.id)
                            $(".equipmentEditModal [name='unitName']").val(result.data.unitName).attr("disabled",true)
                            $(".equipmentEditModal [name='unitUsage']").val(result.data.unitUsage).attr("disabled",true)
                            $(".equipmentEditModal [name='dicTeaAttr']").val(result.data.dic_tea_attr).attr("disabled",true)
                            $(".equipmentEditModal [name='unitType']").val(result.data.unitType).attr("disabled",true)
                            $(".equipmentEditModal [name='unitNo']").val(result.data.unitNo).attr("disabled",true)
                            $(".equipmentEditModal #createUser").val(result.data.createUser)
                            $(".equipmentEditModal [name='unitCycle']").val(result.data.unitCycle)
                            $(".equipmentEditModal [name='unitClear']").val(result.data.unitClear)
                            $(".equipmentEditModal [name='description']").val(result.data.description);
                            $(".equipmentEditModal [name='status']").val(result.data.status)
                            if(result.data.status == 1){
                                $('.status_switch').bootstrapSwitch('state',true);
                            }else{
                                $('.status_switch').bootstrapSwitch('state',false);
                            }
                            if (result.data.imgUrl){
                                myDropzone.emit("initimage", result.data.imgUrl); //初始化图片
                                $(".equipmentEditModal [name='imgUrl']").val(result.data.imgUrl)
                            }
                        }else{
                            ToastrMsg(result.data,"error","topRight");
                        }
                    })
            }
        })
    }
    /**
     * 删除单条数据
     */
    var delEquipmentItem = function () {
        $("#equipment_list").on("click", ".delEquipmentItem", function () {
            blockUiOpen('#equipment_list');
            var self = $(this);
            var id = self.attr("item");
            if(id != ""){
                request(
                    "delEquipmentItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            self.parents("tr").remove();
                            ToastrMsg(result.data,"success","topRight",'#equipment_list');
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#equipment_list');
                        }
                    })
            }
        })
    }
    /**
     * 重置表单
     */
    var removeValue = function(type){
        var createUser = $("#chineseName").text();
        myDropzone.removeAllFiles(true);
        if(type == 'edit'){
            $(".equipmentEditModal .modal-title").text("编辑设备")
            $(".equipmentEditModal [name='save']").val('edit')
            $(".reset-btn").addClass("m--hide");
        }else{
            $(".equipmentEditModal .modal-title").text("新增设备")
            $(".equipmentEditModal [name='save']").val('add');
            $(".reset-btn").removeClass("m--hide");
        }
        $(".equipmentEditModal [name='id']").val("")
        $(".equipmentEditModal [name='unitName']").val("").attr("disabled",false)
        $(".equipmentEditModal [name='unitUsage']").val("").attr("disabled",false)
        $(".equipmentEditModal [name='unitType']").val("").attr("disabled",false)
        $(".equipmentEditModal [name='unitNo']").val("").attr("disabled",false)
        $(".equipmentEditModal [name='unitCycle']").val("").attr("disabled",false)
        $(".equipmentEditModal [name='status']").val(2)
        $(".equipmentEditModal [name='dicTeaAttr']").val("").attr("disabled",false)
        $(".equipmentEditModal [name='description']").val("")
        $(".equipmentEditModal [name='unitClear']").val("")
        $(".equipmentEditModal #createUser").val(createUser)
        $(".equipmentEditModal .form-control-feedback").remove()
        $('.status_switch').bootstrapSwitch('state',false);

        $(".equipmentEditModal div").removeClass("has-danger")
        $(".equipmentEditModal div").removeClass("has-success")
    }

    /**
     * 新增重置表单初始值
     */
    var addEquipmentItem = function () {
        $(".addEquipmentItem").on('click',function(){
            removeValue('add')
        })
    }

    return {
        init: function () {
            getEquipmentDataList();
            editEquipmentItem();
            equipmentEditForm();
            addEquipmentItem();
            delEquipmentItem();
        }
    };
}();
jQuery(document).ready(function () {
    equipment.init();
    $('.status_switch').bootstrapSwitch({
        onText:'开启',
        offText:'关闭',
        handleWidth:'60'
    });
    $('.status_switch').on('switchChange.bootstrapSwitch', function (event,state) {
        if(state==true){
            $(this).parents("div").find(".status_switch_parent").find("[name='status']").val(1)
        }else{
            $(this).parents("div").find(".status_switch_parent").find("[name='status']").val(2)
        }
    });
});