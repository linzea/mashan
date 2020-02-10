var MenuPage = function () {
    var MenuTree = $('#menu_tree');
    // 菜单树初始化
    var createTree = function (roleMenu) {
        MenuTree.jstree({
            "core" : {
                "multiple": false,
                "themes" : {
                    "responsive": false
                },
                "check_callback" : true,
                'data' : roleMenu
            },
            "plugins" : ["types","stats"]
        });

        // 展开节点
        MenuTree.on("loaded.jstree", function (event, data) {
            // 展开所有节点
            MenuTree.jstree('open_all');
            // 展开指定节点
            //data.instance.open_node(1);     // 单个节点 （1 是顶层的id）
            //data.instance.open_node([1, 10]); // 多个节点 (展开多个几点只有在一次性装载后所有节点后才可行）
        });
    }
    //表单验证初始化
    var menuForm = function () {
        $( "#menu_edit_form" ).validate({
            rules: {
                name: {
                    required: true,
                    nameCheck:true
                },
                url: {
                    required: true,
                    urlCheck: true
                },
                sortId: {
                    required: true,
                    digits: true
                },
                parentId: {
                    required: true
                },
                iconClass: {
                    required: true,
                    iconCheck: true
                },
                type: {
                    required: true
                },
                description: {
                    nameCheck:true
                }
            },
            invalidHandler: function(event, validator) {
                //alertMsgShow('.m-form #danger_msg', 'danger', ' 编辑菜单请选中左侧 菜单Tree 要编辑的菜单. 新增请直接填写.');
                ToastrMsg(' 编辑菜单请选中左侧 菜单Tree 要编辑的菜单. 新增请直接填写.',"warning","topRight");
            },

            submitHandler: function (form){
                request(
                    "saveMenu",
                    "post",
                    $("#menu_edit_form").serialize(),
                    function(result){
                        if(result.message){
                            //alertMsgShow('.m-form #success_msg', 'success', result.data);
                            ToastrMsg(result.data,"success","topRight");
                            $(".reset-btn").click();
                            $("#menu_edit_form .form-control-feedback").remove()
                            $("#menu_edit_form div").removeClass("has-danger")
                            $("#menu_edit_form div").removeClass("has-success")
                        }else{
                            //alertMsgShow('.m-form #warning_msg', 'warning', result.data);
                            ToastrMsg(result.data,"error","topRight");
                        }
                    }
                )
            }
        });
    }
    var getMenuData = function () {
        //获取选中菜单的数据
        $("#menu_tree").on("click","a",function(){
            request(
                "getMenuData",
                "get",
                {"id":$(this).parents("li").attr("id")},
                function(result){
                    if(result.message){
                        $("[name='name']").val(result.data.name)
                        $("[name='url']").val(result.data.url)
                        $("[name='sortId']").val(result.data.sortId)
                        $("[name='iconClass']").val(result.data.iconClass)
                        $("[name='type']").find("option[value="+result.data.type+"]").attr("selected",true);
                        $("[name='description']").val(result.data.description)
                        $("[name='save']").val('edit')
                        $("[name='id']").val(result.data.id)
                        if(result.data.status == 1){
                            $('.status_switch').bootstrapSwitch('state',true);
                        }else{
                            $('.status_switch').bootstrapSwitch('state',false);
                        }
                        $("[name='parentId']").val(result.data.parentId)
                        var node = MenuTree.jstree("get_node", result.data.parentId);
                        if (node){
                            $("#treeNodeName").val(node.text)
                        }else{
                            $("#treeNodeName").val("Root")
                        }
                        $(".delParentMenu").removeClass("m--hide");
                        $(".menu_save").text("更新")
                        $(".reset-btn").removeClass("m--hide");
                    }else{
                        var alert = $('.m-form #danger_msg');
                        alert.find("#danger_content").text("编辑菜单请选中左侧 菜单Tree 要编辑的菜单.")
                        alert.removeClass('m--hide').show();
                        mApp.scrollTo(alert, -200);
                    }
                }
            )
        })
    }
    /**
     * 获取菜单树
     */
    var getMenuList = function () {
        request(
            "getMenuList",
            "get",
            {selected:false,threeDisabled:false},
            function(result){
                if(result.message){
                    createTree(result.data)
                }else{
                    ToastrMsg(result.data,"error","topRight");
                }
            }
        )
    }

    //重置 编辑区域
    var resetForm = function () {
        $(".reset-btn").on("click",function(){
            $(".menu_save").text("确定")
            $("[name='save']").val('add')
            $("[name='id']").val("")
            $(this).addClass("m--hide")
            $(".delParentMenu").addClass("m--hide");
        })
    }

    /**
     * 删除父级属性
     */
    var delParentMenu = function () {
        $(".delParentMenu ").on("click", function () {
            blockUiOpen('.menu_edit_form');
            var id = $("#menu_edit_form [name='id']").val();
            if(id != ""){
                request(
                    "delParentMenu",
                    'post',
                    {id:id},
                    function (result) {
                        if(result.message){
                            ToastrMsg(result.data,"success","topRight",".menu_edit_form");
                            location.reload()
                        }else{
                            ToastrMsg(result.data,"warning","topRight",".menu_edit_form");
                        }
                    })
            }
        })
    }
    return {
        init: function() {
            getMenuList();
            resetForm();
            menuForm();
            getMenuData();
            delParentMenu();
        }
    };
}();

jQuery(document).ready(function() {
    $('.status_switch').bootstrapSwitch();
    MenuPage.init();
    /**
     * 开关
     */
    $('.status_switch').on('switchChange.bootstrapSwitch', function (event,state) {
        if(state==true){
            $(this).parents("div").find(".status_switch_parent").find("[name='status']").val(1)
        }else{
            $(this).parents("div").find(".status_switch_parent").find("[name='status']").val(2)
        }
    });
});