var Package = function () {
    var actionsTemplate = $("#actionsTemplate").html();
    var packageListShow = function () {
        var option = {
            data: {
                type: 'remote',
                source: {
                    read: {
                        url: 'getPackageDataList'
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
                { field: "packageName", title: "名称", width: 130,overflow: 'hidden' },
                { field: "attrName", title: "茶系", width: 60},
                { field: "typeName", title: "品种", width: 60},
                { field: "speOne", title: "规格", width: 110,
                    template: function (row) {
                        return row.speOne+'/*'+row.speTwo+'/*'+row.speThere+'/*'+row.speFour+'件';
                    }
                },
                { title: "数量", width: 60,
                    template: function (row) {
                        return Number(row.packageQuantity)+" 份";
                    }},
                { field: "packageUse", title: "剩余", width: 60,
                    template: function (row) {
                        return Number(row.packageQuantity-row.packageUse)+" 份";
                    }
                },
                { field: "status", title: "状态", width: 60,
                    template: function (row) {
                        var status = {
                            0: {'title': '未激活', 'class': ' m-badge--warning'},
                            1: {'title': '使用中', 'class': ' m-badge--success'},
                            2: {'title': '停用中', 'class': ' m-badge--danger'},
                        };
                        return '<span class="m-badge ' + status[row.status].class + ' m-badge--wide">' + status[row.status].title + '</span>';
                    }
                },
                { field: "createUser", title: "记录人", width: 60},
                { field: "createTime", title: "创建时间", sortable: 'asc', width: 130 },
                { field: "Actions", width: 100, title: "操作", sortable: false, overflow: 'visible',
                    template: function (row) {
                        var dropup = (row.getIndex() - row.getIndex()) <= 4 ? 'dropup' : '';
                        return actionsTemplate.replace(/#rowId#/g, row.id)
                    }
                }]
        };
        var datatable = $('.package_set_list').mDatatable(option);

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
    var PackageForm = function () {
        $( "#package_set_edit_form" ).validate({
            rules: {
                packageName: { required: true, nameCheck:true },
                dicTeaAttr: { required: true },
                dicTeaType: { required: true },
                teaGrade: { required: true },
                packageId: { required: true },
                packageQuantity:{required: true,number:true},
                tagsId: { required: true },
                speOne: { required: true,number:true },
                speTwo: { required: true,number:true },
                speThere: { required: true,number:true },
                speFour: { required: true,number:true },
                packageLow: { required: true,number:true },
                principal: { required: true },
                status: { required: true },
                imgUrl: { required: true },
                description: { nameCheck:true }
            },
            submitHandler: function (form){
                blockUiOpen('.packageEditModal .modal-content');
                request(
                    "saveOrUpdatePackage",
                    "post",
                    $("#package_set_edit_form").serialize(),
                    function(result){
                        if(result.message){
                            ToastrMsg(result.data,"success","topRight",".packageEditModal .modal-content","reload",true);
                        }else{
                            ToastrMsg(result.data,"error","topRight");
                        }
                    }
                )
            }
        });
    }
    /**
     * 获取信息,并移除上一轮错误信息
     */
    var getPackageItem = function () {
        $("#package_set_list ").on("click", ".editPackageItem", function () {
            removeValue('edit')
            var id = $(this).attr("item");
            if(id != ""){
                request(
                    "getPackageItem",
                    'post',
                    {id:id},
                    function (result) {
                        if(result.message){
                            $("#package_set_edit_form [name='id']").val(result.data.id)
                            $("#package_set_edit_form [name='packageName']").val(result.data.packageName).attr("disabled",true)
                            $("#package_set_edit_form [name='dicTeaAttr']").val(result.data.dicTeaAttr).attr("disabled",true)
                            $("#package_set_edit_form [name='dicTeaType']").val(result.data.dicTeaType).attr("disabled",true)
                            $("#package_set_edit_form [name='speFour']").val(result.data.speFour).attr("disabled",true)
                            $("#package_set_edit_form [name='speThere']").val(result.data.speThere).attr("disabled",true)
                            $("#package_set_edit_form [name='speTwo']").val(result.data.speTwo).attr("disabled",true)
                            $("#package_set_edit_form [name='licenceId']").val(result.data.licenceId).attr("disabled",true)
                            $("#package_set_edit_form [name='standardId']").val(result.data.standardId).attr("disabled",true)
                            $("#package_set_edit_form [name='speOne']").val(result.data.speOne).attr("disabled",true)
                            $("#package_set_edit_form [name='principal']").val(result.data.principal).attr("disabled",true)
                            $("#package_set_edit_form [name='status']").val(result.data.status)
                            $("#package_set_edit_form [name='description']").val(result.data.description)
                            $("#package_set_edit_form [name='packageQuantity']").val(result.data.packageQuantity)
                            $("#package_set_edit_form [name='packageLow']").val(result.data.packageLow)
                            $("#package_set_edit_form #createUser").val(result.data.createUser).attr("disabled",true)
                            if(result.data.status == 1){
                                $('.status_switch').bootstrapSwitch('state',true);
                            }else{
                                $('.status_switch').bootstrapSwitch('state',false);
                            }
                            if (result.data.imgUrl){
                                myDropzone.emit("initimage", result.data.imgUrl); //初始化图片
                                $(".packageEditModal [name='imgUrl']").val(result.data.imgUrl)
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
    var delPackageItem = function () {
        $("#package_set_list ").on("click", ".delPackageItem", function () {
            blockUiOpen('#package_set_list');
            var self = $(this);
            var id = self.attr("item");
            if(id != ""){
                request(
                    "delPackageItem",
                    'post',
                    {id:id},
                    function (result) {
                        if(result.message){
                            self.parents("tr").remove();
                            ToastrMsg(result.data,"success","topRight",'#package_set_list');
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#package_set_list');
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
        var createUser = $("#package_set_edit_form .createUser").text();
        if(type == 'edit'){
            $(".packageEditModal .modal-title").text("包材编辑")
            $(".packageEditModal [name='save']").val('edit')
        }else{
            $(".packageEditModal .modal-title").text("新增包材")
            $(".packageEditModal [name='save']").val('add');
        }
        $(".packageEditModal [name='id']").val('')
        $("#package_set_edit_form [name='packageName']").val("").attr("disabled",false)
        $("#package_set_edit_form [name='dicTeaAttr']").val("").attr("disabled",false)
        $("#package_set_edit_form [name='dicTeaType']").val("").attr("disabled",false)
        $("#package_set_edit_form [name='speFour']").val("").attr("disabled",false)
        $("#package_set_edit_form [name='speThere']").val("").attr("disabled",false)
        $("#package_set_edit_form [name='speTwo']").val("").attr("disabled",false)
        $("#package_set_edit_form [name='licenceId']").val("").attr("disabled",false)
        $("#package_set_edit_form [name='standardId']").val("").attr("disabled",false)
        $("#package_set_edit_form [name='speOne']").val("").attr("disabled",false)
        $("#package_set_edit_form [name='principal']").val("").attr("disabled",false)
        $("#package_set_edit_form [name='description']").val("")
        $("#package_set_edit_form [name='packageQuantity']").val("")
        $("#package_set_edit_form [name='packageLow']").val("")
        $("#package_set_edit_form [name='status']").val(2)
        $("#package_set_edit_form #createUser").val(createUser).attr("disabled",true)
        $('.status_switch').bootstrapSwitch('state',false);
        $(".packageEditModal .form-control-feedback").remove()
        $(".packageEditModal div").removeClass("has-danger")
        $(".packageEditModal div").removeClass("has-success")
    }
    /**
     * 取消编辑时 重置表单初始值为 add 类型
     */
    var addPackage = function () {
        $(".addPackage").on('click',function(){
            removeValue('add')
        })
    }
    return {
        init: function () {
            packageListShow();
            PackageForm();
            getPackageItem();
            delPackageItem();
            addPackage();
        }
    };
}();



jQuery(document).ready(function () {
    Package.init();
    $('.status_switch').bootstrapSwitch();
    $('.status_switch').on('switchChange.bootstrapSwitch', function (event,state) {
        if(state==true){
            $(this).parents("div").find(".status_switch_parent").find("[name='status']").val(1)
        }else{
            $(this).parents("div").find(".status_switch_parent").find("[name='status']").val(2)
        }
    });
});