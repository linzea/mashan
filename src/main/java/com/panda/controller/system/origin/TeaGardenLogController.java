package com.panda.controller.system.origin;

import com.alibaba.citrus.util.StringEscapeUtil;
import com.alibaba.fastjson.JSON;
import com.panda.model.origin.TeaGardenLog;
import com.panda.model.system.Dictionary;
import com.panda.model.system.Users;
import com.panda.service.origin.TeaGardenLogService;
import com.panda.service.origin.TeaGardenService;
import com.panda.service.system.DictionaryService;
import com.panda.util.ResultMsgUtil;
import com.panda.util.ResultStateUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/system/teaLog")
public class TeaGardenLogController {
    private static final Logger logger = LoggerFactory.getLogger(TeaGardenLogController.class);

    @Resource
    private TeaGardenService teaGardenService;

    @Resource
    private DictionaryService dictionaryService;

    @Resource
    private TeaGardenLogService teaGardenLogService;
    private static boolean message = false;
    private static Object  data    = null;

    /**
     * bootstart  date 注解 格式化页面上传过来的 String 日期
     * @param request
     * @param binder
     * @throws
     */
    @InitBinder
    protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) throws Exception {
        DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        CustomDateEditor dateEditor = new CustomDateEditor(fmt, true);
        binder.registerCustomEditor(Date.class, dateEditor);
    }

    /**
     * 进入列表页 垦荒
     * @return
     */
    @RequestMapping(value = "/reclaim",method= RequestMethod.GET)
    @RequiresPermissions("teaLog:view")//权限管理;
    public String getTeaGardenLogReclaim(HttpServletRequest request, Model model){
        teaLogPageShow(request,model,"43512930-9822-48b4-b577-e900c4a12504");
        return "system/origin/getTeaGardenLogList";

    }

    /**
     * 进入列表页 耕地
     * @return
     */
    @RequestMapping(value = "/plough",method= RequestMethod.GET)
    @RequiresPermissions("teaLog:view")//权限管理;
    public String getTeaGardenLogPlough(HttpServletRequest request, Model model){
        teaLogPageShow(request,model,"4b2946d6-ec92-403f-ae59-6a2d6311e6cd");
        return "system/origin/getTeaGardenLogList";
    }

    /**
     * 进入列表页 种植
     * @return
     */
    @RequestMapping(value = "/seed",method= RequestMethod.GET)
    @RequiresPermissions("teaLog:view")//权限管理;
    public String getTeaGardenLogSeed(HttpServletRequest request, Model model){
        List<Dictionary> treeType = dictionaryService.selectDictionaryValueList("be0ba01c-23ad-11e5-965c-000c29d7a3a0");//茶树品种
        List<Dictionary> seedOrigin = dictionaryService.selectDictionaryValueList("3b7dc807-11d0-4884-b63c-78c929e28bec");//种子来源
        model.addAttribute("seedOrigin",seedOrigin);
        model.addAttribute("treeType",treeType);
        teaLogPageShow(request,model,"1689fac5-4b03-4d4b-94c1-d1bbbe8d06ee");
        return "system/origin/getTeaGardenLogList";
    }

    /**
     * 进入列表页 施肥
     * @return
     */
    @RequestMapping(value = "/fertilizer",method= RequestMethod.GET)
    @RequiresPermissions("teaLog:view")//权限管理;
    public String getTeaGardenLogFertilizer(HttpServletRequest request, Model model){
        List<Dictionary> patternType = dictionaryService.selectDictionaryValueList("c0de59f4-63a7-11e7-b264-000c29b92c50");//施肥
        List<Dictionary> manureType = dictionaryService.selectDictionaryValueList("e597a18d-9e8a-4194-b413-54d2d8694f51");//肥料品种
        model.addAttribute("manureType",manureType);
        model.addAttribute("patternType",patternType);
        teaLogPageShow(request,model,"d687763c-2a2e-41a7-b57d-71e9caebf579");
        return "system/origin/getTeaGardenLogList";
    }

    /**
     * 进入列表页 除草
     * @return
     */
    @RequestMapping(value = "/weeding",method= RequestMethod.GET)
    @RequiresPermissions("teaLog:view")//权限管理;
    public String getTeaGardenLogWeeding(HttpServletRequest request, Model model){
        List<Dictionary> methods = dictionaryService.selectDictionaryValueList("bc9b6739-d94f-4fb4-a54d-c88255cf0f22");//除草方式
        model.addAttribute("methods",methods);
        teaLogPageShow(request,model,"d5bbd9b5-91c4-48c2-b5f8-0c7328f8902f");
        return "system/origin/getTeaGardenLogList";
    }

    /**
     * 进入列表页 治虫
     * @return
     */
    @RequestMapping(value = "/insecticide",method= RequestMethod.GET)
    @RequiresPermissions("teaLog:view")//权限管理;
    public String getTeaGardenLogInsecticide(HttpServletRequest request, Model model){
        List<Dictionary> methods = dictionaryService.selectDictionaryValueList("bc9b6739-d94f-4fb4-a54d-c88255cf0f22");//除草方式
        model.addAttribute("methods",methods);
        teaLogPageShow(request,model,"e1f3e464-31c2-46b5-8e20-20d7ea12fb3f");
        return "system/origin/getTeaGardenLogList";
    }

    /**
     * 进入列表页 灌溉
     * @return
     */
    @RequestMapping(value = "/irrigate",method= RequestMethod.GET)
    @RequiresPermissions("teaLog:view")//权限管理;
    public String getTeaGardenLogIrrigate(HttpServletRequest request, Model model,String type){//
        List<Dictionary> irrigationRegime = dictionaryService.selectDictionaryValueList("67c57cec-8621-40cc-ab3e-2bc3fd487c58");//除草方式
        model.addAttribute("irrigationRegime",irrigationRegime);
        teaLogPageShow(request,model,"5fe37095-7d9a-4235-914f-cf0c6f1e592a");
        return "system/origin/getTeaGardenLogList";
    }

    private void teaLogPageShow(HttpServletRequest request, Model model,String type){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        List<Dictionary> farmType = dictionaryService.selectDictionaryValueList("92253cc8-2128-11e5-965c-000c29d7a3a0");//农事
        List<Dictionary> cultivarType = dictionaryService.selectDictionaryValueList("be0ba01c-23ad-11e5-965c-000c29d7a3a0");//品种
        List<Map> gardenType = teaGardenService.selectTeaGardenNameAndId(new HashMap());
        model.addAttribute("cultivarType",cultivarType);
        model.addAttribute("gardenType",gardenType);
        model.addAttribute("farmType",farmType);
        model.addAttribute("type",type);
        model.addAttribute("menuList",user.getMenuList());
        model.addAttribute("user",user);
    }

    /**
     * Ajax 获取日志列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/getTeaGardenLogList",method = RequestMethod.POST)
    @ResponseBody
    public Object getTeaGardenLogList(HttpServletRequest request,String datatable){
        message = false;
        data    = null;
        try {
            Map query = new HashMap();
            if (datatable != null && !datatable.isEmpty()){
                String jsonStr = StringEscapeUtil.unescapeHtml(datatable);
                Map params = JSON.parseObject(jsonStr,Map.class);
                Map status = JSON.parseObject(params.get("query").toString(),Map.class);
                if (status.size() > 0 && status.get("status") != ""){
                    query.put("status",status.get("status"));
                }
                if (status.size() > 0 && status.get("createYear") != ""){
                    query.put("createYear",status.get("createYear"));
                }
                if (status.size() > 0 && status.get("farmType") != ""){
                    query.put("farmType",status.get("farmType"));
                }
                if (status.size() > 0 && status.get("gardenType") != ""){
                    query.put("gardenType",status.get("gardenType"));
                }
            }
            List<Map> TeaGardenLog = teaGardenLogService.selectTeaGardenLogList(query);
            if(TeaGardenLog.size() > 0){
                message = true;
                data = TeaGardenLog;
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
    @RequestMapping(value = "/getTeaGardenLogItem", method = RequestMethod.GET)
    @ResponseBody
    public Object getTeaGardenLogItem(HttpServletRequest request,String id){
        message = false;
        data    = null;
        if (!id.isEmpty()){
            try {
                Map TeaGardenLog = teaGardenLogService.selectTeaGardenLogItem(id);
                if(TeaGardenLog != null){
                    message = true;
                    data = TeaGardenLog;
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
     * 保存
     * @param request
     * @param teaGardenLog
     * @param save
     * @return
     */
    @RequestMapping(value = "/saveTeaGardenLog",method = RequestMethod.POST)
    @ResponseBody
    public Object saveTeaGardenLog(HttpServletRequest request, TeaGardenLog teaGardenLog ,String save){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data    = null;
        try{
            if(!teaGardenLog.getId().isEmpty() && save.equals("edit")){
                if (teaGardenLog.getStatus() == 2){
                    teaGardenLog.setEndTime(new Date());
                }
                int i = teaGardenLogService.updateByPrimaryKeySelective(teaGardenLog);
                if(i > 0){
                    message = true;
                    data    = ResultStateUtil.SUCCESS_UPDATE;
                }else{
                    data    = ResultStateUtil.FAIL_UPDATE;
                }
            }else if(save.equals("add")) {
                teaGardenLog.setId(UUID.randomUUID().toString());
                teaGardenLog.setCreateId(user.getId());
                teaGardenLog.setCreateTime(new Date());
                teaGardenLog.setModifyId(user.getId());
                teaGardenLog.setModifyTime(new Date());
                //teaGardenLog.setCultivarId(UUID.randomUUID().toString());
                teaGardenLog.setStatus(1);
                int insert = teaGardenLogService.insertSelective(teaGardenLog);
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
    @RequestMapping(value="/delTeaGardenLogItem",method = RequestMethod.GET)
    @ResponseBody
    public Object delTeaGardenLogItem(HttpServletRequest request ,String id){
        message = false;
        data    = null;
        try{
            if (!id.isEmpty()){
                int i = teaGardenLogService.deleteByPrimaryKey(id);
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


    /**
     * 根据茶园ID获取批次号
     * @param request
     * @param teaGardenId
     * @return
     */
    @RequestMapping(value = "/getTeaGardenBatch")
    @ResponseBody
    public Object getTeaGardenBatch(HttpServletRequest request,String teaGardenId){
        message = false;
        data    = null;
        try {
            if (!teaGardenId.isEmpty()){
                List<Map> map = teaGardenService.selectTeaGardenBatch(teaGardenId);
                if (map != null && map.size() > 0){
                    message = true;
                    data    = map;
                }else{
                    data    = "未获取到该批次的数据.";
                }
            }else{
                data = ResultStateUtil.ERROR_PARAMETER_NO_TCOMPATIBLE;
            }
        }catch (Exception e){
            e.printStackTrace();
            data    = ResultStateUtil.ERROR_QUERY;
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }


}
