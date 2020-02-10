var maintain = function () {
    var actionsTemplate = $("#actionsTemplate").html();
    var status = {
        0: {'title': '检修中', 'class': ' m-badge--warning'},
        2: {'title': '完成', 'class': ' m-badge--success'},
        1: {'title': '检修中', 'class': ' m-badge--warning'}
    };
    /**
     * 获取列表数据
     */
    var getmaintainDataList = function () {
        var option = {
            data: {
                type: 'remote',
                source: {
                    read: {
                        url: 'getMaintainDataList'
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
                { field: "assemblyName", title: "生产线", width: 100 },
                { field: "dicMaintainTypeName", title: "类型", width: 100 },
                { field: "unitName", title: "设备名称", width: 100 },
                { field: "unitNo", title: "资产编号", width: 60 },
                { field: "unitType", title: "设备型号", width: 60 },
                { field: "unitCycle", title: "维护周期", width: 60 },
                { field: "unitClear", title: "清洁周期", width: 60 },
                { field: "runNum", title: "运行次数", width: 60 },
                { field: "maintainStatus", title: "检修状态", width: 60,
                    template: function (row) {
                        return '<span class="m-badge ' + status[row.maintainStatus].class + ' m-badge--wide">' + status[row.maintainStatus].title + '</span>';
                    }
                },
                { field: "createName", title: "记录人", width: 60
            },{ field: "Actions", width: 100, title: "操作", sortable: false, overflow: 'visible',
                template: function (row) {
                    var dropup = (row.getIndex() - row.getIndex()) <= 4 ? 'dropup' : '';
                    return actionsTemplate.replace(/#rowId#/g, row.id);
                }
            }]
        }
        var datatable = $('.maintain_list').mDatatable(option);
        var query = datatable.getDataSourceQuery();
        $('#parentId').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.parentId = $(this).val();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(typeof query.parentId !== 'undefined' ? query.parentId : '');
        $('#maintainType').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.maintainType = $(this).val();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(typeof query.maintainType !== 'undefined' ? query.maintainType : '');
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
    var maintainEditForm = function () {
        $( "#maintainEdit_edit_form" ).validate({
            rules: {
                parentId: {required: true},
                equipmentId: {required: true},
                maintainType: {required: true},
                description: {nameCheck:true}
            },
            submitHandler: function (form){
                blockUiOpen('.maintainEditModal .modal-content');
                request(
                    "saveOrUpdateMaintain",
                    "post",
                    $("#maintainEdit_edit_form").serialize(),
                    function(result){
                        if(result.message){
                            ToastrMsg(result.data,"success","topRight",'.maintainEditModal .modal-content',"reload",true);
                        }else{
                            ToastrMsg(result.data,"error","topRight",'.maintainEditModal .modal-content');
                        }
                    }
                )
            }
        });
    }
    /**
     * 获取所编辑的数据
     */
    var editMaintainItem = function () {
        $("#maintain_list").on("click", ".editMaintainItem", function () {
            removeValue('edit')
            var id = $(this).attr("item");
            if(id != ""){
                request(
                    "editMaintainItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            $(".maintainEditModal [name='id']").val(result.data.id)
                            $(".maintainEditModal [name='parentId']").val(result.data.sid).attr("disabled",true)
                            $(".maintainEditModal [name='equipmentId']").html("<option>"+result.data.unitName+"</option>").attr("disabled",true)
                            $(".maintainEditModal [name='maintainType']").val(result.data.maintainType).attr("disabled",true)
                            $(".maintainEditModal [name='description']").val(result.data.description)
                            $(".maintainEditModal [name='repairContent']").val(result.data.repairContent).attr("disabled",true)
                            $(".maintainEditModal [name='replaceParts']").val(result.data.replaceParts).attr("disabled",true)
                            $(".maintainEditModal [name='operator']").val(result.data.operator).attr("disabled",true)
                            $(".maintainEditModal #createUser").val(result.data.createName)
                            $(".maintainEditModal #unitNo").val(result.data.unitNo)
                            $(".maintainEditModal #unitCycle").val(result.data.unitCycle)
                            $(".maintainEditModal #unitClear").val(result.data.unitClear);
                            $(".maintainEditModal [name='maintainStatus'][value="+result.data.maintainStatus+"]").click()
                            if (result.data.imgUrl){
                                myDropzone.emit("initimage", result.data.imgUrl); //初始化图片
                                $(".maintainEditModal [name='imgUrl']").val(result.data.imgUrl)
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
    var delmaintainItem = function () {
        $("#maintain_list").on("click", ".delmaintainItem", function () {
            blockUiOpen('#maintain_list');
            var self = $(this);
            var id = self.attr("item");
            if(id != ""){
                request(
                    "delmaintainItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            self.parents("tr").remove();
                            ToastrMsg(result.data,"success","topRight",'#maintain_list');
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#maintain_list');
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
        if(type == 'edit'){
            $(".maintainEditModal .modal-title").text("编辑记录")
            $(".maintainEditModal [name='save']").val('edit')
            $(".reset-btn").addClass("m--hide");
        }else{
            $(".maintainEditModal .modal-title").text("新增记录")
            $(".maintainEditModal [name='save']").val('add');
            $(".reset-btn").removeClass("m--hide");
        }
        $(".maintainEditModal [name='parentId']").val("").attr("disabled",false)
        $(".maintainEditModal [name='equipmentId']").html("<option>选择</option>").attr("disabled",false)
        $(".maintainEditModal [name='maintainType']").val("").attr("disabled",false)
        $(".maintainEditModal [name='id']").val("")
        $(".maintainEditModal #unitNo").val("").attr("disabled",true)
        $(".maintainEditModal #unitCycle").val("").attr("disabled",true)
        $(".maintainEditModal [name='maintainStatus']").val(2)
        $(".maintainEditModal [name='description']").val("")
        $(".maintainEditModal [name='repairContent']").val("").attr("disabled",false)
        $(".maintainEditModal [name='replaceParts']").val("").attr("disabled",false)
        $(".maintainEditModal [name='operator']").val("").attr("disabled",false)
        $(".maintainEditModal #unitClear").val("")
        $(".maintainEditModal #createUser").val(createUser)
        $(".maintainEditModal .form-control-feedback").remove()
        $('.status_switch').bootstrapSwitch('state',false);
        $(".maintainEditModal div").removeClass("has-danger")
        $(".maintainEditModal div").removeClass("has-success")
        myDropzone.removeAllFiles(true);
    }

    /**
     * 新增重置表单初始值
     */
    var addmaintainItem = function () {
        $(".addMaintainItem").on('click',function(){
            removeValue('add')
        })
    }

    var parentIdChinage = function () {
        $(".maintainEditModal #equipmentId").on("click",function () {
            console.log($(this).attr("unitClear"))
        })

        $(".maintainEditModal #parentId").on("change",function () {
            var assemblySetId = $(this).val(),html = "";
            blockUiOpen('.maintainEditModal .modal-content');
            request(
                "getAssemblySetEquipmentList",
                'get',
                {assemblySetId:assemblySetId},
                function (result) {
                    if(result.message){
                        console.log(result)
                        if (result.data.length > 0){
                            $.each(result.data, function (i, n) {
                                if (n.id !== assemblySetId) {
                                    if (html == ""){
                                        $(".maintainEditModal #unitNo").val(n.unitNo);
                                        $(".maintainEditModal #unitCycle").val(n.unitCycle);
                                        $(".maintainEditModal #unitClear").val(n.unitClear);
                                    }
                                    html += "<option value="+n.unitId+" unitClear="+n.unitClear+" unitCycle="+n.unitCycle+" unitNo="+n.unitNo+"> "+n.unitName+" </option>";
                                }
                            });
                        }
                        $(".maintainEditModal #equipmentId").html(html);
                        blockUiClose('.maintainEditModal .modal-content',0,".close-parent",0);
                    }else{
                        $("#pickNumber").html('');
                        ToastrMsg(result.data,"error","topRight",'.maintainEditModal .modal-content');
                    }
                })
        })
    }

    return {
        init: function () {
            parentIdChinage();
            getmaintainDataList();
            editMaintainItem();
            maintainEditForm();
            addmaintainItem();
            delmaintainItem();
        }
    };
}();
jQuery(document).ready(function () {
    maintain.init();
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