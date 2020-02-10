var SemiFinished = function () {
    var actionsTemplate = $("#actionsTemplate").html();
    var status = {
        '红茶': {'title': '出库/复烤'},
        '绿茶': {'title': '出库/复炒'},

    };
    /**
     * 获取列表数据
     */
    var getSemiFinishedDataList = function () {
        var option = {
            data: {
                type: 'remote',
                source: {
                    read: {
                        url: 'getSemiFinishedDataList'
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
            columns: [{ field: "pickBatchNo", title: "鲜叶批次", width: 120 },
                { field: "teaAttrName", title: "茶系", width: 40 },
                { field: "teaTypeName", title: "品种", width: 70 },
                { field: "recQuantity", title: "茶青", width: 80,
                    template: function (row) {
                        return row.recQuantity+'  斤';
                    }
                },
                { field: "teaGradeOne", title: "成茶", width: 80,
                    template: function (row) {
                        return row.teaGradeOne+'  斤';
                    }
                },
                { field: "semiOneOut", title: "成茶出库", width: 80,
                    template: function (row) {
                        return row.semiOneOut+'  斤';
                    }
                },
                { title: "成茶剩余", width: 80,
                    template: function (row) {
                        return '<span class="m-badge m-badge--success m-badge--wide">' + Number(row.teaGradeOne-row.semiOneOut) + '斤</span>';
                    }
                },
                { field: "teaGradeTwo", title: "副茶", width: 80,
                    template: function (row) {
                        return row.teaGradeTwo+'  斤';
                    }
                },
                { field: "semiTwoOut", title: "副茶出库", width: 80,
                    template: function (row) {
                        return row.semiTwoOut+'  斤';
                    }
                },
                { field: "semiFinished",title: "副茶剩余", width: 80,
                    template: function (row) {
                        console.log(Number(row.teaGradeTwo-row.semiTwoOut))
                        return '<span class="m-badge m-badge--success m-badge--wide">' + Number(row.teaGradeTwo-row.semiTwoOut) + '斤</span>';
                    }
                },
                { field: "teaGradeThree", title: "茶末", width: 50,
                    template: function (row) {
                        return row.teaGradeThree+'  斤';
                    }
                },
                { field: "semiThreeOut", title: "茶末出库", width: 50,
                    template: function (row) {
                        return row.semiThreeOut+'  斤';
                    }
                },
                { field: "harvestBatchId",title: "茶末剩余", width: 60,
                    template: function (row) {
                        return '<span class="m-badge m-badge--success m-badge--wide">' + Number(row.teaGradeThree-row.semiThreeOut) + '斤</span>';
                    }
                },
                { field: "createUser", title: "记录人", width: 50 },
                { field: "principal", title: "负责人", width: 50 },
                { field: "Actions", width: 120, title: "操作", sortable: false, overflow: 'visible',
                template: function (row) {
                    return actionsTemplate.replace(/#rowId#/g, row.id).replace(/#title#/g, status[row.teaAttrName].title);
                }
            }]
        }
        var datatable = $('.semi_in_list').mDatatable(option);
        var query = datatable.getDataSourceQuery();
        $('#m_form_search').on('keyup', function (e) {
            var query = datatable.getDataSourceQuery();
            query.generalSearch = $(this).val().toLowerCase();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(query.generalSearch);

        $('#harvestBatchId').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.harvestBatchId = $(this).val();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(typeof query.harvestBatchId !== 'undefined' ? query.harvestBatchId : '');
        $('#dicTeaAttr').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.dicTeaAttr = $(this).val();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(typeof query.dicTeaAttr !== 'undefined' ? query.dicTeaAttr : '');
        $('#dicTeaType').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.dicTeaType = $(this).val();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(typeof query.dicTeaType !== 'undefined' ? query.dicTeaType : '');

        $('.datatableRoload').on('click', function () {
            location.reload()
        });
        $('.select_selectpicker').selectpicker();
    };


    /**
     * 新增与编辑表单验证
     * 加工设置
     */
    var semiFinishedEditForm = function () {
        $( "#semi_in_edit_form" ).validate({
            rules: {
                unitName: {required: true},
                unitNo: {required: true},
                unitUsage: {required: true},
                unitType: { required: true},
                unitCycle: {required: true,digits:true,maxlength:2},
                unitClear: {required: true,digits:true,maxlength:2},
                description: {nameCheck:true},
                pickArea: {required: true}
            },
            submitHandler: function (form){
                blockUiOpen('.semiFinishedEditModal .modal-content');
                request(
                    "saveOrUpdateSemiFinished",
                    "post",
                    $("#semi_in_edit_form").serialize(),
                    function(result){
                        if(result.message){
                            ToastrMsg(result.data,"success","topRight",".semiFinishedEditModal .modal-content","reload",true);
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
    var editSemiFinishedItem = function () {
        $("#semi_in_list").on("click", ".editSemiFinishedItem", function () {
            removeValue('edit')
            var id = $(this).attr("item");
            if(id != ""){
                request(
                    "editSemiFinishedItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            $(".semiFinishedEditModal [name='id']").val(result.data.id)
                            $(".semiFinishedEditModal [name='unitName']").val(result.data.unitName).attr("disabled",true)
                            $(".semiFinishedEditModal [name='unitUsage']").val(result.data.unitUsage).attr("disabled",true)
                            $(".semiFinishedEditModal [name='unitType']").val(result.data.unitType).attr("disabled",true)
                            $(".semiFinishedEditModal [name='unitNo']").val(result.data.unitNo).attr("disabled",true)
                            $(".semiFinishedEditModal #createUser").val(result.data.createUser)
                            $(".semiFinishedEditModal [name='unitCycle']").val(result.data.unitCycle)
                            $(".semiFinishedEditModal [name='unitClear']").val(result.data.unitClear)
                            $(".semiFinishedEditModal [name='description']").val(result.data.description);
                            $(".semiFinishedEditModal [name='status']").val(result.data.status)
                            if(result.data.status == 1){
                                $('.status_switch').bootstrapSwitch('state',true);
                            }else{
                                $('.status_switch').bootstrapSwitch('state',false);
                            }
                            if (result.data.imgUrl){
                                myDropzone.emit("initimage", result.data.imgUrl); //初始化图片
                                $(".semiFinishedEditModal [name='imgUrl']").val(result.data.imgUrl)
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
    var delSemiFinishedItem = function () {
        $("#semi_in_list").on("click", ".delSemiFinishedItem", function () {
            blockUiOpen('#semi_in_list');
            var self = $(this);
            var id = self.attr("item");
            if(id != ""){
                request(
                    "delSemiFinishedItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            self.parents("tr").remove();
                            ToastrMsg(result.data,"success","topRight",'#semi_in_list');
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#semi_in_list');
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
            $(".semiFinishedEditModal .modal-title").text("编辑设备")
            $(".semiFinishedEditModal [name='save']").val('edit')
            $(".reset-btn").addClass("m--hide");
        }else{
            $(".semiFinishedEditModal .modal-title").text("新增设备")
            $(".semiFinishedEditModal [name='save']").val('add');
            $(".reset-btn").removeClass("m--hide");
        }
        $(".semiFinishedEditModal [name='id']").val("")
        $(".semiFinishedEditModal [name='unitName']").val("").attr("disabled",false)
        $(".semiFinishedEditModal [name='unitUsage']").val("").attr("disabled",false)
        $(".semiFinishedEditModal [name='unitType']").val("").attr("disabled",false)
        $(".semiFinishedEditModal [name='unitNo']").val("").attr("disabled",false)
        $(".semiFinishedEditModal [name='unitCycle']").val("").attr("disabled",false)
        $(".semiFinishedEditModal [name='status']").val(2)
        $(".semiFinishedEditModal [name='description']").val("")
        $(".semiFinishedEditModal [name='unitClear']").val("")
        $(".semiFinishedEditModal #createUser").val(createUser)
        $(".semiFinishedEditModal .form-control-feedback").remove()
        $('.status_switch').bootstrapSwitch('state',false);

        $(".semiFinishedEditModal div").removeClass("has-danger")
        $(".semiFinishedEditModal div").removeClass("has-success")
    }


    /**
     * 半成品出库在加工
     */
    var semiFinishedOut = function () {
        $("#semi_in_list").on("click", ".semiFinishedOut", function () {
            blockUiOpen('#semi_in_list');
            var self = $(this);
            var id = self.val();
            if(id != ""){
                request(
                    "semiFinishedOut",
                    'post',
                    {id:id},
                    function (result) {
                        if(result.message){
                            ToastrMsg(result.data,"success","topRight",'#semi_in_list');
                            location.reload()
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#semi_in_list');
                        }
                    })
            }
        })
    }
    /**
     * 新增重置表单初始值
     */
    var addSemiFinishedItem = function () {
        $(".addSemiFinishedItem").on('click',function(){
            removeValue('add')
        })
    }

    return {
        init: function () {
            getSemiFinishedDataList();
            //editSemiFinishedItem();
            semiFinishedEditForm();
            //addSemiFinishedItem();
            //delSemiFinishedItem();
            semiFinishedOut();
        }
    };
}();
jQuery(document).ready(function () {
    SemiFinished.init();
});