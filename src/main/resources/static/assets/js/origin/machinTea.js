var MachinTea = function () {
    var actionsTemplate = $("#actionsTemplate").html();
    var status = {
        1: {'title': '进行中', 'class': ' m-badge--warning'},
        3: {'title': '终止', 'class': ' m-badge--danger'},
        2: {'title': '完成', 'class': ' m-badge--success'}
    };
    /**
     * 获取列表数据
     */
    var getMachinTeaDataList = function () {
        var option = {
            data: {
                type: 'remote',
                source: {
                    read: {
                        url: 'getMachinTeaDataList'
                    }
                },
                pageSize: 10,
                saveState: {
                    cookie: true,
                    webstorage: true
                },
                serverPaging: false,
                serverFiltering: false,
                serverSorting: false
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
            columns: [{
                field: "batchNumber",
                title: "加工批次",
                width: 150
            },{
                field: "macTypeName",
                title: "类型",
                width: 60
            },{
                field: "teaAttrName",
                title: "茶系",
                width: 60
            }, {
                field: "macProName",
                title: "工序",
                width: 60
            }, {
                field: "teaTypeName",
                title: "品种",
                overflow: 'hide',
                width: 60
            }, {
                field: "mac_loss",
                title: "损耗",
                width: 60,
                template: function (row) {
                    return row.mac_loss+" %∑";
                }
            },{
                field: "temperature",
                title: "温度",
                width: 60,
                template: function (row) {
                    return row.temperature+" &#8451;";
                }
            },{
                field: "humidity",
                title: "湿度",
                width: 60,
                template: function (row) {
                    return row.humidity+" %RH";
                }
            },{
                field: "machinStatus",
                title: "状态",
                width: 60,
                template: function (row) {
                    return '<span class="m-badge ' + status[row.machin_status].class + ' m-badge--wide">' + status[row.machin_status].title + '</span>';
                }
            },{
                field: "create_time",
                title: "创建时间",
                width: 150,
                sortable: 'desc'
            },{
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
        var datatable = $('.machin_tea_list').mDatatable(option);
        var query = datatable.getDataSourceQuery();
        $('#processBatchId').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.processBatchId = $(this).val();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(typeof query.processBatchId !== 'undefined' ? query.processBatchId : '');

        $('#m_form_search').on('keyup', function (e) {
            var query = datatable.getDataSourceQuery();
            query.generalSearch = $(this).val().toLowerCase();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(query.generalSearch);
        $('#dicMacType').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.dicMacType = $(this).val().toLowerCase();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(typeof query.dicMacType !== 'undefined' ? query.dicMacType : '');
        $('#dicTeaAttr').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.dicTeaAttr = $(this).val();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(typeof query.dicTeaAttr !== 'undefined' ? query.dicTeaAttr : '');
        $('#dicMacPro').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.dicMacPro = $(this).val();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(typeof query.dicMacPro !== 'undefined' ? query.dicMacPro : '');

        $('.datatableRoload').on('click', function () {
            location.reload()
        });
        $('.select_selectpicker').selectpicker();
    };


    /**
     * 新增与编辑表单验证
     * 加工设置
     */
    var MachinTeaEditForm = function () {
        $( "#machin_tea_edit_form" ).validate({
            rules: {
                processBatchId: {required: true},
                dicMacType: {required: true},
                dicTeaAttr: {required: true},
                dicMacPro: { required: true},
                machinStatus: {required: true},
                beginTime: {required:true},
                endTime: {required: true},
                temperature: {digits:true,maxlength:3},
                humidity: {digits:true,maxlength:2},
                macLoss: {digits:true,maxlength:2},
                description: {nameCheck:true}
            },
            submitHandler: function (form){
                blockUiOpen('.MachinTeaEdit .modal-content');
                request(
                    "saveOrUpdateMachinTea",
                    "post",
                    $("#machin_tea_edit_form").serialize(),
                    function(result){
                        if(result.message){
                            blockUiClose('#machin_tea_edit_form .modal-content',1,".close-parent",0);
                            ToastrMsg(result.data,"success","topRight");
                            location.reload()
                        }else{
                            ToastrMsg(result.data,"error","topRight");
                        }
                    }
                )
            }
        });
    }
    /**
     * 获取所编辑的数据
     */
    var editMachinTeaItem = function () {
        $("#machin_tea_list").on("click", ".editMachinTeaItem", function () {
            removeValue('edit')
            var id = $(this).attr("item");
            if(id != ""){
                request(
                    "editMachinTeaItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            $("#machin_tea_edit_form [name='id']").val(result.data.id)
                            $("#machin_tea_edit_form [name='dicMacType']").val(result.data.dicMacType)
                            $("#machin_tea_edit_form [name='dicTeaAttr']").val(result.data.dicTeaAttr)
                            $("#machin_tea_edit_form [name='dicMacPro']").val(result.data.dicMacPro)
                            $("#machin_tea_edit_form [name='dicTeaType']").val(result.data.dicTeaType)
                            $("#machin_tea_edit_form [name='machinStatus'][value='"+result.data.machinStatus+"']").click()
                            $("#machin_tea_edit_form [name='beginTime']").val(result.data.beginTime)
                            $("#machin_tea_edit_form [name='endTime']").val(result.data.endTime)
                            $("#machin_tea_edit_form [name='temperature']").val(result.data.temperature)
                            $("#machin_tea_edit_form [name='humidity']").val(result.data.humidity)
                            $("#machin_tea_edit_form [name='macLoss']").val(result.data.macLoss)
                            $("#machin_tea_edit_form [name='description']").val(result.data.description)
                            $("#machin_tea_edit_form [name='status']").val(result.data.status)
                            $("#machin_tea_edit_form [name='processBatchId']").val(result.data.processBatchId)
                            if(result.data.status == 1){
                                $('.status_switch').bootstrapSwitch('state',true);
                            }else{
                                $('.status_switch').bootstrapSwitch('state',false);
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
    var delMachinTeaItem = function () {
        $("#machin_tea_list").on("click", ".delMachinTeaItem", function () {
            blockUiOpen('#machin_tea_list');
            var self = $(this);
            var id = self.attr("item");
            if(id != ""){
                request(
                    "delMachinTeaItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            self.parents("tr").remove();
                            ToastrMsg(result.data,"success","topRight",'#machin_tea_list');
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#machin_tea_list');
                        }
                    })
            }
        })
    }
    /**
     * 重置表单
     */
    var removeValue = function(type){
        if(type == 'edit'){
            $(".machinTeaEditModal .modal-title").text("编辑加工记录")
            $(".machinTeaEditModal [name='save']").val('edit')
            $(".reset-btn").addClass("m--hide");
        }else{
            $(".machinTeaEditModal .modal-title").text("新增加工记录")
            $(".reset-btn").removeClass("m--hide");
            $(".machinTeaEditModal [name='save']").val('add');
        }
        $(".machinTeaEditModal [name='id']").val("")
        $(".machinTeaEditModal [name='dicMacType']").val("")
        $(".machinTeaEditModal [name='dicTeaAttr']").val("")
        $(".machinTeaEditModal [name='dicMacPro']").val("")
        $(".machinTeaEditModal [name='dicTeaType']").val("")
        $(".machinTeaEditModal [name='beginTime']").val("")
        $(".machinTeaEditModal [name='endTime']").val("")
        $(".machinTeaEditModal [name='temperature']").val("")
        $(".machinTeaEditModal [name='humidity']").val("")
        $(".machinTeaEditModal [name='macLoss']").val("")
        $(".machinTeaEditModal [name='description']").val("")
        $(".machinTeaEditModal [name='status']").val(2)
        $(".machinTeaEditModal [name='processBatchId']").val("")
        $('.status_switch').bootstrapSwitch('state',false);
        $(".machinTeaEditModal .form-control-feedback").remove()
        $(".machinTeaEditModal div").removeClass("has-danger")
        $(".machinTeaEditModal div").removeClass("has-success")
    }

    /**
     * 新增重置表单初始值
     */
    var addMachinTeaItem = function () {
        $(".addmachinTeaItem").on('click',function(){
            removeValue('add')
        })
    }

    /**
     * 获取加工设置数据
     */
    var getMachinSetData = function () {
        $(".machinTeaEditModal .getMachinSetData").on("change",function () {
            var dicMacPro = $(".machinTeaEditModal #dicMacPro").val(),//加工工序
                dicMacType = $(".machinTeaEditModal #dicMacType").val(),//加工类型
                processBatchId = $(".machinTeaEditModal #processBatchId").val();//加工批次Id
            if(processBatchId == ""){
                $(".processBatchId").addClass("has-danger");
                return false;
            }
            if(dicMacType == ""){
                $(".dicMacType").addClass("has-danger");
                return false;
            }
            if(dicMacPro == ""){
                $(".dicMacPro").addClass("has-danger");
                return false;
            }
            $(".machinTeaEditModal div").removeClass("has-danger")
            blockUiOpen('#modalBloukUi');
            request(
                "getMachinSetData",
                'get',
                {dicMacPro:dicMacPro,dicMacType:dicMacType,processBatchId:processBatchId},
                function (result) {
                    if(result.message){
                        $("#machin_tea_edit_form [name='dicTeaAttr']").val(result.data.dic_tea_attr)
                        $("#machin_tea_edit_form [name='dicTeaType']").val(result.data.dic_tea_type)
                        $("#machin_tea_edit_form [name='beginTime']").val(result.data.beginTime)
                        $("#machin_tea_edit_form [name='endTime']").val(result.data.endTime)
                        $("#machin_tea_edit_form [name='temperature']").val(result.data.temperature)
                        $("#machin_tea_edit_form [name='humidity']").val(result.data.humidity)
                        $("#machin_tea_edit_form [name='macLoss']").val(result.data.mac_loss)
                        $("#machin_tea_edit_form [name='description']").val(result.data.description)
                        $("#machin_tea_edit_form [name='status']").val(result.data.status)
                        $("#machin_tea_edit_form [name='beginTime']").val(result.data.beginTime)
                        $("#machin_tea_edit_form [name='endTime']").val(result.data.endTime)
                        blockUiClose('#modalBloukUi',0,".close-parent",0);
                    }else{
                        ToastrMsg(result.data,"error","topRight",'#modalBloukUi');
                    }
                })
        })
    }

    /**
     * bootstrap datetimepicker 插件
     * 输入时间请先了解单个参数
     */
    var datetimepickerSelect = function () {
        $('.beginTime').datetimepicker({
            todayHighlight: false,
            autoclose: true,
            sideBySide: false,
            pickerPosition: 'top-right',
            format: 'yyyy-mm-dd hh:mm:ss'
        });

        $('.endTime').datetimepicker({
            todayHighlight: false,
            autoclose: true,
            sideBySide: false,
            pickerPosition: 'top-right',
            format: 'yyyy-mm-dd hh:mm:ss'
        });
    }

    return {
        init: function () {
            getMachinTeaDataList();
            editMachinTeaItem();
            MachinTeaEditForm();
            addMachinTeaItem();
            delMachinTeaItem();
            getMachinSetData();
            datetimepickerSelect();
        }
    };
}();
jQuery(document).ready(function () {
    $('.status_switch').bootstrapSwitch({
        onText:'自动',
        offText:'手动',
        handleWidth:'60'
    });
    MachinTea.init();
    $('.status_switch').on('switchChange.bootstrapSwitch', function (event,state) {
        if(state==true){
            $(this).parents("div").find(".status_switch_parent").find("[name='status']").val(1)
        }else{
            $(this).parents("div").find(".status_switch_parent").find("[name='status']").val(2)
        }
    });
});