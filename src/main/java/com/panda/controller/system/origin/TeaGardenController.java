package com.panda.controller.system.origin;

import com.alibaba.citrus.util.StringEscapeUtil;
import com.alibaba.fastjson.JSON;
import com.panda.controller.system.index.IndexController;

import com.panda.model.origin.TeaGarden;
import com.panda.model.system.Dictionary;
import com.panda.model.system.Users;
import com.panda.service.origin.TeaGardenService;
import com.panda.service.system.DictionaryService;
import com.panda.util.ResultMsgUtil;
import com.panda.util.ResultStateUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
@RequestMapping("/system/origin")
public class TeaGardenController {
    private static final Logger logger = LoggerFactory.getLogger(IndexController.class);
    @Resource
    private TeaGardenService teaGardenService;
    @Resource
    private DictionaryService dictionaryService;
    private static boolean message = false;
    private static Object  data    = null;

    /**
     * 获取菜单 Tree 当前菜单为用户 信息一起存储到 Redis 内
     * @return
     */
    @RequestMapping(value = "/teaGarden",method= RequestMethod.GET)
    @RequiresPermissions("origin:view")//权限管理;
    public String getTeaGardenList(HttpServletRequest request, Model model){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        List<Dictionary> treeType = dictionaryService.selectDictionaryValueList("be0ba01c-23ad-11e5-965c-000c29d7a3a0");//树种
        List<Dictionary> orientationType = dictionaryService.selectDictionaryValueList("ab73bbbb-f7ca-4fe9-a086-296e57b9c3ac"); //方向
        model.addAttribute("orientationType",orientationType);
        model.addAttribute("treeType",treeType);
        model.addAttribute("menuList",user.getMenuList());
        model.addAttribute("user",user);
        return "system/origin/getTeaGardenList";
    }

    /**
     * Ajax 获取茶园信息列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/getTeaGardenDataList",method = RequestMethod.POST)
    @ResponseBody
    public Object getTeaGardenDataList(HttpServletRequest request,String datatable){
        message = false;
        data    = null;
        try {
            Map query = new HashMap();
            if (datatable != null && !datatable.isEmpty()){
                String jsonStr = StringEscapeUtil.unescapeHtml(datatable);
                Map params = JSON.parseObject(jsonStr,Map.class);
                Map status = JSON.parseObject(params.get("query").toString(),Map.class);
                if (status.size() > 0 && status.get("plantYear") != ""){
                    query.put("plantYear",status.get("plantYear"));
                }
                if (status.size() > 0 && status.get("dic_cultivar_id") != ""){
                    query.put("dic_cultivar_id",status.get("dic_cultivar_id"));
                }
            }

            List<Map> teaGardenInfoList = teaGardenService.selectTeaGardenList(query);
            if(teaGardenInfoList.size() > 0){
                message = true;
                data = teaGardenInfoList;
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
    @RequestMapping(value = "/getTeaGardenItem", method = RequestMethod.GET)
    @ResponseBody
    public Object getTeaGardenItem(HttpServletRequest request,String id){
        message = false;
        data    = null;
        if (!id.isEmpty()){
            try {
                TeaGarden teaGarden = teaGardenService.selectByPrimaryKey(id);
                if(teaGarden != null){
                    message = true;
                    data = teaGarden;
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
     * @param teaGarden
     * @param save
     * @return
     */
    @RequestMapping(value = "/saveTeaGarden",method = RequestMethod.POST)
    @ResponseBody
    public Object saveTeaGarden(HttpServletRequest request, TeaGarden teaGarden ,String save){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data    = null;
        try{
            if(!teaGarden.getId().isEmpty() && save.equals("edit")){
                int i = teaGardenService.updateByPrimaryKeySelective(teaGarden);
                if(i > 0){
                    message = true;
                    data    = ResultStateUtil.SUCCESS_UPDATE;
                }else{
                    data    = ResultStateUtil.FAIL_UPDATE;
                }
            }else if(save.equals("add")) {
                teaGarden.setId(UUID.randomUUID().toString());
                teaGarden.setCreateId(user.getId());
                teaGarden.setCreateTime(new Date());
                teaGarden.setModifyId(user.getId());
                teaGarden.setModifyTime(new Date());
                teaGarden.setStatus(1);
                int insert = teaGardenService.insertSelective(teaGarden);
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
    @RequestMapping(value="/delTeaGardenItem",method = RequestMethod.GET)
    @ResponseBody
    public Object DelTeaGardenItem(HttpServletRequest request ,String id){
        message = false;
        data    = null;
        try{
            if (!id.isEmpty()){
                int i = teaGardenService.deleteByPrimaryKey(id);
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
