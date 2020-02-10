var CreateQrCode = function () {
    var qrcode = new QRCode('qrcode', {
        width: 170,
        height: 170,
        colorDark: '#000000',
        colorLight: '#ffffff',
        correctLevel: QRCode.CorrectLevel.H
    });
    var qrcodeT = new QRCode('qrcodeT', {
        width: 170,
        height: 170,
        colorDark: '#000000',
        colorLight: '#ffffff',
        correctLevel: QRCode.CorrectLevel.H
    });
    /**
     * 获取加工工序，区别设备用途
     */
    var getUnitUsageItem = function () {
        $(".unitUsage").val("");
        $(".createQrCodeParent").on("click", ".createQrCode", function () {
            if (removeTbaleText("finished_out")) {
                $(".qrCodePrint").attr("disabled", true)
                var unitUsage = $(this).attr("item"),
                    machinSetId = $(this).attr("machinSetId"),
                    dicTeaAttr = $(this).attr("dicTeaAttr"),
                    html = "<option value=\"\"> 选择 </option>";
                if (unitUsage != "" && machinSetId != "" && dicTeaAttr != "") {
                    request(
                        "/system/assembly/getAssemblySetDataList",
                        'post',
                        {dicTeaAttr: dicTeaAttr},
                        function (result) {
                            if (result.message) {
                                $.each(result.data, function (i, n) {
                                    html += "<option value=" + n.id + " > " + n.name + "(" + n.attrName + ")</option>";
                                });
                                $(".createQrCodeModal #assembly").html(html)
                                $("#unitUsage").val(unitUsage);
                                $("#machinSetId").val(machinSetId);
                                $("#dicTeaAttrr").val(dicTeaAttr);
                            } else {
                                ToastrMsg("生产线未绑定相应设备信息.", "error", "topRight");
                            }
                        }
                    )
                } else {
                    ToastrMsg("参数异常,不可操作!", "error", "topRight");
                }
            }
        })
    }

    /**
     * 获取设备信息 url 设备管理获取单条信息方法
     */
    var assemblyFun = function () {
        $("#assembly").on("change", function () {
            var assemblId = $("#assembly option:selected").val(),
                unitUsage = $("#unitUsage").val(),
                machinSetId = $("#machinSetId").val(),
                dicTeaAttr = $("#dicTeaAttrr").val();
            if (assemblId != '' && unitUsage != '' && machinSetId != '' && dicTeaAttr != '') {
                request(
                    "/system/createQrCode/getEquipmentData",
                    'post',
                    {id: assemblId, unitUsage: unitUsage, dicTeaAttr: dicTeaAttr},
                    function (result) {
                        if (result.message) {
                            var url = "http://" + window.location.host + "/index/origin/viewAction?assemblId="
                                + assemblId + "&dicTeaAttr=" + dicTeaAttr + "&machinSetId=" + machinSetId
                                + "&machineId=" + result.data[0].id;
                            $("#finishedName").text(result.data[0].unit_name);
                            $("#speThereP").text(result.data[0].unit_type);
                            $("#gradeName").text(result.data[0].attrName);
                            $("#finishedInTime").text(result.data[0].unit_no);
                            $("#createTime").text(result.data[0].create_time.substring(0, 10))
                            $("#createUser").text(result.data[0].createUser)
                            qrcode.makeCode(url);
                            $("#createQrCode").removeClass("m--hide")
                            $("#assemblySelect").addClass("m--hide")
                            $(".qrCodePrint").attr("disabled", false)
                        } else {
                            ToastrMsg("生产线未绑定相应设备信息.", "error", "topRight");
                        }
                    }
                )
            } else {
                ToastrMsg("参数异常,不可操作!", "error", "topRight");
            }
        })
    }

    /**
     * 生成溯源批次二维码 一批一个二维码
     */
    var createOriginBatchQrCode = function () {
        $(".createOriginBatchQrCode").on("click", ".createQrCode", function () {
            var item =  $(this).attr("item");
            if (removeTbaleText("originBatch") && item != "") {
                var url = "http://" + window.location.host + "/index/traceQuery/qrOrigin?item="+item
                qrcodeT.makeCode(url);
            }
        })
    }

    /**
     * 重置tables
     */
    var removeTbaleText = function (type) {
        qrcode.clear();
        qrcodeT.clear();
        if (type == 'originBatch') {
            $("#finished_out").attr("disabled", true).addClass("m--hide")
            $("#originBatch").attr("disabled", false).removeClass("m--hide")
            $(".createQrCodeModal .modal-title").text("生成溯源二维码")
        } else {
            $("#originBatch").attr("disabled", true).addClass("m--hide")
            $("#finished_out").attr("disabled", false).removeClass("m--hide")
            $(".createQrCodeModal .modal-title").text("生成设备二维码")
        }
        $("#assemblySelect").removeClass("m--hide")
        $("#createQrCode").addClass("m--hide")
        return true;
    }

    /**
     * 打印
     */
    var qrCodePrint = function () {
        $(".qrCodePrint").on("click", function () {
            $.print("#finished_out")
        })

        $(".qrCodePrintOrigin").on("click", function () {
            $.print("#originBatch")
        })
    }
    return {
        init: function () {
            getUnitUsageItem();
            assemblyFun();
            qrCodePrint();
            createOriginBatchQrCode();
        }
    };
}();
jQuery(document).ready(function () {
    CreateQrCode.init();
});