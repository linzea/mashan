var PageRole = function () {
    var MenuTree = $('#menu_tree'),submit = typeof $("#submit").val(),disabled="";
    if (submit == "undefined"){
        disabled = "disabled"
    }
    var status = {
        0: {'title':'未知', 'class':'m-badge--info'   , 'button':'btn m-btn--pill btn-success btn-sm change-status', 'change':'启用'},
        1: {'title':'启用', 'class':'m-badge--success', 'button':'btn m-btn--pill btn-danger btn-sm  change-status', 'change':'禁用'},
        2: {'title':'禁用', 'class':'m-badge--danger' , 'button':'btn m-btn--pill btn-success btn-sm change-status', 'change':'启用'},
        3: {'title':'暂无', 'class':'m-badge--warning', 'button':'btn m-btn--pill btn-success btn-sm change-status', 'change':'启用'}
    };
    /**
     * 获取当前角色的可用菜单
     * MenuTree.data('jstree', false).empty(); 清空树
     * MenuTree.jstree("destroy"); 销毁树
     */
    var getRoleMenu = function () {
        $(".m-widget4__item").on('click', '[type=\'radio\']', function () {
            MenuTree.jstree("destroy");
            MenuTree.html("");
            var id = $(this).val();
            if(id != ''){
                request(
                    'getRoleMenuDataList',
                    'get',
                    {id: id},
                    function (result) {
                        if (result.message) {
                            createMenuTree(result.data)
                        }else{
                            ToastrMsg(result.data,"warning","topRight");
                        }
                    }
                )
            }
        })
    }

    /**
     * 选中角色对应的菜单树 checkbox
     * 菜单为启用状态时 选中 如果当前节点为父节点，默认不管
     * "multiple": false,// 为true 时 多选
     * 加载完成后 800 毫秒点击第一个菜单
     * @param roleMenu
     * @returns {number}
     */
    var createMenuTree = function (roleMenu) {
        MenuTree.html("");
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
        setTimeout(function() {
            $("#menu_tree .first-item a").click()
        }, 800);
    }
    /**
     * 监听 JsTree 点击事件 获取权限数据
     * 此方法必须在 JsTree 加载完成后执行，否则点击事件监听不到
     */
    var getPageRoleList = function(){
        $("#menu_tree").on("click","a",function () {
            var menuId = $(this).parent("li").attr("id");
            var roleId = $(".radio_role input[type='radio']:checked").val();
            if(menuId != "" && roleId != ""){
                request(
                    'getPageRoleDataList',
                    'get',
                    {'menuId':menuId,'roleId':roleId,'status': 1},
                    function (result) {
                        if(result.message){
                            showPageRoleList(result.data)
                        }else{
                            ToastrMsg(result.data,"warning","topRight");
                        }
                    })
            }
        })
    }
    /**
     * 显示属性列表
     * @param dictionaryList
     */
    var showPageRoleList = function(pageRoleList){

        var _html = '';
        if(pageRoleList.length > 0){
            $.each(pageRoleList, function (i, n) {
                _html += "<tr class='"+n.id+"'><th scope=\"row\">"+n.sort_id+"</th>";
                _html += "<td>"+n.name+"</td>";
                _html += "<td>"+n.value+"</td>";
                _html += '<td><span class="m-badge ' + status[n.pageRoleStatus].class + ' m-badge--wide">' + status[n.pageRoleStatus].title + '</span></td>';
                _html += '<td><button type="button" class="'+status[n.pageRoleStatus].button+'" id="'+n.pageRoleId+'" value="'+n.pageRoleStatus+'" dict-id="'+n.id+'"  style="line-height: 1.2" '+disabled+'>' + status[n.pageRoleStatus].change + '</button></td>';
                _html += "</tr>";
            });
        }
        if(_html == ""){
            _html = "<tr><th colspan='5' scope=\"row\" style='text-align:center'> 未找到相关属性信息！</th>";
        }
        $(".page_role_list").html(_html);
    }
    /**
     * 保存改变后的结果
     * MenuTree.jstree(true).get_top_selected()选中节点中父节点ID-多选
     * MenuTree.jstree(true).get_selected() 选中的节点
     */
    var savePageRoleChange = function () {
        //blockUiCloseParent(".table_page_role_list")
        $("#page_role_list").on('click','button',function(){
            blockUiOpen(".table_page_role_list")
            var self = $(this);
            var pageRoleId = self.attr("id"),
                dictId = self.attr("dict-id"),
                status = self.val(),
                menuId = MenuTree.jstree(true).get_selected().toString(),
                roleId = $(".radio_role input[type='radio']:checked").val();
            if(pageRoleId != '' && dictId != '' && status != '' && menuId != '' && roleId != ''){
                request(
                    'saveOrUpdatePageRole',
                    'post',
                    {id:pageRoleId,status:status,dictId:dictId,menuId:menuId,roleId:roleId},
                    function (result) {
                        if(result.message){
                            ToastrMsg(result.data,"success","topRight");
                            if( pageRoleId != '0'){
                                if(status == 2 || status == 3){
                                    self.removeClass().addClass("btn m-btn--pill btn-danger btn-sm change-status").text("禁用").val(1)
                                    $(".table_page_role_list ."+dictId + " span").removeClass().addClass("m-badge m-badge--success m-badge--wide").text("启用")
                                }else{
                                    self.removeClass().addClass("btn m-btn--pill btn-success btn-sm change-status").text("启用").val(2)
                                    $(".table_page_role_list ."+dictId + " span").removeClass().addClass("m-badge m-badge--danger m-badge--wide").text("禁用")
                                }
                                blockUiCloseParent(".table_page_role_list")
                            }else{
                                $("#menu_tree #"+menuId +" a").click()
                                // self.removeClass().addClass("btn m-btn--pill btn-danger btn-sm change-status").text("禁用").val(1)
                                // $(".table_page_role_list ."+dictId + " span").removeClass().addClass("m-badge m-badge--success m-badge--wide").text("启用")
                                blockUiCloseParent(".table_page_role_list")
                            }
                        }else{
                            ToastrMsg(result.data,"warning","topRight",".table_page_role_list");
                        }
                    })
            }else{
                ToastrMsg('  请选择要赋予该角色的菜单,或者未修改过该项.',"error","topRight");
            }
        })
    }

    return {
        init: function () {
            getRoleMenu();
            getPageRoleList();
            savePageRoleChange();
        }
    };
}();

jQuery(document).ready(function() {
    PageRole.init();
    /**
     * 选中第一个 radio
     */
    $(".first-radio").click()
});