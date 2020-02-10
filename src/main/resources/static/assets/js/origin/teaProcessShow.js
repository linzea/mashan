var TeaProcessShow = function () {
    var status = {
        1: {'title': '进行中', 'class': ' m-badge--warning'},
        3: {'title': '终止', 'class': ' m-badge--danger'},
        2: {'title': '完成', 'class': ' m-badge--success'}
    };
    var quality = {
        0: {'title':'未检', 'class':'m-badge--warning'},
        1: {'title':'合格', 'class':'m-badge--success'},
        2: {'title':'不合格', 'class':'m-badge--danger'}
    };
    var tmpName = {
        teaGplantYear: {'title':'年'},
        teaGacreage: {'title':'亩'},
        teaGageLimit: {'title':'年'},
        hrRecQuantity: {'title':'斤'},
        mCreateYear: {'title': '年'}
    };
    /**
     * 获取加工流程数据
     */
    var getTeaProcess = function () {
        $(".tableText").text("--");
        $(".getTeaProcessInfo").on("click", ".getTeaProcess", function () {
            removeTbaleText()
            var id = $(this).attr("item"),
                queryType = $(this).attr("queryType");
            if(id != ""){
                request(
                    "/system/teaProcess/getTeaProcess",
                    'post',
                    {id:id,queryType:queryType},
                    function (result) {
                        if(result.message && result.data.length > 0){
                            $.each(result.data,function (i,n) {
                                if (n.dataTypeName == 'teaGardenManagerlist'){
                                    showTablesTextItem(n);
                                }else if (n.dataTypeName == 'teaGardenLoglist'){
                                    showTeaGardenLog(n);
                                }else if (n.dataTypeName == 'teaMachinTeaList'){
                                    showMachinTeaList(n);
                                }else if (n.dataTypeName == 'productQuality'){
                                    $("."+n.dataTypeName).removeClass("m--hide")
                                    showQualityList(n)
                                }else if (n.dataTypeName == 'semiFinished'){
                                    $("."+n.dataTypeName).removeClass("m--hide")
                                    showSemiFinishedList(n)
                                }else if (n.dataTypeName == 'finishedInOrOut'){
                                    $("."+n.dataTypeName).removeClass("m--hide")
                                    showFinishedList(n)
                                }
                            })
                        }else{
                            ToastrMsg(result.data,"error","topRight");
                        }
                    }
                )
            }
        })
    }
    /**
     * 使用数组键名匹配元素输出显示值单项结果
     * @param data
     */
    var showTablesTextItem = function (data) {
        var title = "";
        if (data != ''){
            for(var tmp in data){
                if (typeof tmpName[tmp] !== 'undefined'){
                    title = tmpName[tmp].title
                }else{
                    title = "";
                }
                $("."+data.dataTypeName+" #"+tmp).text(data[tmp] +" "+title)
            }
        }else{
            ToastrMsg("获取茶园数据异常.","error","topRight");
        }

    }

    /**
     * 显示茶园日志
     */
    var showTeaGardenLog = function (data) {
        if (data != ''){
            $("#"+data.farmValue).removeClass("m--hide")
            if (data.farmValue == 'reclaim'){
                var reclaimTemple = '<tr><td scope="row"> 开垦编号:</td>' +
                    '<td >'+data.fert_variety+'</td>' +
                    '<td scope="row"> 开垦面积:</td>\n' +
                    '<td >'+data.farm_quantity+'</td>\n' +
                    '<td scope="row"> 操作人:</td>\n' +
                    '<td >'+data.operator_id+'</td>\n' +
                    '<td scope="row"> 负责人:</td>\n' +
                    '<td >'+data.principal+'</td>\n' +
                    '</tr>';
                $(".reclaimTbody").append(reclaimTemple);
            }
            if (data.farmValue == 'plough'){
                var ploughTemple ='<tr>' +
                    '<td scope="row"> 耕地面积:</td>\n' +
                    '<td >'+data.farm_quantity+'</td>\n' +
                    '<td scope="row"> 操作人:</td>\n' +
                    '<td >'+data.operator_id+'</td>\n' +
                    '<td scope="row"> 负责人:</td>\n' +
                    '<td >'+data.principal+'</td>\n' +
                    '</tr>';
                $(".ploughTbody").append(ploughTemple);
            }
            if (data.farmValue == 'seed'){
                var ploughTemple ='<tr>' +
                    '<td scope="row"> 品种:</td>\n' +
                    '<td >'+data.d3Name+'</td>\n' +
                    '<td scope="row"> 种子来源:</td>\n' +
                    '<td >'+data.d4Name+'</td>\n' +
                    '<td scope="row"> 面积:</td>\n' +
                    '<td >'+data.farm_quantity+'</td>\n' +
                    '<td scope="row"> 负责人:</td>\n' +
                    '<td >'+data.principal+'</td>\n' +
                    '</tr>';
                $(".seedTbody").append(ploughTemple);
            }
            if (data.farmValue == 'fertilizer'){
                var ploughTemple ='<tr>' +
                    '<td scope="row"> 肥料品种:</td>\n' +
                    '<td >'+data.d4Name+'</td>\n' +
                    '<td scope="row"> 施肥方式:</td>\n' +
                    '<td >'+data.d2Name+'</td>\n' +
                    '<td scope="row"> 肥料用量:</td>\n' +
                    '<td >'+data.farm_quantity+'</td>\n' +
                    '<td scope="row"> 负责人:</td>\n' +
                    '<td >'+data.principal+'</td>\n' +
                    '</tr>';
                $(".fertilizerTbody").append(ploughTemple);
            }
            if (data.farmValue == 'weeding'){

                var ploughTemple ='<tr>' +
                    '<td scope="row"> 除草方式:</td>\n' +
                    '<td >'+data.farm_quantity+'</td>\n' +
                    '<td scope="row"> 除草用量:</td>\n' +
                    '<td >'+data.operator_id+'</td>\n' +
                    '<td scope="row"> 负责人:</td>\n' +
                    '<td >'+data.principal+'</td>\n' +
                    '</tr>';
                $(".weedingTbody").append(ploughTemple);
            }
            if (data.farmValue == 'insecticide'){
                var ploughTemple ='<tr>' +
                    '<td scope="row"> 治虫方式:</td>\n' +
                    '<td >'+data.d2Name+'</td>\n' +
                    '<td scope="row"> 防治对象:</td>\n' +
                    '<td >'+data.fert_variety+'</td>\n' +
                    '<td scope="row"> 负责人:</td>\n' +
                    '<td >'+data.principal+'</td>\n' +
                    '</tr>';
                $(".insecticideTbody").append(ploughTemple);
            }
            if (data.farmValue == 'irrigate'){
                var ploughTemple ='<tr>' +
                    '<td scope="row"> 灌溉方式:</td>\n' +
                    '<td >'+data.d2Name+'</td>\n' +
                    '<td scope="row"> 负责人:</td>\n' +
                    '<td >'+data.principal+'</td>\n' +
                    '</tr>';
                $(".irrigateTbody").append(ploughTemple);
            }
        }else{
            ToastrMsg("获取茶园日志数据异常.","error","topRight");
        }
    }
    /**
     * 显示茶叶加工数据
     */
    var showMachinTeaList = function (data) {
        var temple = "";
        if (data != ''){
            if (data.dicMacValue == 'wither'){
                $("#teaMachinTeaListTable").removeClass("m--hide")
                 temple = '<tr><td>'+data.proName+'</td>' +
                    '<td >'+data.pick_batch_no+'</td>' +
                    '<td scope="row">'+data.macTypeName+'</td>\n' +
                    '<td >'+data.teaTypeName+'</td>\n' +
                    '<td scope="row">'+data.teaAttrName+'</td>\n' +
                    '<td >'+data.lostTime+'</td>\n' +
                    '<td scope="row">'+data.temperature+'&#8451;</td>\n' +
                    '<td scope="row">'+data.principal+'</td>\n' +
                    '<td >'+status[data.status].title+'</td>\n' +
                    '</tr>';
                $("#teaMachinTeaListTemp").append(temple);
            }
            if (data.dicMacValue == 'killOut'){
                $("#teaMachinTeaListTable").removeClass("m--hide")
                temple = '<tr><td>'+data.proName+'</td>' +
                    '<td >'+data.pick_batch_no+'</td>' +
                    '<td scope="row">'+data.macTypeName+'</td>\n' +
                    '<td >'+data.teaTypeName+'</td>\n' +
                    '<td scope="row">'+data.teaAttrName+'</td>\n' +
                    '<td >'+data.lostTime+'</td>\n' +
                    '<td scope="row">'+data.temperature+'&#8451;</td>\n' +
                    '<td scope="row">'+data.principal+'</td>\n' +
                    '<td >'+status[data.status].title+'</td>\n' +
                    '</tr>';
                $("#teaMachinTeaListTemp").append(temple);
            }
            if (data.dicMacValue == 'rolling'){
                $("#teaMachinTeaListTable").removeClass("m--hide")
                temple = '<tr><td>'+data.proName+'</td>' +
                    '<td >'+data.pick_batch_no+'</td>' +
                    '<td scope="row">'+data.macTypeName+'</td>\n' +
                    '<td >'+data.teaTypeName+'</td>\n' +
                    '<td scope="row">'+data.teaAttrName+'</td>\n' +
                    '<td >'+data.lostTime+'</td>\n' +
                    '<td scope="row">'+data.temperature+'&#8451;</td>\n' +
                    '<td scope="row">'+data.principal+'</td>\n' +
                    '<td >'+status[data.status].title+'</td>\n' +
                    '</tr>';
                $("#teaMachinTeaListTemp").append(temple);
            }
            if (data.dicMacValue == 'fermentation'){
                $("#teaMachinTeaListTable").removeClass("m--hide")
                temple = '<tr><td>'+data.proName+'</td>' +
                    '<td >'+data.pick_batch_no+'</td>' +
                    '<td scope="row">'+data.macTypeName+'</td>\n' +
                    '<td >'+data.teaTypeName+'</td>\n' +
                    '<td scope="row">'+data.teaAttrName+'</td>\n' +
                    '<td >'+data.lostTime+'</td>\n' +
                    '<td scope="row">'+data.temperature+'&#8451;</td>\n' +
                    '<td scope="row">'+data.principal+'</td>\n' +
                    '<td >'+status[data.status].title+'</td>\n' +
                    '</tr>';
                $("#teaMachinTeaListTemp").append(temple);
            }
            if (data.dicMacValue == 'dryTea'){
                $("#teaMachinTeaListTable").removeClass("m--hide")
                temple = '<tr><td>'+data.proName+'</td>' +
                    '<td >'+data.pick_batch_no+'</td>' +
                    '<td scope="row">'+data.macTypeName+'</td>\n' +
                    '<td >'+data.teaTypeName+'</td>\n' +
                    '<td scope="row">'+data.teaAttrName+'</td>\n' +
                    '<td >'+data.lostTime+'</td>\n' +
                    '<td scope="row">'+data.temperature+'&#8451;</td>\n' +
                    '<td scope="row">'+data.principal+'</td>\n' +
                    '<td >'+status[data.status].title+'</td>\n' +
                    '</tr>';
                $("#teaMachinTeaListTemp").append(temple);
            }
            if (data.dicMacValue == 'filtrate'){
                $("#teaMachinTeaFinishedTable").removeClass("m--hide")
                temple = '<tr><td>'+data.proName+'</td>' +
                    '<td >'+data.pick_batch_no+'</td>' +
                    '<td scope="row">'+data.macTypeName+'</td>\n' +
                    '<td >'+data.teaTypeName+'</td>\n' +
                    '<td scope="row">'+data.teaAttrName+'</td>\n' +
                    '<td >'+data.teaGradeOne+'斤</td>\n' +
                    '<td scope="row">'+data.teaGradeTwo+'斤</td>\n' +
                    // '<td scope="row">'+data.teaGradeThree+'斤</td>\n' +
                    '<td >'+data.lostTime+'</td>\n' +
                    '<td scope="row">'+data.temperature+'&#8451;</td>\n' +
                    '<td scope="row">'+data.principal+'</td>\n' +
                    '<td >'+status[data.status].title+'</td>\n' +
                    '</tr>';
                $("#teaMachinTeaFinishedTemp").append(temple);
            }
            if (data.dicMacValue == 'roasting'){
                $("#teaMachinTeaFinishedTable").removeClass("m--hide")
                temple = '<tr><td>'+data.proName+'</td>' +
                    '<td >'+data.pick_batch_no+'</td>' +
                    '<td scope="row">'+data.macTypeName+'</td>\n' +
                    '<td >'+data.teaTypeName+'</td>\n' +
                    '<td scope="row">'+data.teaAttrName+'</td>\n' +
                    '<td >'+data.teaGradeOne+'斤</td>\n' +
                    '<td scope="row">'+data.teaGradeTwo+'斤</td>\n' +
                    '<td >'+data.lostTime+'</td>\n' +
                    '<td scope="row">'+data.temperature+'&#8451;</td>\n' +
                    '<td scope="row">'+data.principal+'</td>\n' +
                    '<td >'+status[data.status].title+'</td>\n' +
                    '</tr>';
                $("#teaMachinTeaFinishedTemp").append(temple);
            }
            if (data.dicMacValue == 'titian'){
                $("#teaMachinTeaFinishedTable").removeClass("m--hide")
                temple = '<tr><td>'+data.proName+'</td>' +
                    '<td >'+data.pick_batch_no+'</td>' +
                    '<td scope="row">'+data.macTypeName+'</td>\n' +
                    '<td >'+data.teaTypeName+'</td>\n' +
                    '<td scope="row">'+data.teaAttrName+'</td>\n' +
                    '<td >'+data.teaGradeOne+'斤</td>\n' +
                    '<td scope="row">'+data.teaGradeTwo+'斤</td>\n' +
                    '<td >'+data.lostTime+'</td>\n' +
                    '<td scope="row">'+data.temperature+'&#8451;</td>\n' +
                    '<td scope="row">'+data.principal+'</td>\n' +
                    '<td >'+status[data.status].title+'</td>\n' +
                    '</tr>';
                $("#teaMachinTeaFinishedTemp").append(temple);
            }
            if (data.dicMacValue == 'packaing'){
                $("#teaMachinTeaFinishedTable").removeClass("m--hide")
                temple = '<tr><td>'+data.proName+'</td>' +
                    '<td >'+data.pick_batch_no+'</td>' +
                    '<td scope="row">'+data.macTypeName+'</td>\n' +
                    '<td >'+data.teaTypeName+'</td>\n' +
                    '<td scope="row">'+data.teaAttrName+'</td>\n' +
                    '<td >'+data.teaGradeOne+'斤</td>\n' +
                    '<td scope="row">'+data.teaGradeTwo+'斤</td>\n' +
                    '<td >'+data.lostTime+'</td>\n' +
                    '<td scope="row">'+data.temperature+'&#8451;</td>\n' +
                    '<td scope="row">'+data.principal+'</td>\n' +
                    '<td >'+status[data.status].title+'</td>\n' +
                    '</tr>';
                $("#teaMachinTeaFinishedTemp").append(temple);
            }

        }else{
            ToastrMsg("获取茶叶加工数据异常.","error","topRight");
        }
    }

    /**
     * 显示质检数据
     */
    var showQualityList = function (data) {
        var temple = "",qualityUser = "",machinName="";
        if(typeof data.qualityUser !== 'undefined'){
            qualityUser = data.qualityUser;
        }else{
            qualityUser = "--";
        }
        if(typeof data.machinName !== 'undefined'){
            machinName = data.machinName;
        }else{
            machinName = "随机";
        }
        if (data != ''){
                temple = '<tr><td>'+data.qualityType+'</td>' +
                    '<td >'+data.pickBatchNo+'</td>' +
                    '<td scope="row">'+machinName+'</td>\n' +
                    '<td >'+data.teaTypeName+'</td>\n' +
                    '<td scope="row">'+data.teaAttrName+'</td>\n' +
                    '<td scope="row">'+qualityUser+'</td>\n' +
                    '<td >'+quality[data.qualityStatus].title+'</td>\n' +
                    '</tr>';
            $("#productQualityTmpl").append(temple);
        }else{
            ToastrMsg("获取质检数据异常.","error","topRight");
        }
    }

    /**
     * 显示半成品库存数据
     */
    var showSemiFinishedList = function (data) {
        var temple = "";
        if (data != ''){
            temple = '<tr><td>'+data.pickBatchNo+'</td>' +
                '<td >'+data.teaAttrName+'</td>' +
                '<td scope="row">'+data.teaTypeName+'</td>\n' +
                '<td scope="row">'+data.recQuantity+'斤</td>\n' +
                '<td >'+data.teaGradeOne+'斤</td>' +
                '<td scope="row">'+Number(data.teaGradeOne-data.semiOneOut)+'斤</td>\n' +
                '<td >'+data.teaGradeTwo+'斤</td>' +
                '<td scope="row">'+Number(data.teaGradeTwo-data.semiTwoOut)+'斤</td>\n' +
                '<td scope="row">'+data.principal+'</td>\n' +
                '</tr>';
            $("#semiFinishedTmpl").append(temple);
        }else{
            ToastrMsg("获取半成品数据异常.","error","topRight");
        }
    }
    /**
     * 显示成品库存信息
     */
    var showFinishedList = function (data) {
        var temple = "";
        if (data != ''){
            temple = '<tr><td>'+data.pickBatchNo+'</td>' +
                '<td >'+data.typeTeaName+'</td>' +
                '<td >'+data.attrName+'</td>' +
                '<td scope="row">'+data.typeName+'</td>\n' +
                '<td >'+data.finishedQuantity+'件</td>' +
                '<td scope="row">'+data.finishedOut+'件</td>\n' +
                '<td scope="row">'+Number(data.finishedQuantity-data.finishedOut)+'件</td>\n' +
                '<td scope="row">'+data.principal+'</td>\n' +
                '</tr>';
            $("#finishedTmpl").append(temple);
        }else{
            ToastrMsg("获取半成品数据异常.","error","topRight");
        }
    }
    /**
     * 重置tables
     */
    var removeTbaleText = function(){
        $("#teaGardenLoglist tbody").html("");
        $("#teaMachinTeaListTemp").html("");
        $("#productQualityTmpl").html("");
        $("#teaMachinTeaFinishedTemp").html("");
        $("#finishedTmpl").html("");
        $("#semiFinishedTmpl").html("");
        $("#reclaim").addClass("m--hide");
        $("#plough").addClass("m--hide");
        $("#seed").addClass("m--hide");
        $("#fertilizer").addClass("m--hide");
        $("#weeding").addClass("m--hide");
        $("#insecticide").addClass("m--hide");
        $("#irrigate").addClass("m--hide");
    }
    
    var teaProcessPrint = function () {
        $(".teaProcessPrint").on("click",function () {
            $.print(".tab-content")
        })
    }
    return {
        init: function () {
            getTeaProcess();
            teaProcessPrint();
        }
    };
}();
jQuery(document).ready(function () {
    TeaProcessShow.init();
});