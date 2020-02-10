var Quality = function () {
    var status = {
        0: {'title':'未检', 'class':'m-badge--warning'},
        1: {'title':'合格', 'class':'m-badge--success'},
        2: {'title':'不合格', 'class':'m-badge--danger'}
    };
    var actionsTemplate = $("#actionsTemplate").html();
    var QualityShow = function () {
        var option = {
            data: {
                type: 'remote',
                source: {
                    read: {
                        url: 'getQualityDataList'
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
                {field: "pickBatchNo", title: "鲜叶批次", width: 120},
                {field: "machinName", title: "质检阶段", width: 60,
                    template: function (row) {
                        return typeof row.machinName !== 'undefined' ? row.machinName : "随机";
                    }
                },{
                    field: "teaTypeName",
                    title: "品种",
                    overflow: 'hide',
                    width: 60
                },{
                    field: "teaAttrName",
                    title: "茶系",
                    width: 60
                },
                {field: "qualityType", title: "质检类型", width: 60},
                {field: "qualityUser", title: "质检人", width: 60,
                    template: function (row) {
                        return typeof row.qualityUser !== 'undefined' ? row.qualityUser : "--";
                    }},
                {field: "samplingBase", title: "取样基数", width: 60,
                    template: function (row) {
                        return row.samplingBase+"/g"
                    }
                },
                {field: "sampleNumber", title: "取样份数", width: 80 ,
                    template: function (row) {
                        return row.sampleNumber+"/份"
                    }
                },
                {
                    field: "qualityStatus",
                    title: "质检结果", width: 60,
                    template: function (row) {
                        return '<span class="m-badge ' + status[row.qualityStatus].class + ' m-badge--wide">' + status[row.qualityStatus].title + '</span>';
                    }
                },
                {field: "qualityTime", title: "质检时间", width: 140},
                {field: "createUser", title: "记录人", width: 80},
                {
                    field: "Actions",
                    width: 130,
                    title: "操作",
                    sortable: false,
                    overflow: 'visible',
                    template: function (row) {
                        var dropup = (row.getIndex() - row.getIndex()) <= 4 ? 'dropup' : '';
                        return actionsTemplate.replace(/#rowId#/g, row.id);
                    }
                }]
        }
        var datatable = $('.quality_list').mDatatable(option);

        var query = datatable.getDataSourceQuery();

        $('#m_form_search').on('keyup', function (e) {
            var query = datatable.getDataSourceQuery();
            query.generalSearch = $(this).val().toLowerCase();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(query.generalSearch);


        $('#processBatchId').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.processBatchId = $(this).val().toLowerCase();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(typeof query.processBatchId !== 'undefined' ? query.processBatchId : '');

        $('#samplingId').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.samplingId = $(this).val();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(typeof query.samplingId !== 'undefined' ? query.samplingId : '');
        $('.datatableRoload').on('click', function () {
            location.reload()
        });
        $('.select_selectpicker').selectpicker();
    };


    /**
     * 新增与编辑
     */
    var QualityInfoForm = function () {
        $( "#quality_edit_form" ).validate({
            rules: {
                harvestBatchId: {required: true},
                dicQualityType:{required: true},
                samplingBase:{required: true, decimalCheck:true,maxlength:3},
                sampleNumber:{required: true, digits:true,maxlength:1},
                qualityStatus:{required: true},
                qualityUser:{required: true,nameCheck:true},
                qualityTime:{required: true,date:true},
                verifyQuality:{required: true},
                verifyUser:{required: true,nameCheck:true},
                verifyTime:{required: true,date:true},
                netContent:{required: true,decimalCheck:true,maxlength:7},
                teaCrumble:{required: true,decimalCheck:true,maxlength:7},
                waterContent:{required: true,decimalCheck:true,maxlength:7},

                setTeaSoup:{required: true},
                setTenderness:{required: true},
                setBalanceDegree:{required: true},
                setIncense:{required: true},
                setSweetness:{required: true},
                setConcentration:{required: true},
                setDepth:{required: true},
                setPurity:{required: true},
                setTheFresh:{required: true},
            },

            submitHandler: function (form){
                blockUiOpen('.qualityEditModal .modal-content');
                request(
                    "saveOrUpdateQuality",
                    "post",
                    $("#quality_edit_form").serialize(),
                    function(result){
                        if(result.message){
                            ToastrMsg(result.data,"success","topRight",'.qualityEditModal .modal-content',"reload",true);
                        }else{
                            ToastrMsg(result.data,"error","topRight",'.qualityEditModal .modal-content');
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
        $(".qualityEditModal [name='qualityStatus']").attr("disabled",false);
        var createUser = $("#chineseName").text();
        myDropzone.removeAllFiles(true);
        if(type == 'edit'){
            $(".qualityEditModal .modal-title").text("质检编辑");
            $(".qualityEditModal [name='save']").val('edit');
            $(".reset-btn").addClass("m--hide");
        }else{
            $(".qualityEditModal .modal-title").text("质检新增");
            $(".qualityEditModal [name='save']").val('add');
            $(".reset-btn").removeClass("m--hide");
        }
        $(".qualityEditModal [name='id']").val('');
        $(".qualityEditModal [name='qualityUser']").val('');
        $(".qualityEditModal [name='qualityTime']").val('');
        $(".qualityEditModal #createUser").val(createUser).attr("disabled",true);
        $(".qualityEditModal #harvestBatchId").val("").attr("disabled",false);
        $(".qualityEditModal #sampleNumber").val("").attr("disabled",false);
        $(".qualityEditModal #samplingBase").val("").attr("disabled",false);
        $(".qualityEditModal #dicQualityType").val("").attr("disabled",false);
        $(".qualityEditModal [name='qualityUser']").val("").attr("disabled",false);
        $(".qualityEditModal [name='qualityTime']").val("").attr("disabled",false);
        $(".qualityEditModal [name='netContent']").val("").attr("disabled",false);
        $(".qualityEditModal [name='teaCrumble']").val("").attr("disabled",false);
        $(".qualityEditModal [name='waterContent']").val("").attr("disabled",false);
        $(".qualityEditModal [name='qiId']").val("");
        $(".qualityEditModal .setTeaSoup").addClass("m--hide");
        $(".qualityEditModal [name='setTeaSoup']").val("").attr("disabled",true)
        $(".qualityEditModal select").val('').attr("disabled",false);
        $(".qualityEditModal .form-control-feedback").remove();
        $(".qualityEditModal div").removeClass("has-danger")
        $(".qualityEditModal div").removeClass("has-success")
        $(".qualityEditModal [name='qualityStatus'][value='0']").click().attr("disabled",true);//单选-初检
    }

    /**
     * 新增茶园信息
     */
    var addQuality = function () {
        $(".addQuality").on('click',function(){
            removeValue('add')
        })
    }

    /**
     * 获取信息,并移除上一轮错误信息
     */
    var editQualityItem = function () {
        $("#quality_list").on("click", ".editQualityItem", function () {
            removeValue('edit')
            var id = $(this).attr("item");
            if(id != ""){
                request(
                    "getQualityItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            console.log(result)
                            if (result.data.qualityStatus != '0'){
                                $(".qualityEditModal [name='qualityStatus'][value='"+result.data.qualityStatus+"']").click();//单选-初检
                                $(".qualityEditModal input[type='text']").attr("disabled",true);
                                $(".qualityEditModal input[type='radio']").attr("disabled",true);
                            }
                            $(".qualityEditModal .setTeaSoup").addClass("m--hide");
                            $(".qualityEditModal [name='setTeaSoup']").val("").attr("disabled",true)
                            $(".qualityEditModal [name='id']").val(result.data.id);
                            $(".qualityEditModal #harvestBatchId").val(result.data.harvestBatchId).attr("disabled",true);
                            $(".qualityEditModal #sampleNumber").val(result.data.sampleNumber);
                            $(".qualityEditModal #samplingBase").val(result.data.samplingBase);
                            $(".qualityEditModal #dicQualityType").val(result.data.dicQualityType).attr("disabled",true);
                            $(".qualityEditModal [name='qiId']").val(result.data.qiId);
                            $(".qualityEditModal [name='netContent']").val(result.data.netContent);
                            $(".qualityEditModal [name='teaCrumble']").val(result.data.teaCrumble);
                            $(".qualityEditModal [name='sampleTea']").val(result.data.sampleTea);
                            $(".qualityEditModal [name='waterContent']").val(result.data.waterContent);
                            $(".qualityEditModal [name='setTeaSoup']").val(result.data.setTeaSoup);
                            $("#"+result.data.dicTeaAttr).removeClass("m--hide");
                            $("#"+result.data.dicTeaAttr).find("select").attr("disabled",false);
                            $(".qualityEditModal [name='setTenderness']").val(result.data.setTenderness);
                            $(".qualityEditModal [name='setBalanceDegree']").val(result.data.setBalanceDegree);
                            $(".qualityEditModal [name='setIncense']").val(result.data.setIncense);
                            $(".qualityEditModal [name='setSweetness']").val(result.data.setSweetness);
                            $(".qualityEditModal [name='setConcentration']").val(result.data.setConcentration);
                            $(".qualityEditModal [name='setDepth']").val(result.data.setDepth);
                            $(".qualityEditModal [name='setPurity']").val(result.data.setPurity);
                            $(".qualityEditModal [name='setTheFresh']").val(result.data.setTheFresh);
                            $(".qualityEditModal [name='qualityStatus'][value='"+result.data.qualityStatus+"']").click();//单选-初检
                            $(".qualityEditModal [name='qualityUser']").val(result.data.qualityUser);
                            $(".qualityEditModal [name='qualityTime']").val(result.data.qualityTime);
                            $(".qualityEditModal [name='description']").val(result.data.description);
                            $(".qualityEditModal #createUser").val(result.data.createUser);
                            if (result.data.imgUrl){
                                myDropzone.emit("initimage", result.data.imgUrl); //初始化图片
                                $(".qualityEditModal [name='imgUrl']").val(result.data.imgUrl)
                            }
                        }else{
                            ToastrMsg(result.data,"error","topRight");
                        }
                    })
            }
        })
    }

    /**
     * 触发取样单号,获取取样数据
     */
    var getDicTeaAttrData = function(){
        $(".qualityEditModal .harvestBatchId").on("change",function () {
            var harvestBatchId = $(".qualityEditModal .harvestBatchId option:selected").val();
            if (harvestBatchId != "") {
                blockUiOpen('.qualityEditModal .modal-content');
                showTeaSoup(harvestBatchId, '.qualityEditModal .modal-content')
            }
        })
    }


    /**
     * 删除
     */
    var delQualityItem = function () {
        $("#quality_list ").on("click", ".delQualityItem", function () {
            blockUiOpen('#quality_list');
            var self = $(this);
            var id = self.attr("item");
            if(id != ""){
                request(
                    "delQualityItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            self.parents("tr").remove();
                            ToastrMsg(result.data,"success","topRight",'#quality_list');
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#quality_list');
                        }
                    })
            }
        })
    }
    /**
     * 显示鲜叶批次对应的茶系质检数据
     */
    var showTeaSoup = function (harvestBatchId,closeBlockAttr) {

        request(
            "getDicTeaAttrData",
            'get',
            {harvestBatchId:harvestBatchId},
            function (result) {
                if(result.message){
                    console.log(result.data)
                    $(".qualityEditModal .setTeaSoup").addClass("m--hide");
                    $(".qualityEditModal [name='setTeaSoup']").val("").attr("disabled",true)
                    $("#"+result.data).removeClass("m--hide");
                    $("#"+result.data).find("select").attr("disabled",false);
                    blockUiClose(closeBlockAttr,0,".close-parent",0);
                }else{
                    removeValue('add');
                    ToastrMsg(result.data,"error","topRight",closeBlockAttr);
                }
            })

    }

    /**
     * bootstrap datetimepicker 插件
     * 输入时间请先了解单个参数
     */
    var datetimepickerSelect = function () {
        $('.datetimeInput').datetimepicker({
            startDate:new Date(),
            todayHighlight: false,
            autoclose: true,
            sideBySide: false,
            pickerPosition: 'top-left',
            format: 'yyyy-mm-dd hh:mm:ss'
        });
    }

    return {
        init: function () {
            QualityShow();
            addQuality();
            getDicTeaAttrData();
            editQualityItem();
            delQualityItem();
            QualityInfoForm();
            datetimepickerSelect();
        }
    };
}();
jQuery(document).ready(function () {
    Quality.init();
});