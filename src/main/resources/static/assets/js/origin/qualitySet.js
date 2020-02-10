var QualitySet = function () {
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
    //字典父级验证
    var QualitySetForm = function () {
        $(".quality_set_form_save").on('click',function(){
            checkFormValidate('#quality_set_form')
        })
    }
    //字典子级属性验证
    var QualitySetChildForm = function(){
        $(".quality_set_child_form_save").on('click',function(){
            checkFormValidate('#quality_set_child_form')
        })
    }
    // 表单验证
    var checkFormValidate = function(formAttrIbuteID){
        $( formAttrIbuteID ).validate({
            rules: {
                name: {
                    required: true,
                    nameCheck:true
                },
                sortId: {
                    required: true,
                    digits: true
                },
                value: {
                    required: true,
                    alphanumerical:true
                },
                description: {
                    nameCheck:true
                }
            },
            submitHandler: function (form){
                request(
                    "saveQualitySetOrUpdate",
                    "post",
                    $(formAttrIbuteID).serialize(),
                    function(result){
                        if(result.message){
                            ToastrMsg(result.data,"success","topRight",'.qualitySetEdit .modal-content',"reload",true);
                        }else{
                            ToastrMsg(result.data,"error","topRight",'.qualitySetEdit .modal-content');
                        }
                    }
                )
            }
        });
    }
    /**
     * 获取当前选中字典的属性列表
     */
    var getQualitySetValueListInfo = function () {
        $(".m-widget4__item").on('click', '[type=\'radio\']', function () {
            var id = $(this).val();
            request(
                'getQualitySetValueList',
                'get',
                {parentId: id},
                function (result) {
                    if (result.message) {
                        showQualitySetList(id,result.data)
                    }else{
                        ToastrMsg(result.data,"warning","topRight");
                    }
                })
        })
    }
    /**
     * 编辑 字典子级 属性信息
     * 点击属性管理列表 编辑按钮 get id
     */
    var getQualitySetChildItem = function(){
        $(".quality_set_list ").on("click", ".editQualitySetItem", function () {
            removeValue('.qualitySetEdit','edit','属性编辑',null)
            var id = $(this).attr("item");
            if(typeof id !== 'undefined' && id != ""){
                request(
                    "getQualitySetItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            $("#quality_set_child_form [name='name']").val(result.data.name)
                            $("#quality_set_child_form [name='value']").val(result.data.value).attr("disabled",true)
                            $("#quality_set_child_form [name='id']").val(result.data.id)
                            $("#quality_set_child_form [name='sortId']").val(result.data.sortId)
                            $('#quality_set_child_form [name="status"]').val(result.data.status)
                            $("#quality_set_child_form [name='description']").val(result.data.description)
                            if(result.data.status == 1){
                                $('#quality_set_child_form .status_switch').bootstrapSwitch('state',true);
                            }else{
                                $('#quality_set_child_form .status_switch').bootstrapSwitch('state',false);
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
     * @param QualitySetList
     */
    var showQualitySetList = function(parent,QualitySetList){
        var _html = '';
        if(QualitySetList != ''){
            $.each(QualitySetList, function (i, n) {
                if(n.id === parent){
                    $("#quality_set_form [name='name']").val(n.name);
                    $("#quality_set_form [name='value']").val(n.value).attr("disabled",true);
                    $("#quality_set_form [name='id']").val(n.id);
                    $("#quality_set_form [name='sortId']").val(n.sortId);
                    $('#quality_set_form [name="status"]').val(n.status);
                    $("#quality_set_form [name='description']").val(n.description);
                    if(n.status == 1){
                        $('#quality_set_form .status_switch').bootstrapSwitch('state',true);
                    }else{
                        $('#quality_set_form .status_switch').bootstrapSwitch('state',false);
                    }
                }else{
                    _html += "<tr><th scope=\"row\">"+n.sortId+"</th>";
                    _html += "<td>"+n.name+"</td>";
                    _html += "<td>"+n.value+"</td>";
                    _html += '<td><span class="m-badge ' + status[n.status].class + ' m-badge--wide">' + status[n.status].title + '</span></td>';
                    _html += '<td>'+actionsTemplate.replace(/#rowId#/g, n.id)+'</td>';
                    _html += "</tr>";
                }
            });
        }
        if(_html == ""){
            _html = "<tr><th colspan='5' scope=\"row\" style='text-align:center'> 未找到相关属性信息！</th>";
        }
        $(".quality_set_list").html(_html);
    }

    /**
     * 删除字典属性
     */
    var delQualitySetItem = function(){
        $(".quality_set_list ").on("click", ".delQualitySetItem", function () {
            blockUiOpen('.quality_set_data_list');
            var self = $(this);
            var id = self.attr("item");
            if(id != ""){
                request(
                    "delQualitySetItem",
                    'post',
                    {id:id},
                    function (result) {
                        if(result.message){
                            self.parents("tr").remove();
                            ToastrMsg(result.data,"success","topRight",".quality_set_data_list");
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
    var delParentQualitySet = function () {
        $(".delParentQualitySet ").on("click", function () {
            blockUiOpen('.quality_set_data_list');
            var id = $("#quality_set_form [name='id']").val();
            if(id != ""){
                request(
                    "delParentQualitySet",
                    'post',
                    {id:id},
                    function (result) {
                        if(result.message){
                            ToastrMsg(result.data,"success","topRight",".quality_set_data_list");
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
    var removeValue = function(formAttrIbute, type, modalTitle,parentId){
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
        $(formAttrIbute + " [name='value']").val('').attr("disabled",false)
        $(formAttrIbute + " [name='sortId']").val('')
        $(formAttrIbute + " [name='status']").val('')
        $(formAttrIbute + " [name='parentId']").val(parentId)
        $(formAttrIbute + " [name='description']").val('');
        $(formAttrIbute + " .form-control-feedback").remove();
        $(formAttrIbute + " div").removeClass("has-danger");
        $(formAttrIbute + " div").removeClass("has-success");
        $(formAttrIbute + " .m-alert").addClass("m--hide");
        $(formAttrIbute + " .status_switch").bootstrapSwitch('state',false);
    }

    /**
     * 新增字典和属性
     */
    var addQualitySet = function(){
        $(".editQualitySetItem").on("click",function(){
            var type = $(this).attr("data-type");
            if(type == "add_quality_set_child"){
                var parentId = $(".radio_role input[type='radio']:checked").val();
                removeValue('.qualitySetEdit','add','新增属性',parentId)
            }else{
                removeValue('.qualitySetEdit','add','新增字典')
            }

        })
    }
    return {
        init: function () {
            addQualitySet()
            QualitySetForm();
            delQualitySetItem();
            QualitySetChildForm();
            delParentQualitySet();
            getQualitySetChildItem();
            getQualitySetValueListInfo();
        }
    };
}();


jQuery(document).ready(function() {
    QualitySet.init();
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