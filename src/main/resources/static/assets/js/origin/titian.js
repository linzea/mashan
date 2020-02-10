var MachinTea = function () {
    var actionsTemplate = $("#actionsTemplate").html();
    var status = {
        1: {'title': '进行中', 'class': ' m-badge--warning'},
        3: {'title': '终止', 'class': ' m-badge--danger'},
        2: {'title': '完成', 'class': ' m-badge--success'},
        7: {'title': '一次炒干', 'class': ' m-badge--success'},
        9: {'title': '二次炒干', 'class': ' m-badge--success'}
    };
    /**
     * 获取列表数据
     */
    var getTitianDataList = function () {
        var option = {
            data: {
                type: 'remote',
                source: {
                    read: {
                        url: 'getTitianDataList'
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
                field: "assemblyName",
                title: "生产线",
                width: 100
            },{
                field: "pick_batch_no",
                title: "鲜叶批次",
                width: 130
            },{
                field: "teaTypeName",
                title: "品种",
                overflow: 'hide',
                width: 60
            },{
                field: "macTypeName",
                title: "类型",
                width: 60
            },{
                field: "lostTime",
                title: "时长",
                width: 60
            },{
                field: "teaGradeOne",
                title: "成品茶",
                width: 80,
                template: function (row) {
                    return row.teaGradeOne+"斤";
                }
            },{
                field: "teaGradeTwo",
                title: "副茶",
                width: 65,
                template: function (row) {
                    return row.teaGradeTwo+"斤";
                }
            }
            ,{
                field: "teaGradeThree",
                title: "茶末",
                width: 65,
                template: function (row) {
                    return row.teaGradeThree+"斤";
                }
            }
            ,{
                field: "teaAttrName",
                title: "茶系",
                width: 60
            },{
                field: "machinStatus",
                title: "状态",
                width: 60,
                template: function (row) {
                    return '<span class="m-badge ' + status[row.machinStatus].class + ' m-badge--wide">' + status[row.machinStatus].title + '</span>';
                }
            },{ field: "principal", title: "负责人", width: 60},
                {
                field: "create_time",
                title: "创建时间",
                width: 150,
                sortable: 'desc'
            },{
                field: "Actions",
                width: 130,
                title: "操作",
                sortable: false,
                overflow: 'visible',
                template: function (row) {
                    var dropup = (row.getIndex() - row.getIndex()) <= 4 ? 'dropup' : '';
                    return actionsTemplate.replace(/#rowId#/g, row.id);
                }
            }]
        }
        var datatable = $('.titian_list').mDatatable(option);
        var query = datatable.getDataSourceQuery();
        $('#assemblySetId').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.assemblySetId = $(this).val();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(typeof query.assemblySetId !== 'undefined' ? query.assemblySetId : '');

        $('#harvestBatchId').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.harvestBatchId = $(this).val();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(typeof query.harvestBatchId !== 'undefined' ? query.harvestBatchId : '');

        $('#machinStatus').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.machinStatus = $(this).val().toLowerCase();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(typeof query.machinStatus !== 'undefined' ? query.machinStatus : '');

        $('#dicTeaAttr').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.dicTeaAttr = $(this).val();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(typeof query.dicTeaAttr !== 'undefined' ? query.dicTeaAttr : '');
        $('.datatableRoload').on('click', function () {
            location.reload()
        });
        $('.select_selectpicker').selectpicker();
    };

    /**
     * 新增与编辑表单验证
     * 加工设置
     */
    var TitianEditForm = function () {
        $( "#titian_edit_form" ).validate({
            rules: {
                harvestBatchId: {required: true},
                dicMacType: {required: true},
                dicTeaAttr: {required: true},
                machinSetId: { required: true},
                machinStatus: {required: true},
                dicTeaType: {required: true},
                principal: {required:true, nameCheck:true},
                beginTime: {required:true},
                endTime: {required: true},
                temperature: {digits:true,maxlength:3},
                humidity: {digits:true,maxlength:2},
                teaGradeOne: {required: true,decimalCheck:true,maxlength:9},
                teaGradeTwo: {required: true,decimalCheck:true,maxlength:9},
                teaGradeThree: {required: true,decimalCheck:true,maxlength:9},
                assemblySetId: {required: true},
                description: {nameCheck:true}
            },
            submitHandler: function (form){
                blockUiOpen('.titianEditModal .modal-content');
                request(
                    "saveOrUpdateTitian",
                    "post",
                    $("#titian_edit_form").serialize(),
                    function(result){
                        if(result.message){
                            ToastrMsg(result.data,"success","topRight",'.titianEditModal .modal-content',"reload",true);
                        }else{
                            ToastrMsg(result.data,"error","topRight",'.titianEditModal .modal-content');
                        }
                    }
                )
            }
        });
    }
    /**
     * 获取所编辑的数据
     */
    var editTitianItem = function () {
        $("#titian_list").on("click", ".editTitianItem", function () {
            removeValue('edit')
            var id = $(this).attr("item");
            if(id != ""){
                request(
                    "editTitianItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            $("#titian_edit_form [name='machinStatus'][value='"+result.data.machinStatus+"']").click().attr("disabled",true);//单选-初检
                            if (result.data.machinStatus != 1){
                                $("#titian_edit_form [name='machinStatus']").attr("disabled",true);//单选-初检
                            }
                            $("#titian_edit_form [name='id']").val(result.data.id)
                            $("#titian_edit_form [name='dicMacType']").val(result.data.dicMacType).attr("disabled",true);
                            $("#titian_edit_form [name='dicTeaAttr']").val(result.data.dicTeaAttr).attr("disabled",true);
                            $("#titian_edit_form [name='assemblySetId']").val(result.data.assembly_set_id).attr("disabled",true);
                            $("#titian_edit_form [name='dicTeaType']").html("<option>"+result.data.teaTypeName+"</option>").attr("disabled",true);
                            $("#titian_edit_form [name='machinSetId']").html("<option>"+result.data.macProNameS+"("+result.data.teaAttrNameS+")</option>").attr("disabled",true);
                            $("#titian_edit_form [name='beginTime']").val(result.data.begin_time)
                            $("#titian_edit_form [name='endTime']").val(result.data.end_time)
                            $("#titian_edit_form [name='temperature']").val(result.data.temperature)
                            $("#titian_edit_form [name='principal']").val(result.data.principal).attr("disabled",true);
                            $("#titian_edit_form #createUser").val(result.data.createName).attr("disabled",true);
                            $("#titian_edit_form [name='humidity']").val(result.data.humidity)
                            $("#titian_edit_form [name='description']").val(result.data.description)
                            $("#titian_edit_form [name='dicRollType']").val(result.data.dicRollType).attr("disabled",true);
                            $("#titian_edit_form [name='status']").val(result.data.status)
                            $("#titian_edit_form [name='teaGradeOne']").val(result.data.teaGradeOne);
                            $("#titian_edit_form [name='teaGradeTwo']").val(result.data.teaGradeTwo);
                            $("#titian_edit_form [name='teaGradeThree']").val(result.data.teaGradeThree);
                            $("#titian_edit_form [name='harvestBatchId']").val(result.data.harvest_batch_id).attr("disabled",true);
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
    var delTitianItem = function () {
        $("#titian_list").on("click", ".delTitianItem", function () {
            blockUiOpen('#titian_list');
            var self = $(this);
            var id = self.attr("item");
            if(id != ""){
                request(
                    "delTitianItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            self.parents("tr").remove();
                            ToastrMsg(result.data,"success","topRight",'#titian_list');
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#titian_list');
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
            $(".titianEditModal .modal-title").text("编辑提香记录")
            $(".titianEditModal [name='save']").val('edit')
            $(".reset-btn").addClass("m--hide");
            $(".titianEditModal [name='machinStatus']").attr("disabled",false);//单选-
        }else{
            $(".titianEditModal .modal-title").text("新增提香记录")
            $(".reset-btn").removeClass("m--hide");
            $(".titianEditModal [name='save']").val('add');
        }
        $(".titianEditModal [name='id']").val("")
        $(".titianEditModal [name='assemblySetId']").val("").attr("disabled",false);
        $(".titianEditModal [name='dicMacType']").val("").attr("disabled",false);
        $(".titianEditModal [name='dicTeaAttr']").val("").attr("disabled",false);
        $(".titianEditModal [name='dicTeaType']").html("<option value=\"\"> 选择 </option>").attr("disabled",false);
        $(".titianEditModal [name='beginTime']").val("")
        $(".titianEditModal [name='endTime']").val("")
        $(".titianEditModal [name='temperature']").val("")
        $(".titianEditModal [name='principal']").val("").attr("disabled",false);
        $(".titianEditModal #createUser").val("").attr("disabled",false);
        $(".titianEditModal [name='humidity']").val("")
        $(".titianEditModal [name='machinSetId']").html("<option value=\"\"> 选择 </option>").attr("disabled",false);
        $(".titianEditModal [name='description']").val("")
        $(".titianEditModal [name='teaGradeOne']").val("");
        $(".titianEditModal [name='teaGradeTwo']").val("");
        $(".titianEditModal [name='teaGradeThree']").val("");
        $(".titianEditModal [name='status']").val(2)
        $(".titianEditModal [name='harvestBatchId']").val("").attr("disabled",false);
        $('.status_switch').bootstrapSwitch('state',false);
        $(".titianEditModal .form-control-feedback").remove()
        $(".titianEditModal div").removeClass("has-danger")
        $(".titianEditModal div").removeClass("has-success")
    }

    /**
     * 新增重置表单初始值
     */
    var addWitherItem = function () {
        $(".addWitherItem").on('click',function(){
            removeValue('add')
        })
    }

    /**
     * 获取茶系对应的加工设置数据
     */
    var changeDicTeaAttrGetOptionList = function () {
        $(".titianEditModal .dicTeaAttr").on("change",function () {
            var dicTeaAttr = $(".titianEditModal .dicTeaAttr option:selected").val(),
                dicMacPro = $(".titianEditModal #dic_mac_pro").val(),//加工工序
                dicMacType = $(".titianEditModal #dicMacType option:selected").val(),html="<option value=\"\"> 选择 </option>";//加工类型
            if (dicTeaAttr !== ""){
                blockUiOpen('#modalBloukUi');
                request(
                    "getMachinSetDataList",
                    'get',
                    {dicTeaAttr:dicTeaAttr,dicMacPro:dicMacPro,dicMacType:dicMacType},
                    function (result) {
                        if(result.message){
                            $.each(result.data, function (i, n) {
                                html += "<option value="+n.id+" > "+n.macProName+"("+n.teaAttrName+")</option>";
                            });
                            $(".titianEditModal #machinSetId").html(html)
                            blockUiClose('#modalBloukUi',0,".close-parent",0);
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#modalBloukUi');
                        }
                    })
            }
        })
    }

    /**
     * 获取加工设置数据
     */
    var getMachinSetDataInfo = function () {
        $(".titianEditModal .machinSetId").on("change",function () {
            var machinSetId = $(".titianEditModal #machinSetId option:selected").val();//加工步骤
            if (machinSetId !== ""){
                blockUiOpen('#modalBloukUi');
                request(
                    "getMachinSetDataInfo",
                    'get',
                    {machinSetId:machinSetId},
                    function (result) {
                        if(result.message){
                            $("#titian_edit_form [name='beginTime']").val(result.data.beginTime);
                            $("#titian_edit_form [name='endTime']").val(result.data.endTime);
                            $("#titian_edit_form [name='temperature']").val(result.data.temperature);
                            $("#titian_edit_form [name='humidity']").val(result.data.humidity);
                            // $("#titian_edit_form [name='macLoss']").val(result.data.mac_loss)
                            $("#titian_edit_form [name='rollStatus']").val(result.data.roll_status);
                            $("#titian_edit_form [name='description']").val(result.data.description);
                            $("#titian_edit_form [name='dicMacValue']").val(result.data.dicMacValue);
                            blockUiClose('#modalBloukUi',0,".close-parent",0);
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#modalBloukUi');
                        }
                    })
            }
        })
    }
    /**
     * 根据鲜叶批次号获取 鲜叶品种信息
     */
    var getDicTeaType = function () {
        $(".titianEditModal #harvestBatchId").on("change",function () {
            var harvestBatchId = $(".titianEditModal #harvestBatchId option:selected").val(),
                html="<option value=\"\"> 选择 </option>";//加工类型
            if (harvestBatchId !== ""){
                blockUiOpen('#modalBloukUi');
                request(
                    "getHarvestDataInfo",
                    'get',
                    {harvestBatchId:harvestBatchId},
                    function (result) {
                        if(result.message){
                            html += "<option value="+result.data.dicCultivarId+" > "+result.data.dicCultivarName+"</option>";
                            $(".titianEditModal #dicTeaType").html(html)
                            blockUiClose('#modalBloukUi',0,".close-parent",0);
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#modalBloukUi');
                        }
                    })
            }
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
            //getDicTeaType();
            getTitianDataList();
            editTitianItem();
            TitianEditForm();
            //addWitherItem();
            delTitianItem();
            //getMachinSetDataInfo();
            datetimepickerSelect();
            //changeDicTeaAttrGetOptionList();
        }
    };
}();
jQuery(document).ready(function () {
    // $('.status_switch').bootstrapSwitch({
    //     onText:'自动',
    //     offText:'手动',
    //     handleWidth:'60'
    // });
    MachinTea.init();
    // $('.status_switch').on('switchChange.bootstrapSwitch', function (event,state) {
    //     if(state==true){
    //         $(this).parents("div").find(".status_switch_parent").find("[name='status']").val(1)
    //     }else{
    //         $(this).parents("div").find(".status_switch_parent").find("[name='status']").val(2)
    //     }
    // });
});