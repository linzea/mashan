var Dictionary = function () {
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
    var dictionaryForm = function () {
        $(".dictionary_form_save").on('click',function(){
            checkFormValidate('#dictionary_form')
        })
    }
    //字典子级属性验证
    var dictionaryChildForm = function(){
        $(".dictionary_child_form_save").on('click',function(){
            checkFormValidate('#dictionary_child_form')
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
                    required: true
                }
            },
            submitHandler: function (form){
                request(
                    "saveDictionaryOrUpdate",
                    "post",
                    $(formAttrIbuteID).serialize(),
                    function(result){
                        if(result.message){
                            blockUiClose('.dictionaryEdit .modal-content',1,".close-parent",0);
                            ToastrMsg(result.data,"success","topRight");
                            reloadDataList()
                        }else{
                            ToastrMsg(result.data,"error","topRight");
                        }
                    }
                )
            }
        });
    }
    /**
     * 获取当前选中字典的属性列表
     */
    var getDictionaryValueListInfo = function () {
        $(".m-widget4__item").on('click', '[type=\'radio\']', function () {
            var id = $(this).val();
            request(
                'getDictionaryValueList',
                'get',
                {parentId: id},
                function (result) {
                    if (result.message) {
                        showDictionaryList(id,result.data)
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
    var getDictionaryChildItem = function(){
        $(".dictionary_list ").on("click", ".editDictionaryItem", function () {
            removeValue('.dictionaryEdit','edit','属性编辑',null)
            var id = $(this).attr("item");
            if(typeof id !== 'undefined' && id != ""){
                request(
                    "getDictionaryItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            $("#dictionary_child_form [name='name']").val(result.data.name)
                            $("#dictionary_child_form [name='value']").val(result.data.value).attr("disabled",true)
                            $("#dictionary_child_form [name='id']").val(result.data.id)
                            $("#dictionary_child_form [name='sortId']").val(result.data.sortId)
                            $('#dictionary_child_form [name="status"]').val(result.data.status)
                            $("#dictionary_child_form [name='description']").val(result.data.description)
                            if(result.data.status == 1){
                                $('#dictionary_child_form .status_switch').bootstrapSwitch('state',true);
                            }else{
                                $('#dictionary_child_form .status_switch').bootstrapSwitch('state',false);
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
     * @param dictionaryList
     */
    var showDictionaryList = function(parent,dictionaryList){
        var _html = '';
        if(dictionaryList != ''){
            $.each(dictionaryList, function (i, n) {
                if(n.id === parent){
                    $("#dictionary_form [name='name']").val(n.name);
                    $("#dictionary_form [name='value']").val(n.value).attr("disabled",true);
                    $("#dictionary_form [name='id']").val(n.id);
                    $("#dictionary_form [name='sortId']").val(n.sortId);
                    $('#dictionary_form [name="status"]').val(n.status);
                    $("#dictionary_form [name='description']").val(n.description);
                    if(n.status == 1){
                        $('#dictionary_form .status_switch').bootstrapSwitch('state',true);
                    }else{
                        $('#dictionary_form .status_switch').bootstrapSwitch('state',false);
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
        $(".dictionary_list").html(_html);
    }

    /**
     * 删除字典属性
     */
    var delDictionaryItem = function(){
        $(".dictionary_list ").on("click", ".delDictionaryItem", function () {
            blockUiOpen('.dictionary_data_list');
            var self = $(this);
            var id = self.attr("item");
            if(id != ""){
                request(
                    "delDictionaryItem",
                    'post',
                    {id:id},
                    function (result) {
                        if(result.message){
                            self.parents("tr").remove();
                            ToastrMsg(result.data,"success","topRight",".dictionary_data_list");
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
    var delParentDictionary = function () {
        $(".delParentDictionary ").on("click", function () {
            blockUiOpen('.dictionary_data_list');
            var id = $("#dictionary_form [name='id']").val();
            if(id != ""){
                request(
                    "delParentDictionary",
                    'post',
                    {id:id},
                    function (result) {
                        if(result.message){
                            ToastrMsg(result.data,"success","topRight",".dictionary_data_list");
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
    var addDictionary = function(){
        $(".editDictionaryItem").on("click",function(){
            var type = $(this).attr("data-type");
            if(type == "add_dictionary_child"){
                var parentId = $(".radio_role input[type='radio']:checked").val();
                removeValue('.dictionaryEdit','add','新增属性',parentId)
            }else{
                removeValue('.dictionaryEdit','add','新增字典')
            }

        })
    }
    return {
        init: function () {
            addDictionary()
            dictionaryForm();
            delDictionaryItem();
            dictionaryChildForm();
            delParentDictionary();
            getDictionaryChildItem();
            getDictionaryValueListInfo();
        }
    };
}();


jQuery(document).ready(function() {
    Dictionary.init();
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