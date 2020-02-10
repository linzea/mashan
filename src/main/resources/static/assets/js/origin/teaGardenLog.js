var TeaGardenManage = function () {
    var farmType = $("#farmType").val();
    var actionsTemplate = $("#actionsTemplate").html();
    var status = {
        2: {'title': '已完成', 'class': ' m-badge--success'},
        1: {'title': '进行中', 'class': ' m-badge--warning'}
    };
    var columns = {
        '43512930-9822-48b4-b577-e900c4a12504':[{ field: "createYear", title: "年份", width: 60 }, { field: "farmName", title: "农事", width: 60 },
            { field: "operator_id", title: "实施人", width: 60 }, { field: "fert_variety", title: "开垦编号", width: 60 }, { field: "farm_quantity", title: "开垦面积", width: 60 },
            { field: "status", title: "进度", width: 60, template: function (row) { return '<span class="m-badge ' + status[row.status].class + ' m-badge--wide">' + status[row.status].title + '</span>';}},
            { field: "principal", title: "负责人", width: 60 },{ field: "create_time", title: "创建时间", sortable: 'asc', width: 150 }, { field: "createName", title: "创建人", width: 60 },
            { field: "Actions", width: 100, title: "操作", sortable: false, overflow: 'visible', template: function (row) { return actionsTemplate.replace(/#rowId#/g, row.id);}}],
        '4b2946d6-ec92-403f-ae59-6a2d6311e6cd':[{ field: "createYear", title: "年份", width: 60 },
            { field: "teaGardenName", title: "茶园", width: 80 }, { field: "farmName", title: "农事", width: 60 }, { field: "operator_id", title: "实施人", width: 60 }, { field: "fert_variety", title: "耕地沟宽", width: 60 }, { field: "farm_quantity", title: "耕地面积", width: 60 },
            { field: "status", title: "进度", width: 60, template: function (row) { return '<span class="m-badge ' + status[row.status].class + ' m-badge--wide">' + status[row.status].title + '</span>';}},
            { field: "principal", title: "负责人", width: 60 },{ field: "create_time", title: "创建时间", sortable: 'asc', width: 150 }, { field: "createName", title: "创建人", width: 60 },
            { field: "Actions", width: 100, title: "操作", sortable: false, overflow: 'visible', template: function (row) { return actionsTemplate.replace(/#rowId#/g, row.id);}}],
        '1689fac5-4b03-4d4b-94c1-d1bbbe8d06ee':[{ field: "createYear", title: "年份", width: 60 }, { field: "teaGardenName", title: "茶园", width: 80 }, { field: "farmName", title: "农事", width: 60 },
            { field: "operator_id", title: "实施人", width: 60 }, { field: "d4Name", title: "种子来源", width: 100 }, { field: "d3Name", title: "种植品种", width: 60 }, { field: "farm_quantity", title: "种植数量", width: 80,sortable: false,
                template: function (row) {
                    return row.farm_quantity +'(株)';
                }
            },
            { field: "status", title: "进度", width: 60, template: function (row) { return '<span class="m-badge ' + status[row.status].class + ' m-badge--wide">' + status[row.status].title + '</span>';}},
            { field: "principal", title: "负责人", width: 60 },{ field: "create_time", title: "创建时间", sortable: 'asc', width: 150 }, { field: "createName", title: "创建人", width: 60 },
            { field: "Actions", width: 100, title: "操作", sortable: false, overflow: 'visible', template: function (row) { return actionsTemplate.replace(/#rowId#/g, row.id);}}],
        'd687763c-2a2e-41a7-b57d-71e9caebf579':[{ field: "createYear", title: "年份", width: 60 }, { field: "teaGardenName", title: "茶园", width: 80 }, { field: "farmName", title: "农事", width: 60 },
            { field: "operator_id", title: "实施人", width: 60 }, { field: "d4Name", title: "肥料品种", width: 100 }, { field: "d2Name", title: "施肥方式", width: 60 }, { field: "farm_quantity", title: "施肥数量", width: 80,sortable: false,
                template: function (row) {
                    return row.farm_quantity > 0 ? row.farm_quantity+'斤' : '无';
                }
            },
            { field: "status", title: "进度", width: 60, template: function (row) { return '<span class="m-badge ' + status[row.status].class + ' m-badge--wide">' + status[row.status].title + '</span>';}},
            { field: "principal", title: "负责人", width: 60 },{ field: "create_time", title: "创建时间", sortable: 'asc', width: 150 }, { field: "createName", title: "创建人", width: 60 },
            { field: "Actions", width: 100, title: "操作", sortable: false, overflow: 'visible', template: function (row) { return actionsTemplate.replace(/#rowId#/g, row.id);}}],
        'd5bbd9b5-91c4-48c2-b5f8-0c7328f8902f':[{ field: "createYear", title: "年份", width: 60 }, { field: "teaGardenName", title: "茶园", width: 80 }, { field: "farmName", title: "农事", width: 60 },
            { field: "operator_id", title: "实施人", width: 60 }, { field: "d2Name", title: "除草方式", width: 60 }, { field: "farm_quantity", title: "除草药剂", width: 80,sortable: false,
                template: function (row) {
                    return row.farm_quantity > 0 ? row.farm_quantity+'毫升' : '无';
                }
            },
            { field: "status", title: "进度", width: 60, template: function (row) { return '<span class="m-badge ' + status[row.status].class + ' m-badge--wide">' + status[row.status].title + '</span>';}},
            { field: "principal", title: "负责人", width: 60 },{ field: "create_time", title: "创建时间", sortable: 'asc', width: 150 }, { field: "createName", title: "创建人", width: 60 },
            { field: "Actions", width: 100, title: "操作", sortable: false, overflow: 'visible', template: function (row) { return actionsTemplate.replace(/#rowId#/g, row.id);}}],
        'e1f3e464-31c2-46b5-8e20-20d7ea12fb3f':[{ field: "createYear", title: "年份", width: 60 }, { field: "teaGardenName", title: "茶园", width: 80 }, { field: "farmName", title: "农事", width: 60 },
            { field: "operator_id", title: "实施人", width: 60 }, { field: "d2Name", title: "治虫方式", width: 60 }, { field: "fert_variety", title: "防治对象", width: 60 }, { field: "farm_quantity", title: "治虫药剂", width: 80,sortable: false,
                template: function (row) {
                    return row.farm_quantity > 0 ? row.farm_quantity+'毫升' : '无';
                }
            },
            { field: "status", title: "进度", width: 60, template: function (row) { return '<span class="m-badge ' + status[row.status].class + ' m-badge--wide">' + status[row.status].title + '</span>';}},
            { field: "principal", title: "负责人", width: 60 },{ field: "create_time", title: "创建时间", sortable: 'asc', width: 150 }, { field: "createName", title: "创建人", width: 60 },
            { field: "Actions", width: 100, title: "操作", sortable: false, overflow: 'visible', template: function (row) { return actionsTemplate.replace(/#rowId#/g, row.id);}}],
        '5fe37095-7d9a-4235-914f-cf0c6f1e592a':[{ field: "createYear", title: "年份", width: 60 }, { field: "teaGardenName", title: "茶园", width: 80 }, { field: "farmName", title: "农事", width: 60 },
            { field: "operator_id", title: "实施人", width: 60 }, { field: "d2Name", title: "灌溉方式", width: 60 },{ field: "farm_quantity", title: "用量", width: 60 },
            { field: "status", title: "进度", width: 60, template: function (row) { return '<span class="m-badge ' + status[row.status].class + ' m-badge--wide">' + status[row.status].title + '</span>';}},
            { field: "principal", title: "负责人", width: 60 },{ field: "create_time", title: "创建时间", sortable: 'asc', width: 150 }, { field: "createName", title: "创建人", width: 60 },
            { field: "Actions", width: 100, title: "操作", sortable: false, overflow: 'visible', template: function (row) { return actionsTemplate.replace(/#rowId#/g, row.id);}}]
    }
    //禁用茶园筛选项
    if (farmType == '43512930-9822-48b4-b577-e900c4a12504'){
        $("#gardenType").attr("disabled",true);
    }
    var teaGardenManageShow = function () {
        var option = {
            data: {
                type: 'remote',
                source: {
                    read: {
                        url: 'getTeaGardenLogList'
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
            columns: columns[farmType]
        }
        var datatable = $('.tea_garden_manage_ajax').mDatatable(option);
        var query = datatable.getDataSourceQuery();
        query.farmType = farmType;
        datatable.setDataSourceQuery(query);
        datatable.load(); //load 2次才能显示正常

        $('#m_form_search').on('keyup', function (e) {
            var query = datatable.getDataSourceQuery();
            query.generalSearch = $(this).val().toLowerCase();
            datatable.setDataSourceQuery(query);
            datatable.load();
            datatable.load();
        }).val(query.generalSearch);

        $('#createYear').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.createYear = $(this).val().toLowerCase();
            datatable.setDataSourceQuery(query);
            datatable.load();
            datatable.load();
        }).val(typeof query.createYear !== 'undefined' ? query.createYear : '');

        $('#gardenType').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.gardenType = $(this).val();
            datatable.setDataSourceQuery(query);
            datatable.load();
            datatable.load();
        }).val(typeof query.gardenType !== 'undefined' ? query.gardenType : '');
        $('.datatableRoload').on('click', function () {
            location.reload()
        });
        $('.select_selectpicker').selectpicker();
    };


    /**
     * 新增与编辑表单验证
     * 茶园日志
     */
    var teaGardenManageForm = function () {
        $( "#tea_garden_log_form" ).validate({
            rules: {
                teaGardenId: { required: true },
                farmTypeId: { required: true },
                cultivarId: { required: true },
                fertVariety: { required: true },
                operatorId: { required: true, nameCheck:true },
                farmTime: { required: true },
                farmQuantity:{ required: true },
                farmPattern:{ required: true },
                batchNum:{ required: true },
                principal:{ required:true,nameCheck:true}
            },
            submitHandler: function (form){
                blockUiOpen('.teaGardenLogEdit .modal-content');
                request(
                    "saveTeaGardenLog",
                    "post",
                    $("#tea_garden_log_form").serialize(),
                    function(result){
                        if(result.message){
                            ToastrMsg(result.data,"success","topRight",'.teaGardenLogEdit .modal-content',"reload",true);
                        }else{
                            ToastrMsg(result.data,"error","topRight",'.teaGardenLogEdit .modal-content');
                        }
                    }
                )
            }
        });
    }
    /**
     * 获取日志信息,并移除上一轮错误信息
     */
    var editTeaGardenLogItem = function () {
        $("#tea_garden_manage_list").on("click", ".editTeaGardenLogItem", function () {
            removeValue('edit')
            var id = $(this).attr("item");
            if(id != ""){
                request(
                    "getTeaGardenLogItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            if (result.data.status == 2){
                                $(".teaGardenLogEdit [name='status'][value='"+result.data.status+"']").click();
                                $(".teaGardenLogEdit [name='status']").click().attr("disabled",true);
                            }else{
                                $(".teaGardenLogEdit [name='status']").attr("disabled",false);
                                $(".teaGardenLogEdit [name='status'][value='"+result.data.status+"']").click().attr("disabled",true);
                            }
                            $(".teaGardenLogEdit [name='id']").val(result.data.id);
                            $(".teaGardenLogEdit [name='teaGardenId']").val(result.data.teaGardenId).attr("disabled",true);
                            $(".teaGardenLogEdit #batchNum").html("<option> "+result.data.batchNumber+"</option>").attr("disabled",true);
                            $(".teaGardenLogEdit [name='farmTypeId']").val(result.data.farmTypeId).attr("disabled",true);
                            $(".teaGardenLogEdit [name='operatorId']").val(result.data.operatorId).attr("disabled",true);
                            $(".teaGardenLogEdit [name='farmTime']").val(result.data.farmTime).attr("disabled",true);
                            $(".teaGardenLogEdit [name='description']").val(result.data.description);
                            $(".teaGardenLogEdit [name='farmQuantity']").val(result.data.farmQuantity).attr("disabled",true);
                            $(".teaGardenLogEdit [name='fertVariety']").val(result.data.fertVariety).attr("disabled",true);
                            $(".teaGardenLogEdit [name='farmPattern']").val(result.data.farmPattern).attr("disabled",true);
                            $(".teaGardenLogEdit #acreage").val(result.data.acreage);
                            $(".teaGardenLogEdit #area_code").val(result.data.area_code);
                            $(".teaGardenLogEdit [name='principal']").val(result.data.tGlprincipal).attr("disabled",true);
                            $(".teaGardenLogEdit [name='cultivarId']").val(result.data.cultivarId);
                            $(".teaGardenLogEdit [name='fertVariety']").val(result.data.fertVariety);
                        }else{
                            ToastrMsg(result.data,"error","topRight");
                        }
                    })
            }
        })
    }
    /**
     * 获取管理批次
     */
    var getTeaGardenBatch = function(){
        $("#teaGardenId").on("change",function () {
            var teaGardenId = $(".teaGardenLogEdit .teaGardenId").val(),html = "";
            blockUiOpen('.teaGardenLogEdit .modal-content');
            request(
                "getTeaGardenBatch",
                'get',
                {teaGardenId:teaGardenId},
                function (result) {
                    if(result.message){
                        if (result.data.length > 0){
                            $.each(result.data, function (i, n) {
                                html += "<option value="+n.id+" > "+n.batch_number+" </option>";
                            });
                        }
                        $(".teaGardenLogEdit #acreage").val(result.data[0].acreage)
                        $(".teaGardenLogEdit #area_code").val(result.data[0].area_code)
                        $(".teaGardenLogEdit #principal").val(result.data[0].principal)
                        $(".teaGardenLogEdit #batchNum").html(html);
                        blockUiClose('.teaGardenLogEdit .modal-content',0,".close-parent",0);
                    }else{
                        $("#batchNum").html('');
                        ToastrMsg(result.data,"error","topRight",'.teaGardenLogEdit .modal-content');
                    }
                })
        })
    }

    /**
     * 删除
     */
    var delTeaGardenItem = function () {
        $("#tea_garden_manage_list ").on("click", ".delTeaGardenLogItem", function () {
            blockUiOpen('#tea_garden_list');
            var self = $(this);
            var id = self.attr("item");
            if(id != ""){
                request(
                    "delTeaGardenLogItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            self.parents("tr").remove();
                            ToastrMsg(result.data,"success","topRight",'#tea_garden_list');
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#tea_garden_list');
                        }
                    })
            }
        })
    }

    /**
     * 重置表单disabled
     */
    var removeValue = function(type){
        var farmType = $("#farmType").val();
        if(type == 'edit'){
            $(".teaGardenLogEdit .modal-title").text("编辑记录")
            $(".teaGardenLogEdit [name='save']").val('edit')
            $("#teaGardenId").attr("disabled",true);
            $("#cultivarId").attr("disabled",true);
            $(".reset-btn").addClass("m--hide");
        }else{
            $(".teaGardenLogEdit .modal-title").text("新增记录")
            $(".teaGardenLogEdit [name='status']").attr("disabled",false);
            $(".teaGardenLogEdit [name='status'][value='1']").click();
            $(".teaGardenLogEdit [name='status'][value='2']").attr("disabled",true)
            $(".teaGardenLogEdit [name='save']").val('add');
            $(".reset-btn").removeClass("m--hide");
        }
        $(".teaGardenLogEdit [name='id']").val("")
        $(".teaGardenLogEdit [name='teaGardenId']").val("").attr("disabled",false);
        $(".teaGardenLogEdit [name='farmTypeId']").val(farmType).attr("disabled",false);
        $(".teaGardenLogEdit [name='operatorId']").val("").attr("disabled",false);
        $(".teaGardenLogEdit [name='beginTime']").val("")
        $(".teaGardenLogEdit [name='batchNum']").html("<option value='' > 选择 </option>").attr("disabled",false);
        $(".teaGardenLogEdit [name='farmTime']").val("").attr("disabled",false);
        $(".teaGardenLogEdit [name='description']").val("")
        $(".teaGardenLogEdit [name='farmQuantity']").val("").attr("disabled",false);
        $(".teaGardenLogEdit [name='fertVariety']").val("").attr("disabled",false);
        $(".teaGardenLogEdit [name='principal']").val("").attr("disabled",false);
        $(".teaGardenLogEdit .form-control-feedback").remove()
        $(".teaGardenLogEdit div").removeClass("has-danger")
        $(".teaGardenLogEdit div").removeClass("has-success")
    }

    /**
     * 取消编辑时 重置表单初始值为 add 类型
     */
    var addTeaGardenLog = function () {
        $(".addTeaGardenLog").on('click',function(){
            removeValue('add')
        })
    }

    var datetimepickerSelect = function () {
        $('.datetimepicker_select').datetimepicker({
            todayHighlight: false,
            autoclose: true,
            startView: 4,
            minView: 4,
            sideBySide: false,
            clearBtn: true,
            pickerPosition: 'bottom-left',
            format: 'yyyy'
        });

        $('.farm_time').datetimepicker({
            todayHighlight: true,
            autoclose: true,
            sideBySide: false,
            pickerPosition: 'bottom-left',
            clearBtn: true,
            format: 'yyyy-mm-dd hh:mm:ss'
        });
    }

    return {
        init: function () {
            editTeaGardenLogItem();
            teaGardenManageShow();
            teaGardenManageForm();
            datetimepickerSelect();
            delTeaGardenItem();
            addTeaGardenLog();
            getTeaGardenBatch();
        }
    };
}();



jQuery(document).ready(function () {
    TeaGardenManage.init();
});