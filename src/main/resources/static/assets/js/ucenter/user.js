var User = function () {
    var actionsTemplate = $("#actionsTemplate").html();
    var datatable = "";
    var $distpicker = $('#distpicker')
    var userListShow = function () {
        var option = {
            data: {
                type: 'remote',
                source: {
                    read: {
                        url: 'getUserDataList'
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
            }, {
                field: "account",
                title: "账号",
                width: 100
            }, {
                field: "chineseName",
                title: "中文名",
                width: 100
            }, {
                field: "mobile",
                title: "电话",
                width: 120
            }, {
                field: "roleName",
                title: "角色",
                width: 100
            }, {
                field: "email",
                title: "邮箱",
                width: 120
            }, {
                field: "typeName",
                title: "用户类型",
                width: 100
            }, {
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
            },{
                field: "Actions",
                width: 130,
                title: "操作",
                sortable: false,
                overflow: 'visible',
                template: function (row) {
                    var dropup = (row.getIndex() - row.getIndex()) <= 4 ? 'dropup' : '';
                    return actionsTemplate.replace(/#rowId#/g, row.id)
                }
            }]
        }
        datatable = $('.user_list_ajax').mDatatable(option);
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

        $('#m_form_type').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.userType = $(this).val().toLowerCase();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(typeof query.userType !== 'undefined' ? query.userType : '');
        $('.datatableRoload').on('click', function () {
            location.reload()
        });
        $('#m_form_status, #m_form_type').selectpicker();
    };

    /**
     * UserEdit 表单验证
     * 新增与编辑
     */
    var userForm = function () {
        $( "#user_edit_form" ).validate({
            rules: {
                account: {
                    required: true,
                    account: true,
                    minlength: 6,
                    maxlength: 14
                },
                email: {
                    email: true
                },
                password: {
                    required: true,
                    minlength: 6,
                    maxlength: 14
                },
                roleId: {
                    required: true
                },
                chineseName: {
                    required: true,
                    nameCheck:true
                },
                userType: {
                    required: true
                },
                mobile: {
                    required: true,
                    mobileZH:true,

                }
            },
            submitHandler: function (form){
                blockUiOpen('.userEdit .modal-content');
                request(
                    "saveUserOrUpdate",
                    "post",
                    $("#user_edit_form").serialize(),
                    function(result){
                        if(result.message){
                            ToastrMsg(result.data,"success","topRight",".userEdit .modal-content","reload",true);
                        }else{
                            ToastrMsg(result.data,"error","topRight",".userEdit .modal-content");
                        }
                    }
                )
            }
        });
    }

    /**
     * 获取用户信息,并移除上一轮错误信息
     */
    var editUserItem = function () {
        $("#user_list ").on("click", ".editUserItem", function () {
            removeValue('edit')
            var id = $(this).attr("item");
            if(id != ""){
                request(
                    "getUserItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            $("#user_edit_form [name='id']").val(result.data.userId)
                            $("#user_edit_form [name='infoId']").val(result.data.infoId)
                            $("#user_edit_form [name='account']").val(result.data.account)
                            $("#user_edit_form [name='email']").val(result.data.email)
                            $("#user_edit_form [name='mobile']").val(result.data.mobile)
                            $("#user_edit_form [name='roleId']").val(result.data.roleId)
                            $("#user_edit_form [name='chineseName']").val(result.data.chinese_name)
                            $("#user_edit_form [name='userType']").val(result.data.user_type)
                            $("#user_edit_form [name='signature']").text(result.data.signature);
                            $("#user_edit_form [name='address']").val(result.data.address)
                            $("#user_edit_form [name='status']").val(result.data.status)
                            if (typeof result.data.head_imgurl !== 'undefined' && result.data.head_imgurl !== ''){
                                $("#upload_image img").attr('src',result.data.head_imgurl)
                                $("#user_edit_form [name='headImgurl']").val(result.data.head_imgurl)
                            }
                            $(".user_nick_name").text(result.data.chinese_name)
                            $(".user_email").text(result.data.email)
                            if(result.data.status == 1){
                                $('.status_switch').bootstrapSwitch('state',true);
                            }else{
                                $('.status_switch').bootstrapSwitch('state',false);
                            }
                            $("#distpicker").distpicker({
                                province: result.data.province,
                                city: result.data.city,
                                district: result.data.country
                            });
                        }
                    })
            }
        })
    }

    /**
     * 重置用户密码
     */
    var resetPassWord = function () {
        $("#user_list ").on("click", ".resetPassWord", function () {
            var id = $(this).attr("item");
            if(id != ""){
                request(
                    "resetPassWord",
                    'post',
                    {id:id},
                    function (result) {
                        if(result.message){
                            ToastrMsg(result.data,"success","topRight");
                        }else{
                            ToastrMsg(result.data,"error","topRight");
                        }
                    })
            }
        })
    }
    /**
     * 新用户
     */
    var addUser = function(){
        $(".addUser").on("click",function(){
            removeValue('add')
        })

        $("#userType").on("change",function () {
            $("#loginType").val($("#userType option:selected").attr("loginType"));
        })

    }
    /**
     * 删除用户
     */
    var delUserItem = function () {
        $("#user_list ").on("click", ".delUserItem", function () {
            blockUiOpen('#user_list');
            var self = $(this);
            var id = self.attr("item");
            if(id != ""){
                request(
                    "delUserItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            self.parents("tr").remove();
                            ToastrMsg(result.data,"success","topRight",'#user_list');
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#user_list');
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
        if(type == 'edit'){
            $(".userEdit .modal-title").text("用户编辑")
            $(".userEdit [name='save']").val('edit')
            $("#user_edit_form [name='account']").attr("disabled",true)
            $("#user_edit_form [name='password']").attr("disabled",true)
            $(".reset-btn").addClass("m--hide");
        }else{
            $(".user_nick_name").text("Jion Landry")
            $(".user_email").text("jionlandry@gmail.com")
            $(".userEdit .modal-title").text("用户新增")
            $(".userEdit [name='save']").val('add');
            $(".reset-btn").removeClass("m--hide");
            $('#distpicker').distpicker({autoSelect: false});
            $("#user_edit_form [name='account']").attr("disabled",false)
            $("#user_edit_form [name='password']").attr("disabled",false)
        }
        $("#upload_image img").attr('src','/assets/img/users/_img.png')
        $("#headImgurl").val()
        $("#user_edit_form [name='roleId']").val("")
        $("#user_edit_form [name='id']").val("")
        $("#user_edit_form [name='account']").val("")
        $("#user_edit_form [name='userType']").val("")
        $("#user_edit_form [name='password']").val("")
        $("#user_edit_form [name='email']").val("")
        $("#user_edit_form [name='mobile']").val("")
        $("#user_edit_form [name='chineseName']").val("")
        $("#user_edit_form [name='address']").val("")
        $("#user_edit_form [name='signature']").text("");
        $('.status_switch').bootstrapSwitch('state',false);
        $(".userEdit .form-control-feedback").remove()
        $(".userEdit div").removeClass("has-danger")
        $(".userEdit div").removeClass("has-success")
    }

    /**
     * 取消编辑时 重置表单初始值为 add 类型
     */
    var closeParent = function () {
        $(".close-parent").on('click',function(){
            removeValue('add')
        })
    }

    return {
        init: function () {
            addUser();
            userForm();
            delUserItem();
            userListShow();
            editUserItem();
            resetPassWord();
        }
    };
}();
jQuery(document).ready(function () {
    User.init();

    /**
     * 开关
     * 开关
     */
    $('.status_switch').on('switchChange.bootstrapSwitch', function (event,state) {
        if(state==true){
            $("#status").val(1)
        }else{
            $("#status").val(2)
        }
    });
});