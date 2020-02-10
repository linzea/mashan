var OriginBatch = function () {
    var actionsTemplate = $("#actionsTemplate").html();
    var status = {
        0: {'title': '未生成', 'class': ' m-badge--warning'},
        1: {'title': '已生成', 'class': ' m-badge--success'},
        'export': {0: 'm--hide', 1: 'm--show'},
        'create': {0: 'm--show', 1: 'm--hide'},
        'change': {0: 'm--hide', 1: 'm--show'}
    };
    /**
     * 获取列表数据
     */
    var getOriginBatchDataList = function () {
        var option = {
            data: {
                type: 'remote',
                source: {
                    read: {
                        url: 'getOriginBatchDataList'
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
                {
                    field: "createYear",
                    title: "年份",
                    width: 60,
                    template: function (row) {
                        return row.createYear + '年';
                    }
                },{
                    field: "name_area",
                    title: "茶园",
                    width: 80
                },{
                    field: "pick_batch_no",
                    title: "鲜叶批次",
                    width: 120
                },{
                    field: "product_name",
                    title: "绑定产品",
                    width: 120
                },{
                    field: "batch_num",
                    title: "溯源批次",
                    width: 120
                },{
                    field: "status",
                    title: "编码生成", width: 60,
                    template: function (row) {
                        return '<span class="m-badge ' + status[row.status].class + ' m-badge--wide">' + status[row.status].title + '</span>';
                    }
                }, {
                    field: "codeNum",
                    title: "生成数量",
                    width: 60,
                    template: function (row) {
                        return row.codeNum + '个';
                    }
                }, {
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
                        return actionsTemplate.replace(/#rowId#/g, row.id)
                            .replace(/#dropup#/g, dropup)
                            .replace(/#export#/g, status.export[row.status])
                            .replace(/#change#/g, status.export[row.status])
                            .replace(/#create#/g, status.create[row.status]);
                    }
                }]
        }
        var datatable = $('.origin_batch_list').mDatatable(option);
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
    var OriginBatchEditForm = function () {
        $( "#origin_batch_form" ).validate({
            rules: {
                harvestBatchId: {required: true},
                teaGardenId: {required: true},
                productId: {required: true},
                qualityId: {required: true},
                batchNum: {required: true,alphanumerical:true},
                description: {nameCheck:true,maxlength:200}
            },
            submitHandler: function (form){
                blockUiOpen('.originBatchEditModal .modal-content');
                request(
                    "saveOrUpdateOriginBatch",
                    "post",
                    $("#origin_batch_form").serialize(),
                    function(result){
                        if(result.message){
                            blockUiClose('#origin_batch_form .modal-content',1,".close-parent",0);
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
     * 生成溯源码
     */
    var createCodeForm = function () {
        $("#origin_batch_list").on('click',".createOriginCode",function () {
            var id = $(this).attr("item");
            if(id != ""){
                $(".createOriginCodeModal [name='originBatchId']").val(id);
            }else{
                ToastrMsg("获取批次编码错误！","error","topRight");
            }
        })
        /**
         * 生成溯源码
         */
        $( "#createCodeForm" ).validate({
            rules: {
                prefixVal: {required: true,alphanumerical:true,maxlength:3},
                createNum: {required: true,digits:true,maxlength:3}
            },
            submitHandler: function (form){
                blockUiOpen('#createCodeForm .modal-content');
                request(
                    "createCode",
                    "POST",
                    $("#createCodeForm").serialize(),
                    function(result){
                        if(result.message){
                            ToastrMsg(result.data,"success","topRight",'#origin_batch_form .modal-content',"reload",true);
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#origin_batch_form .modal-content');
                        }
                    }
                )
            }
        });
    }
    /**
     * 选择鲜叶批次
     */
    var changeHarvestBatchId = function () {
        $(".originBatchEditModal ").on("change",".harvestBatchId",function () {
            blockUiOpen('.originBatchEditModal .modal-content');
            var harvestBatchId = $(".harvestBatchId option:selected").val(),
                teaGardenId = $(".harvestBatchId option:selected").attr("teaGardenId"),
                _html = "<option value=\"\"> 产品</option>";
            if (harvestBatchId != "" && teaGardenId != ""){
                request(
                    "getProductData",
                    "POST",
                    {harvestBatchId:harvestBatchId},
                    function(result){
                        if(result.message ){
                            getQualityData(harvestBatchId);
                            $.each(result.data,function (i,n) {
                                _html += "<option value="+n.productId+" proTypeName="+n.proTypeName+"  teaAttrName="+n.teaAttrName+" teaTypeName="+n.teaTypeName+" imgUrl="+n.imgUrl+" > "+n.productName+"</option>";
                            });
                            $(".originBatchEditModal .productId").html(_html);
                            $(".teaGardenId").val(teaGardenId)
                            blockUiClose('.originBatchEditModal .modal-content',0,".close-parent",0);
                        }else{
                            ToastrMsg(result.data,"error","topRight",'.originBatchEditModal .modal-content');
                        }
                    }
                )
            }
        })
        /**
         * 选择产品
         */
        $(".originBatchEditModal ").on("change",".productId",function () {
            $("#proTypeName").val($(".productId option:selected").attr("proTypeName"));
            $("#teaAttrName").val($(".productId option:selected").attr("teaAttrName"));
            $("#teaTypeName").val($(".productId option:selected").attr("teaTypeName"));
            var imgUrl = $(".productId option:selected").attr("imgUrl");
            if (imgUrl != ""){
                $("#imgUrl").attr("src",$(".productId option:selected").attr("imgUrl"));
                $("#imgUrlHref").attr("href",$(".productId option:selected").attr("imgUrl"));
                $("#imgUrlDiv").removeClass("m--hide")
            }
        })
    }
    /**
     * 获取质检数据
     */
    var getQualityData = function (harvestBatchId) {
        var _html = "<option value=\"\"> 质检</option>",macProName = "";

        if (harvestBatchId != ""){
            request(
                "getQualityData",
                "POST",
                {harvestBatchId:harvestBatchId},
                function(result){
                    if(result.message){
                        $.each(result.data,function (i,n) {
                            if (typeof n.macProName !== 'undefined'){
                                macProName = n.macProName;
                            }else{
                                macProName = "随机";
                            }
                            _html += "<option value="+n.qualityId+"> "+n.qualityTypeName+"("+macProName+")</option>";
                        });
                        $(".originBatchEditModal .qualityId").html(_html);
                        blockUiClose('.originBatchEditModal .modal-content',0,".close-parent",0);
                    }else{
                        ToastrMsg("未找到质检完成的记录","error","topRight",'.originBatchEditModal .modal-content');
                    }
                }
            )
        }
    }

    /**
     * 获取所编辑的数据
     */
    var editOriginBatchItem = function () {
        $("#origin_batch_list").on("click", ".editOriginBatchItem", function () {
            removeValue('edit')
            var id = $(this).attr("item");
            if(id != ""){
                request(
                    "editOriginBatchItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            $("#origin_batch_form [name='id']").val(result.data.id)
                            $("#origin_batch_form [name='batchNum']").val(result.data.batchNum)
                            $("#origin_batch_form [name='description']").val(result.data.description)
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
    var delOriginBatchItem = function () {
        $("#origin_batch_list").on("click", ".delOriginBatchItem", function () {
            blockUiOpen('#origin_batch_list');
            var self = $(this);
            var id = self.attr("item");
            if(id != ""){
                request(
                    "delOriginBatchItem",
                    'post',
                    {id:id},
                    function (result) {
                        if(result.message){
                            self.parents("tr").remove();
                            ToastrMsg(result.data,"success","topRight",'#origin_batch_list');
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#origin_batch_list');
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
            $(".originBatchEditModal .modal-title").text("编辑溯源批次")
            $(".originBatchEditModal [name='save']").val('edit')
            $(".reset-btn").addClass("m--hide");
            $(".originBatchEditModal [name='batchNum']").attr("disabled",true)
        }else{
            $(".originBatchEditModal .modal-title").text("新增溯源批次")
            $(".reset-btn").removeClass("m--hide");
            $(".originBatchEditModal [name='save']").val('add');
            $(".originBatchEditModal [name='batchNum']").attr("disabled",false);
        }
        $(".originBatchEditModal [name='id']").val("")
        $(".originBatchEditModal [name='batchNum']").val("")
        $(".originBatchEditModal [name='description']").val("")
        $(".originBatchEditModal [name='teaGardenId']").val("")
        $(".originBatchEditModal [name='productId']").html("<option value=\"\"> 产品</option>")
        $(".originBatchEditModal [name='qualityId']").html("<option value=\"\"> 质检</option>")
        $(".originBatchEditModal [name='description']").val("")
        $("#imgUrlDiv").addClass("m--hide")
        $("#proTypeName").val("");
        $("#teaAttrName").val("");
        $("#teaTypeName").val("");
        $(".originBatchEditModal .form-control-feedback").remove()
        $(".originBatchEditModal div").removeClass("has-danger")
        $(".originBatchEditModal div").removeClass("has-success")
    }

    /**
     * 新增重置表单初始值
     */
    var addOriginBatchItem = function () {
        $(".addOriginBatchItem").on('click',function(){
            removeValue('add')
        })
    }

    /**
     * 获取加工设置数据
     */
    var getMsuData = function () {
        $(".originBatchEditModal .la-hand-o-up").on("click",function () {
            var save = $(".originBatchEditModal [name='save']").val();
            if (save == 'add'){
                request(
                    "getMsuData",
                    'get',
                    {},
                    function (result) {
                        if(result.message){
                            $("#batchNum").val(result.data)
                        }else{
                            ToastrMsg('获取失败,请稍后再试.',"error","topRight",'#modalBloukUi');
                        }
                    })
            }
        })
    }

    var selectYear = function () {
        $('.datetimepicker_selectYear').datetimepicker({
            todayHighlight: false,
            autoclose: true,
            startView: 4,
            minView: 4,
            sideBySide: false,
            clearBtn: true,
            pickerPosition: 'bottom-left',
            format: 'yyyy'
        });
        var date=new Date;
        var year=date.getFullYear();
        $('#createYear').val(year);
    }
    return {
        init: function () {
            getOriginBatchDataList();
            editOriginBatchItem();
            OriginBatchEditForm();
            addOriginBatchItem();
            delOriginBatchItem();
            getMsuData();
            createCodeForm();
            selectYear();
            changeHarvestBatchId();
        }
    };
}();
jQuery(document).ready(function () {
    OriginBatch.init();

});