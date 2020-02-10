var Assembly = function () {
    var actionsTemplate = $("#actionsTemplate").html();
    var status = {
        9: {'title': 'Pending', 'class': 'm-badge--brand'},
        9: {'title': 'Delivered', 'class': ' m-badge--metal'},
        9: {'title': 'Canceled', 'class': ' m-badge--primary'},
        1: {'title': '启用', 'class': ' m-badge--success'},
        0: {'title': '未知', 'class': ' m-badge--info'},
        2: {'title': '禁用', 'class': ' m-badge--danger'},
        9: {'title': 'Warning', 'class': ' m-badge--warning'}
    };
    //生产线验证
    var AssemblyForm = function () {
        //新增
        $(".assembly_parent_save").on('click',function(){
            checkParentForm('#assembly_parent_form');
        })
        //编辑
        $(".assembly_form_save").on('click',function(){
            checkParentForm('#assembly_form');
        })
    }

    var checkParentForm = function (formAttrId) {
        $(formAttrId).validate({
            rules: {
                name: { required: true, nameCheck:true },
                sortId: { required: true, digits: true },
                maintainCycle: { required: true, digits: true },
                maintainClear: { required: true, digits: true },
                status: { required: true},
                dicTeaAttr: {required: true},
                description: { nameCheck: true }
            },
            submitHandler: function (form){
                request(
                    "saveOrUpdateAssemblySet",
                    "post",
                    $(formAttrId).serialize(),
                    function(result){
                        if(result.message){
                            blockUiClose(formAttrId,1,".close-parent",0);
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
    //设备绑定验证
    var AssemblyChildForm = function(){
        $(".assembly_set_form_save").on('click',function(){
            $('#assembly_child_form').validate({
                rules: {
                    sortId: { required: true,digits: true },
                    machineId: { required: true},
                    status: { required: true},
                    description: { nameCheck: true }
                },
                submitHandler: function (form){
                    request(
                        "saveOrUpdateAssemblySet",
                        "post",
                        $('#assembly_child_form').serialize(),
                        function(result){
                            if(result.message){
                                ToastrMsg(result.data,"success","topRight",'#assembly_child_form',"reload",true);
                            }else{
                                ToastrMsg(result.data,"error","topRight",'#assembly_child_form');
                            }
                        }
                    )
                }
            });
        })
    }
    /**
     * 获取当前选项get列表
     */
    var getAssemblyValueListInfo = function () {
        $(".m-widget4__item").on('click', '[type=\'radio\']', function () {
            var id = $(this).val();
            request(
                'getAssemblySetDataList',
                'post',
                {parentId: id},
                function (result) {
                    if (result.message) {
                        showAssemblyList(id,result.data)
                    }else{
                        ToastrMsg(result.data,"warning","topRight");
                    }
                })
        })
    }
    /**
     * 编辑 设备绑定 信息
     * 点击属性管理列表 编辑按钮 get id
     */
    var getAssemblyChildItem = function(){
        $(".assembly_list ").on("click", ".editAssemblyItem", function () {
            removeValue('.assemblyEdit','edit','属性编辑',null)
            var id = $(this).attr("item");
            if(typeof id !== 'undefined' && id != ""){
                request(
                    "editAssemblySetItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            $("#assembly_child_form [name='machineId']").hide();
                            $("#machineId").html("<option>"+result.data.unit_name+"</option>").attr("disabled",true).show()
                            $("#assembly_child_form [name='id']").val(result.data.id)
                            $("#assembly_child_form [name='sortId']").val(result.data.sort_id)
                            $('#assembly_child_form [name="status"]').val(result.data.status)
                            $('#assembly_child_form [name="parentId"]').val(result.data.parent_id)
                            $('#assembly_child_form [name="dicTeaAttr"]').val(result.data.dic_tea_attr)
                            $("#assembly_child_form [name='description']").val(result.data.description)
                            if(result.data.status == 1){
                                $('#assembly_child_form .status_switch').bootstrapSwitch('state',true);
                            }else{
                                $('#assembly_child_form .status_switch').bootstrapSwitch('state',false);
                            }
                        }else{
                            ToastrMsg(result.data,"warning","topRight");
                        }
                    })
            }else{
                ToastrMsg("抱歉! 未获取到你需要的信息.","error","topRight");
            }
        })
    }
    /**
     * 显示属性列表
     * @param AssemblyList
     */
    var showAssemblyList = function(parent,AssemblyList){
        var _html = '';
        if(AssemblyList != ''){
            $.each(AssemblyList, function (i, n) {
                if(n.id === parent){
                    $("#assembly_form [name='name']").val(n.name);
                    $("#assembly_form [name='maintainCycle']").val(n.maintainCycle)
                    $("#assembly_form [name='maintainClear']").val(n.maintainClear)
                    $("#assembly_form [name='id']").val(n.id);
                    $("#assembly_form [name='sortId']").val(n.sortId);
                    $('#assembly_form [name="status"]').val(n.status);
                    $('#assembly_form [name="dicTeaAttr"]').val(n.dic_tea_attr);
                    $("#assembly_form [name='description']").val(n.description);
                    if(n.status == 1){
                        $('#assembly_form .status_switch').bootstrapSwitch('state',true);
                    }else{
                        $('#assembly_form .status_switch').bootstrapSwitch('state',false);
                    }
                }else{
                    _html += "<tr><td>"+n.unitName+"</td>";
                    _html += "<td>"+n.unitType+"</td>";
                    _html += "<td>"+n.unitNo+"</td>";
                    _html += "<td>运行"+n.unitCycle+"次</td>";
                    _html += "<td>运行"+n.unitClear+"次</td>";
                    _html += "<td>已运行"+n.allRunNum+"次</td>";
                    _html += '<td><span class="m-badge ' + status[n.status].class + ' m-badge--wide">' + status[n.status].title + '</span></td>';
                    _html += '<td>'+actionsTemplate.replace(/#rowId#/g, n.id)+'</td>';
                    _html += "</tr>";
                }
            });
        }
        if(_html == ""){
            _html = "<tr><th colspan='8' scope=\"row\" style='text-align:center'> 未找到相关属性信息！</th>";
        }
        $(".assembly_list").html(_html);
    }

    /**
     * 删除字典属性
     */
    var delAssemblyItem = function(){
        $(".assembly_list ").on("click", ".delAssemblyItem", function () {
            blockUiOpen('.Assembly_data_list');
            var self = $(this);
            var id = self.attr("item");
            if(id != ""){
                request(
                    "delAssemblySetItem",
                    'post',
                    {id:id},
                    function (result) {
                        if(result.message){
                            self.parents("tr").remove();
                            ToastrMsg(result.data,"success","topRight",".Assembly_data_list");
                        }else{
                            ToastrMsg(result.data,"warning","topRight");
                        }
                    })
            }
        })
    }

    /**
     * 删除父级属性
     */
    var delParentAssembly = function () {
        $(".delParentAssembly ").on("click", function () {
            blockUiOpen('.Assembly_data_list');
            var id = $("#Assembly_form [name='id']").val();
            if(id != ""){
                request(
                    "delParentAssembly",
                    'post',
                    {id:id},
                    function (result) {
                        if(result.message){
                            ToastrMsg(result.data,"success","topRight",".Assembly_data_list");
                            location.reload()
                        }else{
                            ToastrMsg(result.data,"warning","topRight");
                        }
                    })
            }
        })
    }
    /**
     * 模拟点击加载 AJAX 数据
     */
    var reloadDataList = function(){
        $(".radio_role input[type='radio']:checked").click();
    }
    /**
     * 重置 modal 表单
     */
    var removeValue = function(formAttrIbute, type, modalTitle,parentId,showElemt){
        if(type == 'edit'){
            $(formAttrIbute + " .modal-title").text(modalTitle);
            $(formAttrIbute + " [name='save']").val('edit');
            $(".reset-btn").addClass("m--hide");
        }else{
            $(formAttrIbute + " .modal-title").text(modalTitle);
            $(formAttrIbute + " [name='save']").val('add');
            $(".reset-btn").removeClass("m--hide");
        }
        $(formAttrIbute + " [name='id']").val('')
        $(formAttrIbute + " [name='name']").val('')
        $(formAttrIbute + " [name='maintainCycle']").val('')
        $(formAttrIbute + " [name='maintainClear']").val('')
        $(formAttrIbute + " [name='sortId']").val('')
        $(formAttrIbute + " [name='status']").val(2)
        $(formAttrIbute + " [name='parentId']").val(parentId)
        $(formAttrIbute + " [name='description']").val('');
        $("#assembly_child_form [name='machineId']").show();
        $("#machineId").hide()
        $(formAttrIbute + " .form-control-feedback").remove();
        $(formAttrIbute + " div").removeClass("has-danger");
        $(formAttrIbute + " div").removeClass("has-success");
        $(formAttrIbute + " .m-alert").addClass("m--hide");
        $(formAttrIbute + " .status_switch").bootstrapSwitch('state',false);
    }

    /**
     * 新增生产线
     */
    var addAssemblySetEditParent = function () {
        $(".addAssemblySetEditParent").on('click',function () {
            removeValue('#assembly_parent_form','add','',"10000000-0000-0000-0000-000000000000")
        })
    }
    
    /**
     * 新生产线和绑定设备
     */
    var addAssembly = function(){
        $(".editAssemblyItem").on("click",function(){
            var type = $(this).attr("data-type");
            if(type == "add_child"){
                var parentId = $(".radio_role input[type='radio']:checked").val();
                removeValue('.assemblySetEditModal','add','绑定设备',parentId,type)
            }else{
                removeValue('.assemblySetEditModal','add','新增生产线',"",type)
            }
        })
    }
    return {
        init: function () {
            addAssembly()
            AssemblyForm();
            delAssemblyItem();
            AssemblyChildForm();
            delParentAssembly();
            getAssemblyChildItem();
            getAssemblyValueListInfo();
            addAssemblySetEditParent();
        }
    };
}();


jQuery(document).ready(function() {
    Assembly.init();
    /**
     * 选中第一个 radio
     */
    $(".first-radio").click()
    $('.status_switch').bootstrapSwitch();
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