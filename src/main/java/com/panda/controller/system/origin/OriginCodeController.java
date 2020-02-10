package com.panda.controller.system.origin;

import com.alibaba.citrus.util.StringEscapeUtil;
import com.alibaba.fastjson.JSON;
import com.panda.model.origin.OriginBatch;
import com.panda.model.origin.OriginCode;
import com.panda.model.system.Users;
import com.panda.service.commodity.ProductsService;
import com.panda.service.origin.OriginBatchService;
import com.panda.service.origin.OriginCodeService;
import com.panda.service.system.DictionaryService;
import com.panda.util.CreateBatchNoUtil;
import com.panda.util.ResultMsgUtil;
import com.panda.util.ResultStateUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created with IDEA.
 *
 * @AUTH: Alan
 * Date: 2017/12/7
 * Time: 22:31
 */
@Controller
@RequestMapping(value = "/system/originCode")
public class OriginCodeController {

    @Resource
    private OriginBatchService originBatchService;

    @Resource
    private ProductsService productsService;

    @Resource
    private DictionaryService dictionaryService;

    @Resource
    private OriginCodeService originCodeService;
    private static boolean message = false;
    private static Object  data    = null;

    /**
     * 列表页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/list",method= RequestMethod.GET)
    @RequiresPermissions("originCode:view")//权限管理;
    public String getOriginCodeList(HttpServletRequest request, Model model){
        Map query = new HashMap();
        query.put("status",1);
        List<OriginBatch> batchList = originBatchService.selectBatchList(query);
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        model.addAttribute("batchList",batchList);
        model.addAttribute("menuList",user.getMenuList());
        model.addAttribute("user",user);
        return "system/origin/getOriginCodeList";
    }

    /**
     * Ajax 获取信息列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/getOriginCodeDataList",method = RequestMethod.POST)
    @ResponseBody
    public Object getOriginCodeDataList(HttpServletRequest request,String datatable){
        message = false;
        data    = null;
        try {
            Map query = new HashMap();
            if (datatable != null && !datatable.isEmpty()){
                String jsonStr = StringEscapeUtil.unescapeHtml(datatable);
                Map params = JSON.parseObject(jsonStr,Map.class);
                Map status = JSON.parseObject(params.get("query").toString(),Map.class);
                if (status.size() > 0 && status.get("originBatchId") != ""){
                    query.put("originBatchId",status.get("originBatchId"));
                }
            }
            List<Map> originBatchList = originCodeService.selectOriginCodeDataList(query);
            if(originBatchList.size() > 0){
                message = true;
                data = originBatchList;
            }
        }catch (Exception e){
            e.printStackTrace();
            data    = ResultStateUtil.ERROR_DATABASE_OPERATION;
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }

    /**
     * Ajax 获取当前编辑项的内容
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value = "/editOriginCodeItem", method = RequestMethod.GET)
    @ResponseBody
    public Object editOriginCodeItem(HttpServletRequest request,String id){
        message = false;
        data    = null;
        if (!id.isEmpty()){
            try {
                OriginCode originCode = originCodeService.selectByPrimaryKey(id);
                if(originCode != null){
                    message = true;
                    data = originCode;
                }else{
                    data = ResultStateUtil.ERROR_QUERY;
                }
            }catch (Exception e){
                e.printStackTrace();
                data    = ResultStateUtil.ERROR_DATABASE_OPERATION;
            }
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }

    /**
     * 保存和编辑数据
     * @param request
     * @param originCode
     * @param save
     * @return
     */
    @RequestMapping(value = "/saveOrUpdateOriginCode",method = RequestMethod.POST)
    @ResponseBody
    public Object saveOrUpdateOriginCode(HttpServletRequest request, OriginCode originCode , String save){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data    = null;
        try{
            if(!originCode.getId().isEmpty() && save != null && save.equals("edit")){
                originCode.setModifyId(user.getId());
                originCode.setModifyTime(new Date());
                int i = originCodeService.updateByPrimaryKeySelective(originCode);
                if(i > 0){
                    message = true;
                    data    = ResultStateUtil.SUCCESS_UPDATE;
                }else{
                    data    = ResultStateUtil.FAIL_UPDATE;
                }
            }else if(save.equals("add")) {
                originCode.setId(UUID.randomUUID().toString());
                originCode.setCreateId(user.getId());
                originCode.setCreateTime(new Date());
                int insert = originCodeService.insertSelective(originCode);
                if(insert > 0){
                    message = true;
                    data    = ResultStateUtil.SUCCESS_ADD;
                }else{
                    data    = ResultStateUtil.FAIL_ADD;
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            data  = ResultStateUtil.ERROR_DATABASE_OPERATION;
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }

    /**
     * 刪除
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value="/delOriginCodeItem",method = RequestMethod.GET)
    @ResponseBody
    public Object delOriginCodeItem(HttpServletRequest request ,String id){
        message = false;
        data    = null;
        try{
            if (!id.isEmpty()){
                int i = originCodeService.deleteByPrimaryKey(id);
                if(i > 0){
                    message = true;
                    data = ResultStateUtil.SUCCESS_DELETE;
                }else{
                    data = ResultStateUtil.ERROR_QUERY;
                }
            }else{
                data = ResultStateUtil.ERROR_PARAMETER_IS_EMPTY;
            }
        }catch (Exception e){
            e.printStackTrace();
            data = ResultStateUtil.ERROR_DATABASE_OPERATION;
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }

}
