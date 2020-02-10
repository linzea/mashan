var editMyAccount = function () {
    var $distpicker = $('#distpicker')

    /**
     * editMyAccount 表单验证
     * 新增与编辑
     */
    var userForm = function () {
        $( "#editMyAccount" ).validate({
            rules: {
                chineseName: {
                    required: true,
                    nameCheck:true
                },
                mobile: {
                    required: true,
                    mobileZH:true,

                }
            },
            submitHandler: function (form){
                blockUiOpen('.userEdit .modal-content');
                request(
                    "saveUserOrUpdate",
                    "post",
                    $("#editMyAccount").serialize(),
                    function(result){
                        if(result.message){
                            blockUiClose('.userEdit .modal-content',1,".close-parent",0);
                            ToastrMsg(result.data,"success","topRight");
                        }else{
                            ToastrMsg(result.data,"error","topRight",".userEdit .modal-content");
                        }
                    }
                )
            }
        });
    }



    return {
        init: function () {
            userForm();
        }
    };
}();
jQuery(document).ready(function () {
    editMyAccount.init();
    $("form").on("change",function () {
        $("#editMyAccountBtn").attr("disabled",false)
    })
    $(".reset-button").on("click",function () {
        $("#editMyAccountBtn").attr("disabled",true)
    })
});