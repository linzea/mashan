var changePassWord = function () {
    /**
     * 修改密码 检查用户
     */
    var getLoginUser = function () {
        $(".m-page").on('click','.changePassWordBnt',function () {
            removeValue();
            request(
                "/system/user/getLoginUser",
                "post",
                {id:$("#changePassWordForm [name='id']").val()},
                function(result){
                    if(!result.message){
                        location.href="/system/logout"
                    }
                }
            )
        })
    }
    /**
     * 表单验证
     */
    var rolesForm = function () {
        $( "#changePassWordForm" ).validate({
            rules: {
                oldPassWord:{
                    required: true,
                    minlength: 6,
                    maxlength:12,
                },
                password:{
                    required: true,
                    minlength: 6,
                    maxlength:12,
                },
                checkPassWord:{
                    required: true,
                    minlength: 6,
                    maxlength:12,
                    equalTo:"#password"
                }
            },

            submitHandler: function (form){
                blockUiOpen('.rolesEdit .modal-content');
                request(
                    "/system/user/changePassWord",
                    "post",
                    $("#changePassWordForm").serialize(),
                    function(result){
                        if(result.message){
                            blockUiClose('.rolesEdit .modal-content',1,".close-parent",0);
                            ToastrMsg(result.data,"success","topRight");
                        }else{
                            ToastrMsg(result.data,"error","topRight");
                        }
                    }
                )
            }
        });
    }


    /**
     * 重置表单
     */
    var removeValue = function (){
        $("#changePassWordForm .password").val("");
        $("#changePassWordForm .form-control-feedback").remove()
        $("#changePassWordForm div").removeClass("has-danger")
        $("#changePassWordForm div").removeClass("has-success")
    }

    return {
        init: function () {
            getLoginUser();
            rolesForm();
        }
    };
}();

jQuery(document).ready(function () {
    changePassWord.init();
});