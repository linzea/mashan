
jQuery(document).ready(function () {
    $( "#origin_form" ).validate({
        rules: {
            originCode: {
                required: true,
                alphanumerical:true
            }
        },

        submitHandler: function (form){
            request(
                "/index/traceQuery/proTraceAjax",
                "post",
                $("#origin_form").serialize(),
                function(result){
                    console.log(result);
                    if(result.message){
                        form.submit();
                    }else{
                        ToastrMsg(result.data,"warning","topRight");
                    }
                }
            )
        }
    });

});

