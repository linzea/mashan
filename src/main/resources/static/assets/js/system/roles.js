var Roles = function () {
    var actionsTemplate = $("#actionsTemplate").html();
    var rolesListShow = function () {
        var option = {
            data: {
                type: 'remote',
                source: {
                    read: {
                        url: '/system/roles/getRolesDataList'
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
            columns: [{
                title: "#",
                width: 40,
                template: function (row) {
                    return row.rowIndex+1;
                }
            }, {
                field: "name",
                title: "名称",
                width: 100
            }, {
                field: "description",
                title: "描述",
                width: 100
            }, {
                field: "createTime",
                title: "创建时间",
                sortable: 'asc',
                width: 150
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
        var datatable = $('.roles_list_ajax').mDatatable(option);
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
        $('#m_form_status, #m_form_type').selectpicker();
    };

    /**
     * RoleEdit 表单验证
     * 新增与编辑
     */
    var rolesForm = function () {
        $( "#role_edit_form" ).validate({
            rules: {
                name: {
                    required: true,
                    nameCheck:true
                },
                description: {
                    nameCheck:true,
                    maxlength: 100
                }
            },

            submitHandler: function (form){
                blockUiOpen('.rolesEdit .modal-content');
                request(
                    "saveRole",
                    "post",
                    $("#role_edit_form").serialize(),
                    function(result){
                        if(result.message){
                            blockUiClose('.rolesEdit .modal-content',1,".close-parent",0);
                            ToastrMsg(result.data,"success","topRight");
                            location.reload()
                        }else{
                            ToastrMsg(result.data,"error","topRight");
                        }
                    }
                )
            }
        });
    }
    /**
     * 删除角色
     */
    var delRoleItem = function () {
        $("#roles_list ").on("click", ".delRoleItem", function () {
            blockUiOpen('#roles_list');
            var self = $(this);
            var id = self.attr("item");
            if(id != ""){
                request(
                    "delRoleItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            self.parents("tr").remove();
                            ToastrMsg(result.data,"success","topRight",'#roles_list');
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#roles_list');
                        }
                    })
            }
        })
    }
    /**
     * 获取角色信息,并移除上一轮错误信息
     */
    var editRoleItem = function () {
        $("#roles_list ").on("click", ".editRoleItem", function () {
            removeValue('edit')
            var id = $(this).attr("item");
            if(id != ""){
                request(
                    "getRoleItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            $("#role_edit_form [name='id']").val(result.data.id)
                            $("#role_edit_form [name='name']").val(result.data.name)
                            $("#role_edit_form [name='description']").val(result.data.description)
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
        if(type == 'edit'){
            $(".rolesEdit .modal-title").text("角色编辑")
            $(".rolesEdit [name='save']").val('edit')
            $(".reset-btn").addClass("m--hide");
        }else{
            $(".rolesEdit .modal-title").text("角色新增")
            $(".rolesEdit [name='save']").val('add');
            $(".reset-btn").removeClass("m--hide");
        }
        $(".rolesEdit [name='id']").val('')
        $(".rolesEdit [name='name']").val('')
        $(".rolesEdit [name='description']").val('');
        $(".rolesEdit .form-control-feedback").remove()
        $(".rolesEdit div").removeClass("has-danger")
        $(".rolesEdit div").removeClass("has-success")
    }

    return {
        init: function () {
            rolesListShow();
            rolesForm();
            delRoleItem();
            editRoleItem();
        }
    };
}();

jQuery(document).ready(function () {

    Roles.init();
});