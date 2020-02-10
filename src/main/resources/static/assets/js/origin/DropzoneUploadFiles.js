var myDropzone;
var DropzoneUploadFiles = function () {
        /**
         * 文件上传
         */
        var uploadDropzone = function () {
            Dropzone.options.mDropzoneOne = {
                thumbnailWidth: 256,
                thumbnailHeight: 141,
                paramName: "file",
                addRemoveLinks:true,//是否有删除图片的功能
                dictRemoveFile:"移除文件",//删除图片的文字
                acceptedFiles: ".jpg,.jpeg,.png,.gif",
                maxFiles: 1,
                maxFilesize: 5,
                init: function() {
                    myDropzone = this;
                    //this.emit("initimage", "http://of8rkrh1w.bkt.clouddn.com/2017/12/24/blog4.jpg"); //初始化图片
                    this.on("sendingmultiple", function() {
                    });
                    this.on("successmultiple", function(files, response) {
                    });
                    this.on("errormultiple", function(files, response) {
                        ToastrMsg(result.data,"error","topRight");
                    });
                    this.on("success", function(file,result) {
                        if (typeof result !== 'undefined'){
                            if(result.message){
                                $("#uploadDropzone [name='imgUrl']").val(result.data.url);
                            }else{
                                ToastrMsg(result.data,"error","topRight");
                            }
                        }
                    })
                }
            }
            /**
             * 重置上传框
             */
            $(".resetDropzone").on('click',function () {
                myDropzone.removeAllFiles(true);
            })
        }
    return {
        init: function() {
            uploadDropzone();
        }
    };
}();

DropzoneUploadFiles.init();