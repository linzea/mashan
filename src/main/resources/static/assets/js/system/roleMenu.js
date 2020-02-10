var Treeview = function () {
    var MenuTree = $('#menu_tree');
    /**
     * 取消全部选中-刷新树
     */
    var remove_menu_tree = function(){
        MenuTree.jstree("uncheck_all"); //取消全部选中
        MenuTree.find("a").removeAttr("role_menu_id").removeAttr("status").removeClass("is_change").addClass("is_default")
    }
    /**
     * 菜单树初始化
     */
    var createTree = function (menuTree) {
        MenuTree.jstree({
            "core" : {
                "multiple": true,
                "themes" : {
                    "responsive": false
                },
                "check_callback" : true,
                'data' : menuTree
            },
            "plugins" : ["types","stats","checkbox"]
        });
        // 展开节点
        MenuTree.on("loaded.jstree", function (event, data) {
            // 展开所有节点
            MenuTree.jstree('open_all');
            /**
             * 选中第一个 radio
             */
            $(".first-radio").click()
        });
        MenuTree.on("changed.jstree", function (e, data) {
            if((typeof data.event !== 'undefined' && data.event.type == 'click') && (data.action == 'select_node' || data.action == 'deselect_node')){
                if(data.action == 'select_node' && data.selected.length >= 1){
                    $.each(data.selected, function (i, n) {
                        if(n != '' && n.indexOf('j1_') < 0){
                            var node = MenuTree.jstree("get_node", n);
                            var menuId = node.a_attr.id,aclass = $("#"+menuId).attr("class"),status = $("#"+menuId).attr("status");
                            if(status == 2){
                                $("#"+menuId).attr("status",1)
                            }
                            if(aclass.indexOf("is_default") >= 0){
                                $("#"+menuId).removeClass("is_default").addClass("is_change");
                            }
                        }
                    });

                } else if (data.action == 'deselect_node' && data.selected.length >= 0) {
                    $.each(data.node.children, function (i, n) {
                        var node = MenuTree.jstree("get_node", n);
                        var menuId = node.a_attr.id,aclass = $("#"+menuId).attr("class"),status = $("#"+menuId).attr("status");
                        if(status == 1){
                            $("#"+menuId).attr("status",2)
                        }
                        if(aclass.indexOf("is_change") >= 0){
                            $("#"+menuId).removeClass("is_change").addClass("is_default");
                        }else if(aclass.indexOf("is_default") >= 0){
                            $("#"+menuId).removeClass("is_default").addClass("is_change");
                        }
                    });
                    var menuId = data.node.a_attr.id,aclass = $("#"+menuId).attr("class"),status = $("#"+menuId).attr("status");
                    if(status == 1){
                        $("#"+menuId).attr("status",2)
                    }
                    if(aclass.indexOf("is_change") >= 0){
                        $("#"+menuId).removeClass("is_change").addClass("is_default");
                    }else if(aclass.indexOf("is_default") >= 0){
                        $("#"+menuId).removeClass("is_default").addClass("is_change");
                    }
                }
            }
        });
    }

    /**
     * 选中角色对应的菜单树 checkbox
     * 菜单为启用状态时 选中 如果当前节点为父节点，默认不管
     * @param roleMenu
     * @returns {number}
     */
    var checked_menu_tree = function (roleMenu) {
        remove_menu_tree()
        if(roleMenu != ""){
            $.each(roleMenu, function (i, n) {
                if(n.id != null){
                    var node = MenuTree.jstree("get_node", n.id);
                    if (node && typeof node.a_attr !== "undefined"){
                        $("#"+node.a_attr.id).attr("status",n.roleMenuStatus)
                        $("#"+node.a_attr.id).attr("role_menu_id",n.roleMenuId)
                        if(node.children.length == 0 && n.roleMenuStatus == 1){
                            MenuTree.jstree().select_node(node);
                        }
                    }
                }
            });
        }
    }
    /**
     * 获取菜单树
     */
    var getMenuList = function () {
        request(
            "getMenuList",
            "get",
            "",
            function(result){
                if(result.message){
                    createTree(result.data)
                }else{
                    ToastrMsg(result.data,"error","topRight");
                }
            }
        )
    }
    /**
     * 获取当前角色的 可用菜单
     */
    var get_checked_role_menu = function () {
        $(".m-widget4__item").on('click', '[type=\'radio\']', function () {
            var id = $(this).val();
            request(
                'getRoleMenuDataList',
                'get',
                {id: id},
                function (result) {
                    if (result.message) {
                        checked_menu_tree(result.data)
                    }else{
                        ToastrMsg(result.data,"warning","topRight");
                    }
                })
        })
    }
    /**
     * 获取JsTree checked 值 使用get_checked方法
     * @returns {string}
     */
    var get_menu_id = function () {
        var paramArr = [];
        var nodes = $('#menu_tree .is_change');
        $.each(nodes, function (i, n) {
            var node = MenuTree.jstree("get_node", nodes.eq(i).attr('id'));
            if(node.id.indexOf("j1_") < 0){
                var id = node.id,
                    parent = node.parent.indexOf("j1_") >=0 ? "" : node.parent,
                    a_id   = node.a_attr.id,
                    self = $("#"+a_id),
                    status = self.attr("status"),
                    aclass = self.attr("class"),
                    role_menu_id = self.attr("role_menu_id");
                if(node.text !== 'Dashboard' && aclass.indexOf("is_change") >= 0 && typeof id !== "undefined"){
                    /**
                     * 参数为 undefined 时 补齐参数，防止报错
                     * @type {{menu_id, role_id: (*|jQuery), status: *, parent_id: *, role_menu_id: *}}
                     */
                    var itemArr = {
                        'menu_id':id,
                        'role_id':$(".radio_role input[type='radio']:checked").val(),
                        'status': typeof status !== "undefined" ? status : 0,
                        'parent_id': parent !== "" && parent !== "#" ? parent : 0,
                        'role_menu_id': typeof role_menu_id !== "undefined" ? role_menu_id : 0};
                    paramArr.push(itemArr);
                }
            }
         });
        return JSON.stringify(paramArr);
    }

    /**
     * 保存 改变后的结果 带上 role id
     */
    var save_menu_role_change = function () {
        $(".role_menu_save").on('click',function(){
            var param = get_menu_id();
            if(typeof param !== 'undefined' && param != '[]'){
                request('saveRoleMenu','post',{param:param},function (result) {
                    if(result.message){
                        //alertMsgShow('.m-form #success_msg', 'success', result.data);
                        ToastrMsg(result.data,"success","topRight");
                    }else{
                        //alertMsgShow('.m-form #warning_msg', 'warning', result.data);
                        ToastrMsg(result.data,"warning","topRight");
                    }
                })
            }else{
                //alertMsgShow('.m-form #danger_msg', 'danger', '  请选择 要赋予该角色的菜单,或者未修改过该项.');
                ToastrMsg('  请选择 要赋予该角色的菜单,或者未修改过该项.',"error","topRight");
            }
        })
    }

    return {
        init: function () {
            getMenuList();
            get_checked_role_menu();
            save_menu_role_change();
        }
    };
}();

jQuery(document).ready(function() {
    Treeview.init();
});