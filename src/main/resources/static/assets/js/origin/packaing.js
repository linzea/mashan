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
    var getPackaingDataList = function () {
        var option = {
            data: {
                type: 'remote',
                source: {
                    read: {
                        url: 'getPackaingDataList'
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
            },{
                field: "teaGradeThree",
                title: "茶末",
                width: 65,
                template: function (row) {
                    return row.teaGradeThree+"斤";
                }
            },{
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
        var datatable = $('.packaing_list').mDatatable(option);
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
        $('.m_selectpicker,.select_selectpicker').selectpicker();
    };

    /**
     * 新增与编辑表单验证
     * 加工设置
     */
    var packaingEditForm = function () {
        $( "#packaing_edit_form" ).validate({
            rules: {
                priductIdOne: {required: true},
                finishedQuantityOne: {required: true,digits:true,maxlength:7},
                lastQuantityOne: {required: true,digits:true,maxlength:4},
                tagIdOne: { required: true},

                priductIdTwo: {required: true},
                finishedQuantityTwo: {required: true,digits:true,maxlength:7},
                lastQuantityTwo: {required:true,digits:true,maxlength:4},
                tagIdTwo: {required:true},

                priductIdThree: {required: true},
                finishedQuantityThree: {required: true,digits:true,maxlength:7},
                lastQuantityThree: {required: true,digits:true,maxlength:4},
                tagIdThree: {required: true},

                description: {nameCheck:true}
            },
            submitHandler: function (form){
                blockUiOpen('.packaingEditModal .modal-content');
                request(
                    "saveOrUpdatePackaing",
                    "post",
                    $("#packaing_edit_form").serialize(),
                    function(result){

                        if(result.message){
                            ToastrMsg(result.data,"success","topRight",'.packaingEditModal .modal-content',"reload",true);
                            location.reload()
                        }else{
                            ToastrMsg(result.data,"error","topRight",'.packaingEditModal .modal-content');
                        }
                    }
                )
            }
        });
    }
    /**
     * 获取产品和标签
     * @param dicTeaAttr
     * @param dicTeaType
     */
    var createProductAndTagSelect = function (dicTeaAttr,dicTeaType) {
        var taglist='',
            prolistOne='<option value=""> 选择 </option>',
            prolistTwo='<option value=""> 选择 </option>',
            prolistThree='<option value=""> 选择 </option>';
        if(dicTeaAttr != '' && dicTeaType != ''){
            request(
                "selectProductSetOrTagsList",
                'post',
                {dicTeaAttr:dicTeaAttr,dicTeaType:dicTeaType,type:"all"},
                function (result) {
                    if(result.message){
                        $.each(result.data, function (i, n) {
                            if (typeof n.tagName !== 'undefined'){
                                taglist += "<option value="+n.id+" > "+n.tagName+"("+n.tagNumber+"-"+n.principal+")</option>";
                            }else if (typeof n.productName !== 'undefined'){
                                if (n.productType == '80aa9101-7258-4608-9ed6-ad66a28438ea'){
                                    prolistOne += "<option value="+n.id+" speOne="+n.speOneP+" speTwo="+n.speTwoP+" speThere="+n.speThereP+" speFour="+n.speFourP+"> "+n.productName+"("+n.attrName+"-"+n.typeName+")</option>";
                                }else if(n.productType == '140da388-96d7-4a66-82e0-59e061f5d3d8'){
                                    prolistTwo += "<option value="+n.id+" speOne="+n.speOneP+" speTwo="+n.speTwoP+" speThere="+n.speThereP+" speFour="+n.speFourP+"> "+n.productName+"("+n.attrName+"-"+n.typeName+")</option>";
                                }else{
                                    prolistThree += "<option value="+n.id+" speOne="+n.speOneP+" speTwo="+n.speTwoP+" speThere="+n.speThereP+" speFour="+n.speFourP+"> "+n.productName+"("+n.attrName+"-"+n.typeName+")</option>";
                                }
                            }
                        });
                        $(".packaingEditModal #prolistOne").html(prolistOne)
                        $(".packaingEditModal #prolistTwo").html(prolistTwo)
                        $(".packaingEditModal #prolistThree").html(prolistThree)
                        $('.packaingEditModal .m_selectpicker').append(taglist);
                        $('.packaingEditModal .m_selectpicker').selectpicker('refresh');
                    }else{
                        ToastrMsg("产品/包材/标签 信息不完善.","error","topRight",'.packaingEditModal .modal-content');
                    }
                })
        }else{
            ToastrMsg("参数异常,操作失败!","error","topRight");
        }
    }
    /**
     * 获取所编辑的数据
     */
    var editPackaingItem = function () {
        $("#packaing_list").on("click", ".editPackaingItem", function () {
            removeValue('edit')
            var id = $(this).attr("item");
            if(id != ""){
                request(
                    "editPackaingItem",
                    'post',
                    {id:id},
                    function (result) {
                        if(result.message){
                            createProductAndTagSelect(result.data.dicTeaAttr,result.data.dicTeaType)
                            $("#packaing_edit_form [name='machinStatus'][value='"+result.data.machinStatus+"']").click().attr("disabled",true);//单选
                            if (result.data.machinStatus != 1){
                                $("#packaing_edit_form [name='machinStatus']").attr("disabled",true);//单选
                            }
                            $("#packaing_edit_form [name='id']").val(result.data.id)
                            $("#packaing_edit_form [name='dicMacType']").val(result.data.dicMacType).attr("disabled",true);
                            $("#packaing_edit_form [name='dicTeaAttr']").val(result.data.dicTeaAttr).attr("disabled",true);
                            $("#packaing_edit_form [name='assemblySetId']").val(result.data.assembly_set_id).attr("disabled",true);
                            $("#packaing_edit_form [name='dicTeaType']").html("<option>"+result.data.teaTypeName+"</option>").attr("disabled",true);
                            $("#packaing_edit_form [name='machinSetId']").html("<option>"+result.data.macProNameS+"("+result.data.teaAttrNameS+")</option>").attr("disabled",true);
                            $("#packaing_edit_form [name='machinStatus'][value='"+result.data.machinStatus+"']").click()
                            $("#packaing_edit_form [name='beginTime']").val(result.data.begin_time)
                            $("#packaing_edit_form [name='endTime']").val(result.data.end_time)
                            $("#packaing_edit_form [name='temperature']").val(result.data.temperature)
                            $("#packaing_edit_form [name='principal']").val(result.data.principal).attr("disabled",true);
                            $("#packaing_edit_form #createUser").val(result.data.createName).attr("disabled",true);
                            $("#packaing_edit_form [name='humidity']").val(result.data.humidity)
                            $("#packaing_edit_form [name='description']").val(result.data.description)
                            $("#packaing_edit_form [name='dicRollType']").val(result.data.dicRollType).attr("disabled",true);
                            $("#packaing_edit_form [name='status']").val(result.data.status)
                            $("#packaing_edit_form #teaGradeOne").text(result.data.teaGradeOne);
                            $("#packaing_edit_form #teaGradeTwo").text(result.data.teaGradeTwo);
                            if (result.data.teaGradeTwo > 0){
                                $("#teaGradeTwoDiv ").removeClass("m--hide")
                                $("#teaGradeTwoDiv input").attr("disabled",false);
                                $("#teaGradeTwoDiv select").attr("disabled",false);
                            }else{
                                $("#teaGradeTwoDiv ").addClass("m--hide")
                                $("#teaGradeTwoDiv input").attr("disabled",true);
                                $("#teaGradeTwoDiv select").attr("disabled",true);
                            }
                            if (result.data.teaGradeThree > 0){
                                $("#teaGradeThreeDiv").removeClass("m--hide")
                                $("#teaGradeThreeDiv input").attr("disabled",false);
                                $("#teaGradeThreeDiv select").attr("disabled",false);
                            }else{
                                $("#teaGradeThreeDiv ").addClass("m--hide")
                                $("#teaGradeThreeDiv input").attr("disabled",true);
                                $("#teaGradeThreeDiv select").attr("disabled",true);
                            }
                            $("#packaing_edit_form #teaGradeThree").text(result.data.teaGradeThree);
                            $("#packaing_edit_form [name='harvestBatchId']").val(result.data.harvest_batch_id).attr("disabled",true);
                        }else{
                            ToastrMsg(result.data,"error","topRight",'.packaingEditModal .modal-content');
                        }
                    })
            }
        })
    }
    /**
     * 删除单条数据
     */
    var delPackaingItem = function () {
        $("#packaing_list").on("click", ".delPackaingItem", function () {
            blockUiOpen('#packaing_list');
            var self = $(this);
            var id = self.attr("item");
            if(id != ""){
                request(
                    "delPackaingItem",
                    'post',
                    {id:id},
                    function (result) {
                        if(result.message){
                            self.parents("tr").remove();
                            ToastrMsg(result.data,"success","topRight",'#packaing_list');
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#packaing_list');
                        }
                    })
            }
        })
    }
    /**
     * 重置表单
     */
    var removeValue = function(type){
         $('.packaingEditModal .m_selectpicker').empty();
        // $('#pickArea').append("");
        //  $('#pickArea').selectpicker('render');
        if(type == 'edit'){
            $(".packaingEditModal .modal-title").text("成品包装记录")
            $(".packaingEditModal [name='save']").val('edit')
            $(".reset-btn").addClass("m--hide");
            $(".packaingEditModal [name='machinStatus']").attr("disabled",false);//单选-
        }else{
            $(".packaingEditModal .modal-title").text("成品包装记录")
            $(".reset-btn").removeClass("m--hide");
            $(".packaingEditModal [name='save']").val('add');
        }
        $(".packaingEditModal [name='id']").val("")
        $(".packaingEditModal [name='assemblySetId']").val("").attr("disabled",false);
        $(".packaingEditModal [name='dicMacType']").val("").attr("disabled",false);
        $(".packaingEditModal [name='dicTeaAttr']").val("").attr("disabled",false);
        $(".packaingEditModal [name='dicTeaType']").html("<option value=\"\"> 选择 </option>").attr("disabled",false);
        $(".packaingEditModal [name='beginTime']").val("")
        $(".packaingEditModal [name='endTime']").val("")
        $(".packaingEditModal [name='temperature']").val("")
        $(".packaingEditModal [name='principal']").val("").attr("disabled",false);
        $(".packaingEditModal #createUser").val("").attr("disabled",false);
        $(".packaingEditModal [name='humidity']").val("")
        $(".packaingEditModal [name='machinSetId']").html("<option value=\"\"> 选择 </option>").attr("disabled",false);
        $(".packaingEditModal [name='description']").val("")
        $(".packaingEditModal #teaGradeOne").text("0.00");
        $(".packaingEditModal #teaGradeTwo").text("0.00");
        $(".packaingEditModal #teaGradeThree").text("0.00");
        $(".packaingEditModal [name='status']").val(2)
        $(".packaingEditModal [name='harvestBatchId']").val("").attr("disabled",false);
        $('.status_switch').bootstrapSwitch('state',false);
        $(".packaingEditModal .form-control-feedback").remove()
        $(".packaingEditModal div").removeClass("has-danger")
        $(".packaingEditModal div").removeClass("has-success")
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
    /**
     * 选择产品类型，计算包装数量
     */
    var changeProductCalculationData = function () {
        var speOne=0,
            speTwo=0,
            speThere=0,
            speFour=0,
            teaGradeOne = 0,
            teaGradeTwo = 0,
            teaGradeThree = 0;
        /**
         * 成茶
         */
        $("#prolistOne").on('change',function () {
            speOne=$("#prolistOne option:selected").attr("speOne"),
            speTwo=$("#prolistOne option:selected").attr("speTwo"),
            speThere=$("#prolistOne option:selected").attr("speThere"),
            speFour=$("#prolistOne option:selected").attr("speFour"),
            teaGradeOne = Number($("#teaGradeOne").text());
            if (speOne > 0 && speTwo > 0 && speThere > 0 && speFour > 0 && teaGradeOne > 0){
                var itemPack = (speOne*speTwo*speThere*speFour/1000).toFixed(2);
                var allPack  = (teaGradeOne/2/itemPack).toFixed(2).split('.');
                $(".packaingEditModal [name='finishedQuantityOne']").val(allPack[0])
                $(".packaingEditModal [name='lastQuantityOne']").val(allPack[1]*10)
                $("#prolistOneRule").html("<span style=\"color: red\">"+allPack[0]+"=("+teaGradeOne+"÷2÷("+speOne+"g x"+speTwo+"罐/包 x"+speThere+"/盒 x"+speFour+"件/组))</span>")
            }
        })
        /**
         * 副茶
         */
        $("#prolistTwo").on('change',function () {
            speOne=$("#prolistTwo option:selected").attr("speOne"),
            speTwo=$("#prolistTwo option:selected").attr("speTwo"),
            speThere=$("#prolistTwo option:selected").attr("speThere"),
            speFour=$("#prolistTwo option:selected").attr("speFour"),
            teaGradeTwo = Number($("#teaGradeTwo").text());
            if (speOne > 0 && speTwo > 0 && speThere > 0 && speFour > 0 && teaGradeTwo > 0){
                var itemPack = (speOne*speTwo*speThere*speFour/1000).toFixed(2);
                var allPack  = (teaGradeTwo/2/itemPack).toFixed(2).split('.');
                $(".packaingEditModal [name='finishedQuantityTwo']").val(allPack[0])
                $(".packaingEditModal [name='lastQuantityTwo']").val(allPack[1]*10)
                $("#prolistTwoRule").html("<span style=\"color: red\">"+allPack[0]+"=("+teaGradeTwo+"÷2÷("+speOne+"g x"+speTwo+"罐/包 x"+speThere+"/盒 x"+speFour+"件/组))</span>")
            }
        })
        /**
         * 末茶
         */
        $("#prolistThree").on('change',function () {
            speOne=$("#prolistThree option:selected").attr("speOne"),
            speTwo=$("#prolistThree option:selected").attr("speTwo"),
            speThere=$("#prolistThree option:selected").attr("speThere"),
            speFour=$("#prolistThree option:selected").attr("speFour"),
            teaGradeThree = Number($("#teaGradeThree").text());
            if (speOne > 0 && speTwo > 0 && speThere > 0 && speFour > 0 && teaGradeThree > 0){
                var itemPack = (speOne*speTwo*speThere*speFour/1000).toFixed(2);
                var allPack  = (teaGradeThree/2/itemPack).toFixed(2).split('.');
                $(".packaingEditModal [name='finishedQuantityThree']").val(allPack[0])
                $(".packaingEditModal [name='lastQuantityThree']").val(allPack[1])
                $("#prolistThreeRule").html("<span style=\"color: red\">"+allPack[0]+"=("+teaGradeThree+"÷2÷("+speOne+"g x"+speTwo+"罐/包 x"+speThere+"/盒 x"+speFour+"件/组))</span>")
            }
        })
    }


    return {
        init: function () {
            getPackaingDataList();
            editPackaingItem();
            packaingEditForm();
            delPackaingItem();
            datetimepickerSelect();
            changeProductCalculationData();

        }
    };
}();
jQuery(document).ready(function () {
    MachinTea.init();
});