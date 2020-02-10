var TeaGarden = function () {
    var actionsTemplate = $("#actionsTemplate").html();
    var teaGardenInfoShow = function () {
        var option = {
            data: {
                type: 'remote',
                source: {
                    read: {
                        url: 'getTeaGardenDataList'
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
                {title: "#", width: 40, template: function (row) {
                    return row.rowIndex+1; }
                },

                {field: "name_area", title: "区域名", width: 100},
                {field: "area_code", title: "编号", width: 100},
                {field: "treeName", title: "栽培品种", width: 100},
                {field: "plant_year", title: "栽培年份", width: 100,
                    template: function (row) {
                        return row.plant_year+'  年';
                    }
                },
                {field: "acreage", title: "面积", width: 100,
                    template: function (row) {
                        return row.acreage+'  亩';
                    }
                },
                {field: "age_limit", title: "树龄", width: 100,
                    template: function (row) {
                        return calculateTree(row.plant_year)+'  年';
                    }
                },
                {field: "principal", title: "负责人", width: 100},
                {field: "create_time", title: "创建时间", sortable: 'asc', width: 150},
                {
                    field: "Actions",
                    width: 100,
                    title: "操作",
                    sortable: false,
                    overflow: 'visible',
                    template: function (row) {
                        var dropup = (row.getIndex() - row.getIndex()) <= 4 ? 'dropup' : '';
                        return actionsTemplate.replace(/#rowId#/g, row.id);
                    }
                }]
        }
        var datatable = $('.tea_garden_info_ajax').mDatatable(option);

        var query = datatable.getDataSourceQuery();

        $('#m_form_search').on('keyup', function (e) {
            var query = datatable.getDataSourceQuery();
            query.generalSearch = $(this).val().toLowerCase();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(query.generalSearch);

        $('#plantYear').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.plantYear = $(this).val().toLowerCase();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(typeof query.plantYear !== 'undefined' ? query.plantYear : '');

       $('#dicCultivarId').on('change', function () {
            var query = datatable.getDataSourceQuery();
            query.dicCultivarId = $(this).val();
            datatable.setDataSourceQuery(query);
            datatable.load();
        }).val(typeof query.dicCultivarId !== 'undefined' ? query.dicCultivarId : '');
        $('.datatableRoload').on('click', function () {
            location.reload()
        });
        $('.select_selectpicker').selectpicker();
    };


    /**
     * 茶园信息表单验证
     * 新增与编辑
     */
    var teaGardenInfoForm = function () {
        $( "#tea_garden_edit_form" ).validate({
            rules: {
                name_area: {
                    required: true,
                    nameCheck:true
                },
                teaGrade:{required: true,},
                gardenType:{required: true,},
                areaCode:{required: true,alphanumerical:true},
                plantYear:{required: true,number:true,maxlength:4},
                acreage:{required: true,decimalCheck:true},
                latitude:{decimalCheck:true,maxlength:20},
                longitude:{decimalCheck:true,maxlength:20},
                dicCultivarId:{required: true,},
                principal:{required: true,},
                ageLimit:{required: true,number:true},
            },

            submitHandler: function (form){
                blockUiOpen('.teaGardenEdit .modal-content');
                request(
                    "saveTeaGarden",
                    "post",
                    $("#tea_garden_edit_form").serialize(),
                    function(result){
                        if(result.message){
                            ToastrMsg(result.data,"success","topRight",'.teaGardenEdit .modal-content',"reload",true);
                        }else{
                            ToastrMsg(result.data,"error","topRight",'.teaGardenEdit .modal-content');
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
        if(type == 'edit'){
            $(".teaGardenEdit .modal-title").text("茶园编辑")
            $(".teaGardenEdit [name='save']").val('edit')
            $(".reset-btn").addClass("m--hide");
        }else{
            $(".teaGardenEdit .modal-title").text("茶园新增")
            $(".teaGardenEdit [name='save']").val('add');
            $(".reset-btn").removeClass("m--hide");
        }
        $(".teaGardenEdit [name='id']").val('')
        $(".teaGardenEdit [name='name']").val('')
        $(".teaGardenEdit [name='description']").val('');
        $(".teaGardenEdit .form-control-feedback").remove()
        $(".teaGardenEdit div").removeClass("has-danger")
        $(".teaGardenEdit div").removeClass("has-success")
    }

    /**
     * 新增茶园信息
     */
    var addTeaGarden = function () {
        $(".addTeaGarden").on('click',function(){
            removeValue('add')
        })

        $("#plantYearInTo").on("change",function () {
            var treeAge = calculateTree($(this).val());
            $("#ageLimit").val(treeAge);
        })
    }
    //计算树龄
    var calculateTree = function (year) {
        var now = new Date().getFullYear();
        return Number(now-year);
    }
    /**
     * 获取角色信息,并移除上一轮错误信息
     */
    var editTeaGardenItem = function () {
        $("#tea_garden_list").on("click", ".editTeaGardenItem", function () {
            removeValue('edit')
            var id = $(this).attr("item");
            if(id != ""){
                request(
                    "getTeaGardenItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            $("#tea_garden_edit_form [name='id']").val(result.data.id)
                            $("#tea_garden_edit_form [name='nameArea']").val(result.data.nameArea)
                            $("#tea_garden_edit_form [name='dicCultivarId']").val(result.data.dicCultivarId)
                            $("#tea_garden_edit_form [name='principal']").val(result.data.principal)
                            $("#tea_garden_edit_form [name='acreage']").val(result.data.acreage)
                            $("#tea_garden_edit_form [name='ageLimit']").val(calculateTree(result.data.plantYear))
                            $("#tea_garden_edit_form [name='sortId']").val(result.data.sortId)
                            $("#tea_garden_edit_form [name='description']").val(result.data.description)
                            $("#tea_garden_edit_form [name='areaCode']").val(result.data.areaCode)
                            $("#tea_garden_edit_form [name='plantYear']").val(result.data.plantYear)
                        }else{
                            ToastrMsg(result.data,"error","topRight");
                        }
                    })
            }
        })
    }


    /**
     * 删除角色
     */
    var delTeaGardenItem = function () {
        $("#tea_garden_list ").on("click", ".delTeaGardenItem", function () {
            blockUiOpen('#tea_garden_list');
            var self = $(this);
            var id = self.attr("item");
            if(id != ""){
                request(
                    "delTeaGardenItem",
                    'get',
                    {id:id},
                    function (result) {
                        if(result.message){
                            self.parents("tr").remove();
                            ToastrMsg(result.data,"success","topRight",'#tea_garden_list');
                        }else{
                            ToastrMsg(result.data,"error","topRight",'#tea_garden_list');
                        }
                    })
            }
        })
    }

    var datetimepickerSelect = function () {
        $('.datetimepicker_select').datetimepicker({
            todayHighlight: false,
            autoclose: true,
            startView: 4,
            minView: 4,
            sideBySide: false,
            pickerPosition: 'bottom-left',
            clearBtn: true,
            format: 'yyyy'
        });

        $('.begin_time').datetimepicker({
            todayHighlight: false,
            autoclose: true,
            sideBySide: false,
            pickerPosition: 'top-left',
            clearBtn: true,
            format: 'yyyy-mm-dd hh:mm:ss'
        });
    }
    return {
        init: function () {
            addTeaGarden();
            editTeaGardenItem()
            delTeaGardenItem()
            teaGardenInfoShow();
            teaGardenInfoForm();
            datetimepickerSelect();
        }
    };
}();
jQuery(document).ready(function () {
    TeaGarden.init();
});