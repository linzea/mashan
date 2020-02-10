var StoreInfo = function () {
    var actionsTemplate = $("#actionsTemplate").html();
    var datatable = "";
    var $distpicker = $('#distpicker')
    var storeInfoListShow = function () {
        var option = {
            data: {
                type: 'remote',
                source: {
                    read: {
                        url: 'getStoreDataList'
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
            filterable: true,
            pagination: true,
            columns: [{
                title: "#",
                width: 40,
                template: function (row) {
                    return row.rowIndex+1;
                }
            },  {
                field: "storeName",
                title: "门店名称",
                width: 100
            }, {
                field: "storeManager",
                title: "管理员",
                width: 80
            }, {
                field: "storeScale",
                title: "人数规模",
                width: 80
            }, {
                field: "floorSpace",
                title: "占地面积",
                width: 80
            }, {
                field: "address",
                title: "地址",
                width: 220,
                template:function(row){
                    return row.province + row.city+row.country+row.address ;
                }
            },  {
                field: "status",
                title: "状态",
                width: 60,
                template: function (row) {
                    var status = {
                        0: {'title': '未激活', 'class': ' m-badge--warning'},
                        1: {'title': '激活', 'class': ' m-badge--success'},
                        2: {'title': '禁用', 'class': ' m-badge--danger'},
                    };
                    return '<span class="m-badge ' + status[row.status].class + ' m-badge--wide">' + status[row.status].title + '</span>';
                }
            }, {
                field: "createUser",
                title: "记录人",
                width: 80
            },{
                field: "Actions",
                width: 100,
                title: "操作",
                sortable: false,
                overflow: 'visible',
                template: function (row) {
                    var dropup = (row.getIndex() - row.getIndex()) <= 4 ? 'dropup' : '';
                    return actionsTemplate.replace(/#rowId#/g, row.id)
                }
            }]
        }
        datatable = $('.store_info_list_ajax').mDatatable(option);
        var query = datatable.getDataSourceQuery();
        $('#m_form_search').on('keyup', function (e) {
            var query = datatable.getDataSourceQuery();
            query.generalSearch = $(this).val().toLowerCase();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(query.generalSearch);

        $('#m_form_status').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.status = $(this).val().toLowerCase();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(typeof query.status !== 'undefined' ? query.status : '');


        $('.datatableRoload').on('click', function () {
            location.reload()
        });
        $('#m_form_status').selectpicker();
    };

    /**
     * Edit 表单验证
     * 新增与编辑
     */
    var storeInfoForm = function () {
        $( "#store_info_edit_form" ).validate({
            rules: {

                name: {
                    required: true,
                    nameCheck:true
                },
                storeScale: {
                    required: true,
                    number:true,
                },
                floorSpace: {
                    number:true,
                },
                storeId: {
                    required: true,
                }
            },
            submitHandler: function (form){
                blockUiOpen('.storeInfoEdit .modal-content');
                request(
                    "saveStoreInfoOrUpdate",
                    "post",
                    $("#store_info_edit_form").serialize(),
                    function(result){
                        if(result.message){
                            ToastrMsg(result.data,"success","topRight",".storeInfoEdit .modal-content","reload",true);
                        }else{
                            ToastrMsg(result.data,"error","topRight",".storeInfoEdit .modal-content");
                        }
                    }
                )
            }
        });
    }

    /**
     * 获取用户信息,并移除上一轮错误信息
     */
    var editStoreInfoItem = function () {
        $("#store_info_list ").on("click", ".editStoreInfoItem", function () {
            removeValue('edit')
            var id = $(this).attr("item");
            if(id != ""){
                $('#store_user_list_id').show();
                request(
                    "getStoreInfoItem",
                    'get',
                    {id:id},
                    function (result) {
                        console.log(result);
                        if(result.message){
                            $("#store_info_edit_form [name='id']").val(result.data.id);
                            $("#store_info_edit_form [name='name']").val(result.data.storeName);
                            $("#store_info_edit_form [name='storeScale']").val(result.data.storeScale);
                            $("#store_info_edit_form [name='floorSpace']").val(result.data.floorSpace);
                            $("#store_info_edit_form [name='signature']").text(result.data.signature);
                            $("#store_info_edit_form [name='address']").val(result.data.address);
                            $("#store_info_edit_form [name='status']").val(result.data.status);
                            if (result.data.userId != ""){
                                $("#store_info_edit_form [name='storeId']").addClass("m--hide").attr("disabled",true)
                                $("#store_info_edit_form #storeId").removeClass("m--hide").html("<option value=\"\">"+result.data.bindUser+"</option>").attr("disabled",true)
                            }else{
                                $("#store_info_edit_form [name='storeId']").removeClass("m--hide").attr("disabled",false)
                                $("#store_info_edit_form #storeId").addClass("m--hide").attr("disabled",true)
                            }
                            if(result.data.status == 1){
                                $('.status_switch').bootstrapSwitch('state',true);
                            }else{
                                $('.status_switch').bootstrapSwitch('state',false);
                            }
                            if (result.data.img_url){
                                myDropzone.emit("initimage", result.data.img_url); //初始化图片
                                $("#store_info_edit_form [name='imgUrl']").val(result.data.img_url);
                            }
                            $("#distpicker").distpicker({
                                province: result.data.province,
                                city: result.data.city,
                                district: result.data.country
                            });
                        }
                    });
                $(".store_user_list").html('');
                getStoreUserListInfo(id);
            }
        })
    }
    /**
     * 新用户
     */
    var addStoreInfo = function(){
        $(".addStoreInfo").on("click",function(){
            $('#store_user_list_id').hide();
            removeValue('add')
        })
    }
    /**
     * 删除用户
     */
    var delStoreInfoItem = function () {
        $("#store_info_list ").on("click", ".delStoreInfoItem", function () {
            blockUiOpen('#store_info_list');
            var self = $(this);
            var id = self.attr("item");
            if(id != ""){
                request(
                    "delStoreInfoItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            self.parents("tr").remove();
                            ToastrMsg(result.data,"success","topRight",'#store_info_list');
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#store_info_list');
                        }
                    })
            }
        })
    }
    /**
     * 重置表单
     */
    var removeValue = function (type) {
        $distpicker.distpicker('destroy');
        myDropzone.removeAllFiles(true);
        if(type == 'edit'){
            $(".storeInfoEdit .modal-title").text("门店编辑")
            $(".storeInfoEdit [name='save']").val('edit')
            $(".reset-btn").addClass("m--hide");
        }else{
            $("#store_info_edit_form [name='storeId']").removeClass("m--hide").attr("disabled",false)
            $("#store_info_edit_form #storeId").addClass("m--hide").attr("disabled",true)
            $(".storeInfoEdit .modal-title").text("门店新增")
            $(".storeInfoEdit [name='save']").val('add');
            $(".reset-btn").removeClass("m--hide");
            $('#distpicker').distpicker({autoSelect: false});
        }
        $("#store_info_edit_form [name='name']").val("")
        $("#store_info_edit_form [name='storeScale']").val("")
        $("#store_info_edit_form [name='floorSpace']").val("")
        $("#store_info_edit_form [name='address']").val("")
        $("#store_info_edit_form [name='storeID']").val("")
        $("#store_info_edit_form [name='signature']").text("");
        $("#store_info_edit_form [name='storeId']").attr("disabled",false)
        $('.status_switch').bootstrapSwitch('state',false);
        $(".storeInfoEdit .form-control-feedback").remove()
        $(".storeInfoEdit div").removeClass("has-danger")
        $(".storeInfoEdit div").removeClass("has-success")
    };

    /**
     * 获取当前门店的店员列表
     */
    var getStoreUserListInfo = function (id) {
          if(id != ''){
            request(
                'getStoreUserListInfo',
                'get',
                {id: id},
                function (result) {
                    if (result.message) {
                        showStoreUserList(result.data)
                    }else{
                        ToastrMsg(result.data,"warning","topRight");
                    }
                })
        }else{
            $(".store_user_list").html('暂无');
        }
    }

    /**
     * 显示店员列表
     * @param showStoreList
     */
    var showStoreUserList = function(showStoreUserList){
        var _html = '';
        if(showStoreUserList != ''){
            $.each(showStoreUserList, function (i, n) {
                    _html += "<tr><th scope=\"row\">"+n.account+"</th>";
                    _html += "<td>"+n.chineseName+"</td>";
                    _html += "<td>"+n.email+"</td>";
                    _html += '<td><span class="m-badge ' + status[n.status] + ' m-badge--wide">' + status[n.status] + '</span></td>';
                    _html += '<td>'+actionsTemplate.replace(/#rowId#/g, n.id)+'</td>';
                    _html += "</tr>";
            });
        }
        if(_html == ""){
            _html = "<tr><th colspan='5' scope=\"row\" style='text-align:center'> 未找到相关店员信息！</th>";
        }
        $(".store_user_list").html(_html);
    }

    return {
        init: function () {
            addStoreInfo();
            storeInfoForm();
            delStoreInfoItem();
            storeInfoListShow();
            editStoreInfoItem();

        }
    };
}();
jQuery(document).ready(function () {
    StoreInfo.init();
    $('.status_switch').on('switchChange.bootstrapSwitch', function (event,state) {
        if(state==true){
            $("#status").val(1)
        }else{
            $("#status").val(2)
        }
    });
});