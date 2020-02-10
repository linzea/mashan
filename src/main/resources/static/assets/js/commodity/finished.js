var Finished = function () {
    var actionsTemplate = $("#actionsTemplate").html();
    var finishedListShow = function () {
        var option = {
            data: {
                type: 'remote',
                source: {
                    read: {
                        url: 'getFinishedDataList'
                    }
                },
                pageSize: 10,
                saveState: {
                    cookie: false,
                    webstorage: false
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
                { field: "finishedName", title: "名称", width: 140,overflow: 'hidden' },
                { field: "attrName", title: "茶系", width: 60},
                { field: "typeName", title: "品种", width: 60},
                { field: "typeTeaName", title: "类型", width: 60},
                { field: "speOne", title: "规格", width: 110,
                    template: function (row) {
                        return row.speOneP+'/*'+row.speTwoP+'/*'+row.speThereP+'/*'+row.speFourP+'件';
                    }
                },
                { field: "finishedQuantity", title: "数量", width: 60,
                    template: function (row) {
                        return Number(row.finishedQuantity)+" 份";
                    }
                },
                { field: "finishedOut", title: "出库", width: 60,
                    template: function (row) {
                        return Number(row.finishedOut)+" 份";
                    }
                },
                { title: "剩余", width: 60,
                    template: function (row) {
                        return Number(row.finishedQuantity-row.finishedOut)+" 份";
                    }
                },

                { field: "createUser", title: "记录人", width: 60},
                { field: "createTime", title: "创建时间", sortable: 'asc', width: 130 },
                { field: "Actions", width: 110, title: "操作", sortable: false, overflow: 'visible',
                    template: function (row) {
                        var dropup = (row.getIndex() - row.getIndex()) <= 4 ? 'dropup' : '';
                        return actionsTemplate.replace(/#rowId#/g, row.id)
                    }
                }]
        };
        var datatable = $('.finished_set_list').mDatatable(option);

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
     * productEdit 表单验证
     * 新增与编辑
     */
    var FinishedForm = function () {
        $( "#finished_set_edit_form" ).validate({
            rules: {
                outUser: { required: true},
                principal: { required: true },
                outQuantity: { required: true },
                id: { required: true },
                description: { nameCheck:true },
                qualityReport:{ required: true }
            },
            submitHandler: function (form){
                blockUiOpen('.finishedEditModal .modal-content');
                request(
                    "saveOrUpdateFinishedOut",
                    "post",
                    $("#finished_set_edit_form").serialize(),
                    function(result){
                        if(result.message){
                            ToastrMsg(result.data,"success","topRight",".finishedEditModal .modal-content","reload",true);
                        }else{
                            ToastrMsg(result.data,"error","topRight",".finishedEditModal .modal-content");
                        }
                    }
                )
            }
        });
    }
    /**
     * 获取信息,并移除上一轮错误信息
     */
    var getFinishedItem = function () {
        $("#finished_set_list ").on("click", ".editFinishedItem", function () {
            removeValue('edit')
            var id = $(this).attr("item");
            console.log(id)
            if(id != ""){
                request(
                    "getFinishedItem",
                    'post',
                    {id:id},
                    function (result) {
                        console.log(result)
                        if(result.message){
                            $(".finishedEditModal [name='id']").val(result.data.id)
                            $(".finishedEditModal [name='finishedName']").val(result.data.finishedName).attr("disabled",true)
                            $(".finishedEditModal [name='dicTeaAttr']").val(result.data.dicTeaAttr).attr("disabled",true)
                            $(".finishedEditModal [name='dicTeaType']").val(result.data.dicTeaType).attr("disabled",true)
                            $(".finishedEditModal [name='speFour']").val(result.data.speFourP).attr("disabled",true)
                            $(".finishedEditModal [name='speThere']").val(result.data.speThereP).attr("disabled",true)
                            $(".finishedEditModal [name='speTwo']").val(result.data.speTwoP).attr("disabled",true)
                            $(".finishedEditModal [name='licenceId']").val(result.data.licenceId).attr("disabled",true)
                            $(".finishedEditModal [name='standardId']").val(result.data.standardId).attr("disabled",true)
                            $(".finishedEditModal [name='speOne']").val(result.data.speOneP).attr("disabled",true)
                            $(".finishedEditModal [name='principalF']").val(result.data.principal).attr("disabled",true)
                            $(".finishedEditModal [name='status']").val(result.data.status)
                            $(".finishedEditModal [name='description']").val(result.data.description)
                            $(".finishedEditModal [name='finishedQuantity']").val(Number(result.data.finishedQuantity-result.data.finishedOut)).attr("disabled",true)
                            $(".finishedEditModal [name='outQuantity']").attr("max",Number(result.data.finishedQuantity-result.data.finishedOut))
                            $(".finishedEditModal #createUser").val(result.data.createUser).attr("disabled",true)
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
     * 重置表单
     */
    var removeValue = function (type){
        var createUser = $(".finishedEditModal .createUser").text();
        if(type == 'edit'){
            $(".finishedEditModal .modal-title").text("成品出库")
            $(".finishedEditModal [name='save']").val('edit')
        }else{
            $(".finishedEditModal .modal-title").text("成品出库")
            $(".finishedEditModal [name='save']").val('add');
        }
        $(".finishedEditModal [name='id']").val('')
        $(".finishedEditModal [name='FinishedName']").val("").attr("disabled",false)
        $(".finishedEditModal [name='dicTeaAttr']").val("").attr("disabled",false)
        $(".finishedEditModal [name='dicTeaType']").val("").attr("disabled",false)
        $(".finishedEditModal [name='speFour']").val("").attr("disabled",false)
        $(".finishedEditModal [name='speThere']").val("").attr("disabled",false)
        $(".finishedEditModal [name='speTwo']").val("").attr("disabled",false)
        $(".finishedEditModal [name='licenceId']").val("").attr("disabled",false)
        $(".finishedEditModal [name='standardId']").val("").attr("disabled",false)
        $(".finishedEditModal [name='speOne']").val("").attr("disabled",false)
        $(".finishedEditModal [name='principal']").val("").attr("disabled",false)
        $(".finishedEditModal [name='description']").val("")
        $(".finishedEditModal [name='FinishedQuantity']").val("")
        $(".finishedEditModal [name='FinishedLow']").val("")
        $(".finishedEditModal [name='status']").val(2)
        $(".finishedEditModal #createUser").val(createUser).attr("disabled",true)
        $('.status_switch').bootstrapSwitch('state',false);
        $(".finishedEditModal .form-control-feedback").remove()
        $(".finishedEditModal div").removeClass("has-danger")
        $(".finishedEditModal div").removeClass("has-success")
    }
    /**
     * 出库
     */
    var addFinishedOutUser = function () {
        $(".outUser").on('change',function(){
            var userId = $('.outUser option:selected').attr("userId"),
                storeManager = $('.outUser option:selected').attr("storeManager");
            $("#storePrincipal").html("<option value="+userId+"> "+storeManager+"</option>");
        })
    }
    return {
        init: function () {
            finishedListShow();
            FinishedForm();
            getFinishedItem();
            addFinishedOutUser();
        }
    };
}();



jQuery(document).ready(function () {
    Finished.init();
});