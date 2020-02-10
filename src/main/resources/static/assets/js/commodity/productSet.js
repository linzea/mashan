var productSet = function () {
    var actionsTemplate = $("#actionsTemplate").html();
    var productSetListShow = function () {
        var option = {
            data: {
                type: 'remote',
                source: {
                    read: {
                        url: 'getProductSetDataList'
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
                { field: "productName", title: "名称", width: 150,overflow: 'hidden' },
                { field: "attrName", title: "茶系", width: 60},
                { field: "typeName", title: "品种", width: 60},
                { field: "gradeName", title: "等级", width: 50},
                { field: "packageName", title: "使用包材", width: 130},
                { field: "speOne", title: "包材规格", width: 110,
                    template: function (row) {
                        return row.speOneP+'/*'+row.speTwoP+'/*'+row.speThereP+'/*'+row.speFourP+'件';
                    }
                },
                { field: "packageQuantity", title: "包材数量", width: 60,
                    template: function (row) {
                        return row.packageQuantity +" 份";
                    }
                },
                { title: "包材剩余", width: 60,
                    template: function (row) {
                        return Number(row.packageQuantity-row.packageUse)+" 份";
                    }
                },
                { field: "status", title: "状态", width: 60,
                    template: function (row) {
                        var status = {
                            0: {'title': '未知', 'class': ' m-badge--warning'},
                            1: {'title': '使用中', 'class': ' m-badge--success'},
                            2: {'title': '停用中', 'class': ' m-badge--danger'},
                        };
                        return '<span class="m-badge ' + status[row.status].class + ' m-badge--wide">' + status[row.status].title + '</span>';
                    }
                },

                { field: "createTime", title: "创建时间", sortable: 'asc', width: 140 },
                { field: "Actions", width: 100, title: "操作", sortable: false, overflow: 'visible',
                    template: function (row) {
                        var dropup = (row.getIndex() - row.getIndex()) <= 4 ? 'dropup' : '';
                        return actionsTemplate.replace(/#rowId#/g, row.id)
                    }
                }]
        };
        var datatable = $('.product_set_list').mDatatable(option);

        var query = datatable.getDataSourceQuery();

        $('#m_form_search').on('keyup', function (e) {
            var query = datatable.getDataSourceQuery();
            query.generalSearch = $(this).val().toLowerCase();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(query.generalSearch);

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
    var productSetForm = function () {
        $( "#product_set_edit_form" ).validate({
            rules: {
                productName: { required: true, nameCheck:true },
                dicTeaAttr: { required: true },
                dicTeaType: { required: true },
                teaGrade: { required: true },
                productType: { required: true },
                packageId: { required: true },
                tagsId: { required: true },
                principal: { required: true },
                status: { required: true },
                licenceId:{required: true},
                standardId:{required: true},
                imgUrl: { required: true },
                description: { nameCheck:true }
            },
            submitHandler: function (form){
                blockUiOpen('.productSetEditModal .modal-content');
                request(
                    "saveOrUpdateProductSet",
                    "post",
                    $("#product_set_edit_form").serialize(),
                    function(result){
                        if(result.message){
                            ToastrMsg(result.data,"success","topRight",".productSetEditModal .modal-content","reload",true);
                        }else{
                            ToastrMsg(result.data,"error","topRight",'.productSetEditModal .modal-content');
                        }
                    }
                )
            }
        });
    }
    /**
     * 获取信息,并移除上一轮错误信息
     */
    var getProductSetItem = function () {
        $("#product_set_list ").on("click", ".editProductSetItem", function () {
            removeValue('edit')
            var id = $(this).attr("item");
            if(id != ""){
                request(
                    "getProductSetItem",
                    'post',
                    {id:id},
                    function (result) {
                        if(result.message){
                            $("#product_set_edit_form [name='id']").val(result.data.id)
                            $("#product_set_edit_form [name='productName']").val(result.data.productName).attr("disabled",true)
                            $("#product_set_edit_form [name='dicTeaAttr']").val(result.data.dicTeaAttr).attr("disabled",true)
                            $("#product_set_edit_form [name='dicTeaType']").val(result.data.dicTeaType).attr("disabled",true)
                            $("#product_set_edit_form [name='teaGrade']").val(result.data.teaGrade).attr("disabled",true)
                            $("#product_set_edit_form [name='packageId']").val(result.data.packageId).attr("disabled",true)
                            $("#product_set_edit_form [name='tagsId']").val(result.data.tagsId).attr("disabled",true)
                            $("#product_set_edit_form [name='licenceId']").val(result.data.licenceId).attr("disabled",true)
                            $("#product_set_edit_form [name='standardId']").val(result.data.standardId).attr("disabled",true)
                            $("#product_set_edit_form [name='speOne']").val(result.data.speOne)
                            $("#product_set_edit_form [name='principal']").val(result.data.principal).attr("disabled",true)
                            $("#product_set_edit_form [name='status']").val(result.data.status)
                            $("#product_set_edit_form [name='descriptin']").val(result.data.descriptin)
                            $("#product_set_edit_form [name='productType']").val(result.data.productType).attr("disabled",true)
                            $("#product_set_edit_form #createUser").val(result.data.createUser).attr("disabled",true)
                            if(result.data.status == 1){
                                $('.status_switch').bootstrapSwitch('state',true);
                            }else{
                                $('.status_switch').bootstrapSwitch('state',false);
                            }
                            if (result.data.imgUrl){
                                myDropzone.emit("initimage", result.data.imgUrl); //初始化图片
                                $(".equipmentEditModal [name='imgUrl']").val(result.data.imgUrl)
                            }
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
    var delProductSetItem = function () {
        $("#product_set_list ").on("click", ".delProductSetItem", function () {
            blockUiOpen('#product_set_list');
            var self = $(this);
            var id = self.attr("item");
            if(id != ""){
                request(
                    "delProductSetItem",
                    'post',
                    {id:id},
                    function (result) {
                        if(result.message){
                            self.parents("tr").remove();
                            ToastrMsg(result.data,"success","topRight",'#product_set_list');
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#product_set_list');
                        }
                    })
            }
        })
    }
    /**
     * 重置表单
     */
    var removeValue = function (type){
        myDropzone.removeAllFiles(true);
        var createUser = $(".productSetEditModal .createUser").text();
        if(type == 'edit'){
            $(".productSetEditModal .modal-title").text("产品编辑")
            $(".productSetEditModal [name='save']").val('edit')
        }else{
            $(".productSetEditModal .modal-title").text("产品新增")
            $(".productSetEditModal [name='save']").val('add');
        }
        $(".productSetEditModal [name='id']").val('')
        $(".productSetEditModal [name='productName']").val("").attr("disabled",false)
        $(".productSetEditModal [name='dicTeaAttr']").val("").attr("disabled",false)
        $(".productSetEditModal [name='dicTeaType']").val("").attr("disabled",false)
        $(".productSetEditModal [name='teaGrade']").val("").attr("disabled",false)
        $(".productSetEditModal [name='packageId']").val("").attr("disabled",false)
        $(".productSetEditModal [name='tagsId']").val("").attr("disabled",false)
        $(".productSetEditModal [name='licenceId']").val("").attr("disabled",false)
        $(".productSetEditModal [name='standardId']").val("").attr("disabled",false)
        $(".productSetEditModal [name='speOne']").val("")
        $(".productSetEditModal [name='principal']").val("").attr("disabled",false)
        $(".productSetEditModal [name='status']").val(2)
        $("#product_set_edit_form [name='productType']").val("").attr("disabled",false)
        $(".productSetEditModal #createUser").val(createUser).attr("disabled",true)
        $(".productSetEditModal [name='descriptin']").val('');
        $('.status_switch').bootstrapSwitch('state',false);
        $(".productSetEditModal .form-control-feedback").remove()
        $(".productSetEditModal div").removeClass("has-danger")
        $(".productSetEditModal div").removeClass("has-success")
    }
    /**
     * 取消编辑时 重置表单初始值为 add 类型
     */
    var addproductSet = function () {
        $(".addProductSet").on('click',function(){
            removeValue('add')
        })
    }
    return {
        init: function () {
            productSetListShow();
            productSetForm();
            getProductSetItem();
            delProductSetItem();
            addproductSet();
        }
    };
}();



jQuery(document).ready(function () {
    productSet.init();
    $('.status_switch').bootstrapSwitch();
    $('.status_switch').on('switchChange.bootstrapSwitch', function (event,state) {
        if(state==true){
            $(this).parents("div").find(".status_switch_parent").find("[name='status']").val(1)
        }else{
            $(this).parents("div").find(".status_switch_parent").find("[name='status']").val(2)
        }
    });
});