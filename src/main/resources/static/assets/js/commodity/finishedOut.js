var FinishedOut = function () {
    var actionsTemplate = $("#actionsTemplate").html();
    var FinishedOutListShow = function () {
        var option = {
            data: {
                type: 'remote',
                source: {
                    read: {
                        url: 'getFinishedOutDataList'
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
                { field: "finishedName", title: "名称", width: 120,overflow: 'hidden' },
                { field: "attrName", title: "茶系", width: 60},
                { field: "typeName", title: "品种", width: 60},
                { title: "规格", width: 110,
                    template: function (row) {
                        return row.speOneP+'/*'+row.speTwoP+'/*'+row.speThereP+'/*'+row.speFourP+'件';
                    }
                },
                { field: "storeName", title: "取货门店", width: 100},
                { field: "out_quantity", title: "取货数量", width: 60,
                    template: function (row) {
                        return row.out_quantity + "件";
                    }
                },
                { field: "storeManager", title: "取货人", width: 60},
                { field: "createUser", title: "记录人", width: 60},
                { field: "create_time", title: "创建时间", sortable: 'asc', width: 130 },
                { field: "Actions", width: 100, title: "操作", sortable: false, overflow: 'visible',
                    template: function (row) {
                        return actionsTemplate.replace(/#rowId#/g, row.oid).replace(/#oFinishedId#/g, row.oFinishedId);
                    }
                }]
        };
        var datatable = $('.finished_out_list').mDatatable(option);

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
    var FinishedOutForm = function () {
            $(".downloadQuality").on("click", function () {
                $.print("#finished_out");
            })
    }
    /**
     * 获取信息,并移除上一轮错误信息
     */
    var getFinishedOutItem = function () {
        $("#finished_out_list ").on("click", ".editFinishedOutItem", function () {
            removeValue('edit')
            var id = $(this).attr("item");
            if(id != ""){
                request(
                    "getFinishedOutItem",
                    'post',
                    {id:id},
                    function (result) {
                        if(result.message){
                            $("#finished_out #finishedName").text(result.data.finishedName)
                            $("#finished_out #gradeName").text(result.data.gradeName)
                            $("#finished_out #speThereP").text(result.data.speOneP+'/g *'+result.data.speTwoP+'罐/包 *'+result.data.speThereP+'/盒 *'+result.data.speFourP+'件')
                            $("#finished_out #finishedInTime").text(result.data.finishedInTime)
                            $("#finished_out #standardId").text(result.data.standardId)
                            $("#finished_out #licenceId").text(result.data.licenceId)
                            $("#finished_out #storeManager").text(result.data.storeManager)
                            $("#finished_out #out_quantity").text(result.data.out_quantity+" 件")
                            $("#finished_out #create_time").text(result.data.create_time)
                            $("#finished_out #createTime").text(result.data.create_time.substr(0,10))
                            $("#finished_out #createUser").text(result.data.createUser)
                            $("#finished_out #storeManagerT").text(result.data.storeManager)
                            $("#finished_out #storeName").text(result.data.storeName)
                        }else{
                            ToastrMsg(result.data,"error","topRight");
                        }
                    })
            }
        })
    }
    /**
     * 删除产品
     */
    var delFinishedOutItem = function () {
        $("#finished_out_list ").on("click", ".delFinishedOutItem", function () {
            blockUiOpen('#finished_out_list');
            var self = $(this);
            var id = self.attr("item");
            if(id != ""){
                request(
                    "delFinishedOutItem",
                    'post',
                    {id:id},
                    function (result) {
                        if(result.message){
                            self.parents("tr").remove();
                            ToastrMsg(result.data,"success","topRight",'#finished_out_list');
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#finished_out_list');
                        }
                    })
            }
        })
    }
    /**
     * 重置表单
     */
    var removeValue = function (type){

    }
    /**
     * 取消编辑时 重置表单初始值为 add 类型
     */
    var addFinishedOut = function () {
        $(".addFinishedOut").on('click',function(){
            removeValue('add')
        })
    }
    return {
        init: function () {
            FinishedOutListShow();
            FinishedOutForm();
            getFinishedOutItem();
            delFinishedOutItem();
            addFinishedOut();
        }
    };
}();



jQuery(document).ready(function () {
    FinishedOut.init();
    $('.status_switch').bootstrapSwitch();
    $('.status_switch').on('switchChange.bootstrapSwitch', function (event,state) {
        if(state==true){
            $(this).parents("div").find(".status_switch_parent").find("[name='status']").val(1)
        }else{
            $(this).parents("div").find(".status_switch_parent").find("[name='status']").val(2)
        }
    });
});