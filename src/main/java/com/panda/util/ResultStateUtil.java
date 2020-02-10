package com.panda.util;
/**
 * Created with IDEA Controller 返回的状态码
 * User: Alan
 * Date: 2017/11/14
 * Time: 17:28
 */
public class ResultStateUtil {
    /**
     * 常用异常
     */
    public static final String ERROR_PARAMETER_IS_EMPTY = "传递的内容为空, 操作存在异常";//000
    public static final String ERROR_PARAMETER_NO_TCOMPATIBLE = "传递的内容不匹配,未获取到任何信息";//001
    public static final String ERROR_DATABASE_OPERATION = "执行失败.";//002
    public static final String ERROR_OPERATION = "操作异常";//003
    public static final String ERROR_PARAMETER_IS_NOT_VALID = "参数不合法";//004
    public static final String ERROR_QUERY = "数据获取异常";//005
    public static final String ERROR_TAMPERING = "非法篡改秘钥";//006
    public static final String ERROR_TIME_UPDATE = "出现错误了,请刷新后再尝试.";//007

    /**
     * 常用失败
     */
    public static final String FAIL_UPDATE      = "由于未知原因, 导致修改失败";//100
    public static final String FAIL_ABNORMAL    = "数据操作异常,导致操作失败";//101
    public static final String FAIL_DELETE      = "删除失败,存在下级数据.删除被终止";//102
    public static final String FAIL_QUERY       = "查询失败";//103
    public static final String FAIL_UPLOAD      = "上传失败";//104
    public static final String FAIL_IMAGES_SIZE = "附件上传失败,文件过大.";//106
    public static final String FAIL_IMAGES_TYPE = "附件上传失败,不支持的文件类型";//106
    public static final String FAIL_ADD         = "由于未知原因, 导致新增失败";//105
    public static final String FAIL_BUSINESS    = "主营业务格式化失败";//107
    public static final String FALL_LONGITUDE   = "经纬度匹配城市失败,请重新获取正确的经纬度";//108
    public static final String FAIL_BINDING     = "绑定失败";//109
    public static final String FAIL_TAG_INVEN   = "标签库存不足,入库失败!";//110
    public static final String FAIL_PAC_INVEN   = "包材数量库存不足,入库失败!";//111
    public static final String IO_EXCEPTION     = "IO异常";
    public static final String FAIL_CHECK_OLD_PASS = "旧密码 不正确,密码修改失败.";//112
    /**
     * 常用成功
     */
    public static final String SUCCESS_UPDATE           = "修改了一些东西, 并保存成功";//200
    public static final String SUCCESS_ABNORMAL         = "操作了一些数据, 并保存成功";//204
    public static final String SUCCESS_DELETE           = "成功删除了一条记录";//201
    public static final String SUCCESS_QUERY            = "查询成功";//202
    public static final String SUCCESS_ADD              = "新增了一条记录, 并保存成功";//203
    public static final String SUCCESS_UPLOAD           = "上传成功";//205
    public static final String SUCCESS_BINDING          = "绑定成功";//209
    public static final String SUCCESS_CHANGE_PASS      = "密码修改成功,请在下次登录登录时使用新密码.";//112
    public static final String SUCCESS_FINI_OUT         = "成品出货完成,请前往出库记录打印出库单据.";//112



    /**
     * 常用温馨提示
     */
    public static final String NO_MORE_DATA = "当前操作未获取到有效数据";//400
    public static final String CODE_OUT_TIME = "验证码超时";//401
    public static final String CLICK_OUT_OVER = "请选择加工状态至完成状态.";//403



    /**
     * 无权限时提示消息
     */
    public static final String NO_PERMISSION_ADD    = "抱歉! 您的操作权限不能执行 <新增> 任务.";
    public static final String NO_PERMISSION_DEL    = "抱歉! 您的操作权限不能执行 <删除> 任务.";
    public static final String NO_PERMISSION_EDIT   = "抱歉! 您的操作权限不能执行 <编辑> 任务.";
    public static final String NO_PERMISSION_EXPORT = "抱歉! 您的操作权限不能执行 <导出> 任务.";
    public static final String NO_PERMISSION_SUBMIT = "抱歉! 您的操作权限不能执行 <提交> 任务.";
    public static final String NO_PERMISSION_UPLOAD = "抱歉! 您的操作权限不能执行 <上传> 任务.";
    public static final String NO_PERMISSION_VERIFY = "抱歉! 您的操作权限不能执行 <审核> 任务.";
    public static final String NO_PERMISSION_VIEW   = "抱歉! 您的操作权限不能执行 <查看> 任务.";
}
