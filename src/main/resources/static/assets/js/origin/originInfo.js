var originInfo = function () {
    var actionsTemplate = $("#actionsTemplate").html();
    var status = {
        0: {'title': '未使用', 'class': ' m-badge--warning'},
        1: {'title': '使用中', 'class': ' m-badge--success'}
    };
    var originInfoInfoShow = function () {
        var option = {
            data: {
                type: 'remote',
                source: {
                    read: {
                        url: 'getOriginInfoDataList'
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
                {field: "title", title: "标题", width: 180},
                {field: "batchNum", title: "溯源批次", width: 100},
                {field: "dicOriginName", title: "溯源类型", width: 60},
                {
                    field: "status",
                    title: "状态",
                    width: 60,
                    template: function (row) {
                        return '<span class="m-badge ' + status[row.status].class + ' m-badge--wide">' + status[row.status].title + '</span>';
                    }
                },
                {field: "sortId", title: "排序", width: 60,sortable: 'desc'},
                {field: "description", title: "摘要", width: 200},
                {field: "createTime", title: "创建时间", width: 150,sortable: 'desc'},
                {
                    field: "Actions",
                    width: 100,
                    title: "操作",
                    sortable: false,
                    overflow: 'visible',
                    template: function (row) {
                        var dropup = (row.getIndex() - row.getIndex()) <= 4 ? 'dropup' : '';
                        return actionsTemplate.replace(/#rowId#/g, row.id);
                    }
                }]
        }
        var datatable = $('.origin_info_list').mDatatable(option);

        var query = datatable.getDataSourceQuery();

        $('#m_form_search').on('keyup', function (e) {
            var query = datatable.getDataSourceQuery();
            query.generalSearch = $(this).val().toLowerCase();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(query.generalSearch);

        $('#originBatch').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.originBatch = $(this).val().toLowerCase();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(typeof query.originBatch !== 'undefined' ? query.originBatch : '');
        $('#dicOriginType').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.dicOriginType = $(this).val().toLowerCase();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(typeof query.dicOriginType !== 'undefined' ? query.dicOriginType : '');
        $('.datatableRoload').on('click', function () {
            location.reload()
        });
        $('.select_selectpicker').selectpicker();
    };

    /**
     * 茶园信息表单验证
     * 新增与编辑
     */
    var originInfoInfoForm = function () {
        $( "#origin_info_edit_form" ).validate({
            rules: {
                originBatch: { required: true },
                dicOriginType:{required: true,},
                title:{required: true,nameCheck:true},
                description:{required: true,},
                content:{required: true,},
                sortId:{required: true,digits:true}
            },
            submitHandler: function (form){
                blockUiOpen('.originInfoEdit .modal-content');
                request(
                    "saveOrUpdateOriginInfo",
                    "post",
                    $("#origin_info_edit_form").serialize(),
                    function(result){
                        if(result.message){
                            blockUiClose('.originInfoEdit .modal-content',1,".close-parent",0);
                            ToastrMsg(result.data,"success","topRight",'.originInfoEdit .modal-content',"reload",true);
                            ;
                        }else{
                            ToastrMsg(result.data,"error","topRight",'.originInfoEdit .modal-content');
                        }
                    }
                )
            }
        });
    }

    /**
     * 重置表单
     */
    var removeValue = function(type){
        myDropzone.removeAllFiles(true);
        if(type == 'edit'){
            $(".originInfoEditModal .modal-title").text("编辑溯源信息")
            $(".originInfoEditModal [name='save']").val('edit')
            $(".originInfoEditModal .reset-btn").addClass("m--hide");
        }else{
            $(".originInfoEditModal .modal-title").text("新增溯源信息")
            $(".originInfoEditModal [name='save']").val('add');
            $(".originInfoEditModal .reset-btn").removeClass("m--hide");
        }
        $("#origin_info_edit_form [name='id']").val("")
        $("#origin_info_edit_form [name='title']").val("")
        $("#origin_info_edit_form [name='description']").val("")
        $("#origin_info_edit_form [name='originBatch']").val("")
        $("#origin_info_edit_form [name='dicOriginType']").val("")
        $("#origin_info_edit_form [name='status']").val("")
        $("#origin_info_edit_form [name='sortId']").val("")
        $("#origin_info_edit_form [name='content']").val("")
        $('.status_switch').bootstrapSwitch('state',false);
        $("#origin_info_edit_form .dz-message").show;
        $("#origin_info_edit_form .dz-preview").remove();
        $(".originInfoEditModal .form-control-feedback").remove()
        $(".originInfoEditModal div").removeClass("has-danger")
        $(".originInfoEditModal div").removeClass("has-success")
    }

    /**
     * 新增
     */
    var addOriginInfo = function () {
        $(".addOriginInfoItem").on('click',function(){
            removeValue('add')
        })
    }

    /**
     * 获取信息,并移除上一轮错误信息
     */
    var editOriginInfoItem = function () {
        $("#origin_info_list").on("click", ".editOriginInfoItem", function () {
            removeValue('edit')
            var id = $(this).attr("item");
            if(id != ""){
                request(
                    "getOriginInfoItem",
                    'get',
                    {id:id},
                    function (result) {
                        console.log(result)
                        if(result.message){
                            $("#origin_info_edit_form [name='id']").val(result.data.id)
                            $("#origin_info_edit_form [name='title']").val(result.data.title)
                            $("#origin_info_edit_form [name='content']").val(result.data.content)
                            $("#origin_info_edit_form [name='description']").val(result.data.description)
                            $("#origin_info_edit_form [name='originBatch']").val(result.data.originBatch)
                            $("#origin_info_edit_form [name='dicOriginType']").val(result.data.dicOriginType)
                            $("#origin_info_edit_form [name='status']").val(result.data.status)
                            $("#origin_info_edit_form [name='sortId']").val(result.data.sortId)
                            if (result.data.imgUrl){
                                myDropzone.emit("initimage", result.data.imgUrl); //初始化图片
                                $(".equipmentEditModal [name='imgUrl']").val(result.data.imgUrl)
                            }
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
     * 删除
     */
    var delOriginInfoItem = function () {
        $("#origin_info_list ").on("click", ".delOriginInfoItem", function () {
            blockUiOpen('#origin_info_list');
            var self = $(this);
            var id = self.attr("item");
            if(id != ""){
                request(
                    "delOriginInfoItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            self.parents("tr").remove();
                            ToastrMsg(result.data,"success","topRight",'#origin_info_list');
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#origin_info_list');
                        }
                    })
            }
        })
    }

    return {
        init: function () {
            addOriginInfo();
            editOriginInfoItem()
            delOriginInfoItem()
            originInfoInfoShow();
            originInfoInfoForm();
        }
    };
}();
jQuery(document).ready(function () {
    originInfo.init();
    $('.status_switch').bootstrapSwitch();
    $('.status_switch').on('switchChange.bootstrapSwitch', function (event,state) {
        if(state==true){
            $(this).parents("div").find(".status_switch_parent").find("[name='status']").val(1)
        }else{
            $(this).parents("div").find(".status_switch_parent").find("[name='status']").val(2)
        }
    });
});