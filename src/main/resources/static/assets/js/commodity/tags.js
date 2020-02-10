var tags = function () {
    var actionsTemplate = $("#actionsTemplate").html();
    var tagsListShow = function () {
        var option = {
            data: {
                type: 'remote',
                source: {
                    read: {
                        url: 'getTagsDataList'
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
                { field: "tagName", title: "名称", width: 90,overflow: 'hidden' },
                { field: "attrName", title: "茶系", width: 60},
                { field: "typeName", title: "品种", width: 60},
                { field: "tagNumber", title: "编号", width: 110 },
                { field: "tagQuantity", title: "数量", width: 60},
                { field: "tagUse", title: "剩余", width: 60,
                    template: function (row) {
                        return Number(row.tagQuantity-row.tagUse);
                    }
                },
                { field: "status", title: "状态", width: 60,
                    template: function (row) {
                        var status = {
                            0: {'title': '未激活', 'class': ' m-badge--warning'},
                            1: {'title': '使用中', 'class': ' m-badge--success'},
                            2: {'title': '禁用中', 'class': ' m-badge--danger'},
                        };
                        return '<span class="m-badge ' + status[row.status].class + ' m-badge--wide">' + status[row.status].title + '</span>';
                    }
                },
                { field: "principal", title: "負責人", width: 60},
                { field: "createUser", title: "记录人", width: 60},
                { field: "createTime", title: "创建时间", sortable: 'asc', width: 150 },
                { field: "Actions", width: 100, title: "操作", sortable: false, overflow: 'visible',
                    template: function (row) {
                        var dropup = (row.getIndex() - row.getIndex()) <= 4 ? 'dropup' : '';
                        return actionsTemplate.replace(/#rowId#/g, row.id)
                    }
                }]
        };
        var datatable = $('.tags_set_list').mDatatable(option);

        var query = datatable.getDataSourceQuery();

        $('#m_form_search').on('keyup', function (e) {
            var query = datatable.getDataSourceQuery();
            query.generalSearch = $(this).val().toLowerCase();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(query.generalSearch);
        //茶系
        $('#dicTeaAttr').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.dicTeaAttr = $(this).val();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(typeof query.dicTeaAttr !== 'undefined' ? query.dicTeaAttr : '');
        //品种
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
    var tagsForm = function () {
        $( "#tags_set_edit_form" ).validate({
            rules: {
                tagName: { required: true, nameCheck:true },
                dicTeaAttr: { required: true },
                dicTeaType: { required: true },
                tagQuantity: { required: true },
                tagNumber: { required: true },
                tagLow: { required: true },
                principal: { required: true },
                status: { required: true },
                //imgUrl: { required: true },
                description: { nameCheck:true }
            },
            submitHandler: function (form){
                blockUiOpen('.tagsEditModal .modal-content');
                request(
                    "saveOrUpdateTags",
                    "post",
                    $("#tags_set_edit_form").serialize(),
                    function(result){
                        if(result.message){
                            ToastrMsg(result.data,"success","topRight",".tagsEditModal .modal-content","reload",true);
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
    var getTagsItem = function () {
        $("#tags_set_list ").on("click", ".editTagsItem", function () {
            removeValue('edit')
            var id = $(this).attr("item");
            if(id != ""){
                request(
                    "getTagsItem",
                    'post',
                    {id:id},
                    function (result) {
                        console.log(result)
                        if(result.message){
                            $("#tags_set_edit_form [name='id']").val(result.data.id)
                            $("#tags_set_edit_form [name='tagName']").val(result.data.tagName).attr("disabled",true)
                            $("#tags_set_edit_form [name='dicTeaAttr']").val(result.data.dicTeaAttr).attr("disabled",true)
                            $("#tags_set_edit_form [name='dicTeaType']").val(result.data.dicTeaType).attr("disabled",true)
                            $("#tags_set_edit_form [name='tagQuantity']").val(result.data.tagQuantity).attr("disabled",true)
                            $("#tags_set_edit_form [name='tagLow']").val(result.data.tagLow).attr("disabled",true)
                            $("#tags_set_edit_form [name='tagNumber']").val(result.data.tagNumber).attr("disabled",true)
                            $("#tags_set_edit_form [name='principal']").val(result.data.principal).attr("disabled",true)
                            $("#tags_set_edit_form [name='status']").val(result.data.status)
                            $("#tags_set_edit_form [name='description']").val(result.data.description)
                            $("#tags_set_edit_form #createUser").val(result.data.createUser).attr("disabled",true)
                            if(result.data.status == 1){
                                $('.status_switch').bootstrapSwitch('state',true);
                            }else{
                                $('.status_switch').bootstrapSwitch('state',false);
                            }
                            if (result.data.imgUrl){
                                myDropzone.emit("initimage", result.data.imgUrl); //初始化图片
                                $(".tagsEditModal [name='imgUrl']").val(result.data.imgUrl)
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
    var delTagsItem = function () {
        $("#tags_set_list ").on("click", ".delTagsItem", function () {
            blockUiOpen('#tags_set_list');
            var self = $(this);
            var id = self.attr("item");
            if(id != ""){
                request(
                    "delTagsItem",
                    'post',
                    {id:id},
                    function (result) {
                        if(result.message){
                            self.parents("tr").remove();
                            ToastrMsg(result.data,"success","topRight",'#tags_set_list');
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#tags_set_list');
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
        var createUser = $("#tags_set_edit_form .createUser").text();
        if(type == 'edit'){
            $(".tagsEditModal .modal-title").text("标签编辑")
            $(".tagsEditModal [name='save']").val('edit')
        }else{
            $(".tagsEditModal .modal-title").text("新增标签")
            $(".tagsEditModal [name='save']").val('add');
        }
        $(".tagsEditModal [name='id']").val('')
        $("#tags_set_edit_form [name='tagsName']").val("").attr("disabled",false)
        $("#tags_set_edit_form [name='dicTeaAttr']").val("").attr("disabled",false)
        $("#tags_set_edit_form [name='dicTeaType']").val("").attr("disabled",false)
        $("#tags_set_edit_form [name='speFour']").val("").attr("disabled",false)
        $("#tags_set_edit_form [name='speThere']").val("").attr("disabled",false)
        $("#tags_set_edit_form [name='speTwo']").val("").attr("disabled",false)
        $("#tags_set_edit_form [name='licenceId']").val("").attr("disabled",false)
        $("#tags_set_edit_form [name='standardId']").val("").attr("disabled",false)
        $("#tags_set_edit_form [name='speOne']").val("").attr("disabled",false)
        $("#tags_set_edit_form [name='principal']").val("").attr("disabled",false)
        $("#tags_set_edit_form [name='description']").val("")
        $("#tags_set_edit_form [name='tagsQuantity']").val("")
        $("#tags_set_edit_form [name='tagsLow']").val("")
        $("#tags_set_edit_form [name='status']").val(2)
        $("#tags_set_edit_form #createUser").val(createUser).attr("disabled",true)
        $('.status_switch').bootstrapSwitch('state',false);
        $(".tagsEditModal .form-control-feedback").remove()
        $(".tagsEditModal div").removeClass("has-danger")
        $(".tagsEditModal div").removeClass("has-success")
    }
    /**
     * 取消编辑时 重置表单初始值为 add 类型
     */
    var addtags = function () {
        $(".addTags").on('click',function(){
            removeValue('add')
        })
    }
    return {
        init: function () {
            tagsListShow();
            tagsForm();
            getTagsItem();
            delTagsItem();
            addtags();
        }
    };
}();



jQuery(document).ready(function () {
    tags.init();
    $('.status_switch').bootstrapSwitch();
    $('.status_switch').on('switchChange.bootstrapSwitch', function (event,state) {
        if(state==true){
            $(this).parents("div").find(".status_switch_parent").find("[name='status']").val(1)
        }else{
            $(this).parents("div").find(".status_switch_parent").find("[name='status']").val(2)
        }
    });
});