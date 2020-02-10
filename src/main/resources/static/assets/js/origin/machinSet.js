var MachinSet = function () {
    var actionsTemplate = $("#actionsTemplate").html();
    var status = {
        1: {'title': '启用', 'class': ' m-badge--success'},
        0: {'title': '未知', 'class': ' m-badge--warning'},
        2: {'title': '禁用', 'class': ' m-badge--danger'},
        'durationType':{1:"分",2:"时",3:"天"}
    };
    /**
     * 获取列表数据
     */
    var getMachinSetDataList = function () {
        var option = {
            data: {
                type: 'remote',
                source: {
                    read: {
                        url: 'getMachinSetDataList'
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
                { title: "#", width: 40,
                    template: function (row) {
                        return row.rowIndex+1;
                    }
                },
                { field: "macTypeName", title: "类型", width: 60 },
                { field: "teaAttrName", title: "茶系", width: 60 },
                { field: "macProName", title: "工序", width: 60 },
                { field: "rollTypeName", title: "揉捻级别", width: 100,
                    template: function (row) {
                        return row.rollTypeName != null ? row.rollTypeName : "无";
                    }
                },
                { field: "rollStatus", title: "顺序", width: 100,
                    template: function (row) {
                        return "第"+row.rollStatus+"道工序";
                    }
                },
                { field: "durationType", title: "时长", width: 100,
                        template: function (row) {
                        return row.beginDuration +"-"+row.endDuration+"("+status['durationType'][row.durationType]+")";
                    }
                },//if (result.data.dicMacPro == "01b33909-73b8-45d9-af2e-5f57a22895c1")
                { field: "temperature", title: "温度", width: 60,
                    template: function (row) {
                        return (row.dicMacPro == "01b33909-73b8-45d9-af2e-5f57a22895c1" ? "0" : row.temperature)+" &#8451;";
                    }
                },
                { field: "humidity", title: "湿度", width: 60,
                    template: function (row) {
                        return (row.dicMacPro == "01b33909-73b8-45d9-af2e-5f57a22895c1" ? "0" : row.humidity)+" %RH";
                    }
                },
                { field: "status", title: "状态", width: 60,
                    template: function (row) {
                        return '<span class="m-badge ' + status[row.status].class + ' m-badge--wide">' + status[row.status].title + '</span>';
                    }
                },
                { field: "create_time", title: "创建时间", width: 150, sortable: 'desc' },
                { field: "Actions", width: 130,  title: "操作", sortable: false, overflow: 'visible',
                    template: function (row) {
                        var dropup = (row.getIndex() - row.getIndex()) <= 4 ? 'dropup' : '';
                        return actionsTemplate.replace(/#rowId#/g, row.id)
                            .replace(/#dropup#/g, dropup)
                            .replace(/#dicMacPro#/g, row.dicMacPro)
                            .replace(/#dicTeaAttr#/g, row.dicTeaAttr);
                    }
                }
                ]
        }
        var datatable = $('.machin_set_list').mDatatable(option);
        var query = datatable.getDataSourceQuery();
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
    var machinSetEditForm = function () {
        $( "#machin_set_edit_form" ).validate({
            rules: {
                dicMacType: {required: true},
                dicTeaAttr: {required: true},
                dicMacPro: { required: true},
                durationType: {required: true},
                beginDuration: {digits:true,maxlength:2},
                endDuration: {required: true,digits:true,maxlength:2},
                temperature: {digits:true,maxlength:3},
                humidity: {digits:true,maxlength:2},
                description: {nameCheck:true}
            },
            submitHandler: function (form){
                blockUiOpen('.machinSetEdit .modal-content');
                request(
                    "saveOrUpdateMachinSet",
                    "post",
                    $("#machin_set_edit_form").serialize(),
                    function(result){
                        if(result.message){
                            ToastrMsg(result.data,"success","topRight",'.machinSetEditModal .modal-content',"reload",true);
                        }else{
                            ToastrMsg(result.data,"error","topRight",'.machinSetEditModal .modal-content');
                        }
                    }
                )
            }
        });
    }
    /**
     * 获取所编辑的数据
     */
    var editMachinSetItem = function () {
        $("#machin_set_list").on("click", ".editMachinSetItem", function () {
            removeValue('edit')
            var id = $(this).attr("item");
            if(id != ""){
                request(
                    "editMachinSetItem",
                    'get',
                    {id:id},
                    function (result) {
                        console.log(result)
                        if(result.message){
                            $(".machinSetEditModal [name='id']").val(result.data.id)
                            $(".machinSetEditModal [name='dicMacType']").val(result.data.dicMacType).attr("disabled",true);
                            $(".machinSetEditModal [name='dicTeaAttr']").val(result.data.dicTeaAttr).attr("disabled",true);
                            $(".machinSetEditModal [name='dicMacPro']").val(result.data.dicMacPro).attr("disabled",true);
                            $(".machinSetEditModal [name='durationType'][value='"+result.data.durationType+"']").click()
                            $(".machinSetEditModal [name='beginDuration']").val(result.data.beginDuration).attr("disabled",true);
                            $(".machinSetEditModal [name='durationType']").attr("disabled",true);
                            $(".machinSetEditModal [name='endDuration']").val(result.data.endDuration).attr("disabled",true);
                            $(".machinSetEditModal [name='temperature']").val(result.data.temperature).attr("disabled",true);
                            $(".machinSetEditModal [name='humidity']").val(result.data.humidity).attr("disabled",true);
                            $(".machinSetEditModal [name='dicRollType']").val(result.data.dicRollType).attr("disabled",true);
                            $(".machinSetEditModal [name='rollStatus']").val(result.data.rollStatus).attr("disabled",true);
                            if (result.data.dicMacPro == "01b33909-73b8-45d9-af2e-5f57a22895c1"){
                                $(".machinSetEditModal .quality").addClass("m--show").removeClass("m--hide")
                                $(".machinSetEditModal .temperature").addClass("m--hide").removeClass("m--show")
                                $(".machinSetEditModal .temperature input").attr("disabled",true);
                                $(".machinSetEditModal .quality input").attr("disabled",false);
                            }else{
                                $(".machinSetEditModal .quality").addClass("m--hide").removeClass("m--show")
                                $(".machinSetEditModal .temperature").addClass("m--show").removeClass("m--hide")
                                $(".machinSetEditModal .temperature input").attr("disabled",false);
                                $(".machinSetEditModal .quality input").attr("disabled",true);
                            }
                            $(".machinSetEditModal [name='description']").val(result.data.description)
                            $(".machinSetEditModal [name='status']").val(result.data.status)
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
    var delMachinSetItem = function () {
        $("#machin_set_list").on("click", ".delMachinSetItem", function () {
            blockUiOpen('#machin_set_list');
            var self = $(this);
            var id = self.attr("item");
            if(id != ""){
                request(
                    "delMachinSetItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            self.parents("tr").remove();
                            ToastrMsg(result.data,"success","topRight",'#machin_set_list');
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#machin_set_list');
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
            $(".machinSetEditModal .modal-title").text("编辑工序")
            $(".machinSetEditModal [name='save']").val('edit')
            $(".reset-btn").addClass("m--hide");
        }else{
            $(".machinSetEditModal .modal-title").text("新增工序")
            $(".machinSetEditModal [name='save']").val('add');
            $(".reset-btn").removeClass("m--hide");
        }
        $(".machinSetEditModal [name='id']").val("").attr("disabled",false);
        $(".machinSetEditModal [name='dicMacType']").val("").attr("disabled",false);
        $(".machinSetEditModal [name='durationType']").attr("disabled",false);
        $(".machinSetEditModal [name='dicTeaAttr']").val("").attr("disabled",false);
        $(".machinSetEditModal [name='dicMacPro']").val("").attr("disabled",false);
        $(".machinSetEditModal [name='beginDuration']").val("").attr("disabled",false);
        $(".machinSetEditModal [name='endDuration']").val("").attr("disabled",false);
        $(".machinSetEditModal [name='temperature']").val("").attr("disabled",false);
        $(".machinSetEditModal [name='humidity']").val("").attr("disabled",false);
        $(".machinSetEditModal [name='description']").val("")
        $(".machinSetEditModal [name='status']").val(2)
        $(".machinSetEditModal [name='rollStatus']").val("").attr("disabled",false);
        $('.status_switch').bootstrapSwitch('state',false);
        $(".machinSetEditModal .form-control-feedback").remove()
        $(".machinSetEditModal div").removeClass("has-danger")
        $(".machinSetEditModal div").removeClass("has-success")
    }

    /**
     * 新增重置表单初始值
     */
    var addMachinSetItem = function () {
        $(".addMachinSetItem").on('click',function(){
            removeValue('add')
        })
        /**
         * 揉捻工序时，切换输入框
         */
        $(".machinSetEditModal .dicMacPro").on("change",function () {
            var dicMacPro = $(this).val();
            if (dicMacPro == "8aa97837-a152-49be-98b8-47a11c3b1de4"){
                $("#dicRollType").addClass("m--show").removeClass("m--hide")
            }else{
                $("#dicRollType").addClass("m--hide").removeClass("m--show")
            }
            /**
             * 抽检工序时，切换输入框
             */
            if (dicMacPro == "01b33909-73b8-45d9-af2e-5f57a22895c1"){
                $(".machinSetEditModal .quality").addClass("m--show").removeClass("m--hide")
                $(".machinSetEditModal .temperature").addClass("m--hide").removeClass("m--show")
                $(".machinSetEditModal .temperature input").attr("disabled",true);
                $(".machinSetEditModal .quality input").attr("disabled",false);
            }else{
                $(".machinSetEditModal .quality").addClass("m--hide").removeClass("m--show")
                $(".machinSetEditModal .temperature").addClass("m--show").removeClass("m--hide")
                $(".machinSetEditModal .temperature input").attr("disabled",false);
                $(".machinSetEditModal .quality input").attr("disabled",true);
            }
        })
    }

    /**
     * bootstrap datetimepicker 插件
     * 输入时间请先了解单个参数
     */
    var datetimepickerSelect = function () {
        $('.datetimepicker_select').datetimepicker({
            todayHighlight: false,
            autoclose: true,
            startView: 4,
            minView: 4,
            sideBySide: false,
            pickerPosition: 'bottom-left',
            format: 'yyyy'
        });

        $('.begin_time').datetimepicker({
            todayHighlight: false,
            autoclose: true,
            sideBySide: false,
            pickerPosition: 'top-left',
            format: 'yyyy-mm-dd hh:mm:ss'
        });
    }

    return {
        init: function () {
            getMachinSetDataList();
            editMachinSetItem();
            machinSetEditForm();
            addMachinSetItem();
            delMachinSetItem();
        }
    };
}();
jQuery(document).ready(function () {
    $('.status_switch').bootstrapSwitch({
        onText:'开启',
        offText:'关闭',
        handleWidth:'60'
    });
    MachinSet.init();
    $('.status_switch').on('switchChange.bootstrapSwitch', function (event,state) {
        if(state==true){
            $(this).parents("div").find(".status_switch_parent").find("[name='status']").val(1)
        }else{
            $(this).parents("div").find(".status_switch_parent").find("[name='status']").val(2)
        }
    });
});