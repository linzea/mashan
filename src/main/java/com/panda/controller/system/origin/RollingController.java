package com.panda.controller.system.origin;

import com.alibaba.citrus.util.StringEscapeUtil;
import com.alibaba.fastjson.JSON;
import com.panda.model.origin.MachinTea;
import com.panda.model.system.Dictionary;
import com.panda.model.system.Users;
import com.panda.service.origin.AssemblySetService;
import com.panda.service.origin.HarvestRecordsService;
import com.panda.service.origin.MachinSetService;
import com.panda.service.origin.MachinTeaService;
import com.panda.service.system.DictionaryService;
import com.panda.util.DateUtil;
import com.panda.util.ResultMsgUtil;
import com.panda.util.ResultStateUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
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
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/12/26
 * Time: 10:53
 */
@Controller
@RequestMapping(value = "/system/rolling")
public class RollingController {

    @Resource
    private DictionaryService dictionaryService;

    @Resource
    private AssemblySetService assemblySetService;

    @Resource
    private MachinTeaService machinTeaService;

    @Resource
    private HarvestRecordsService harvestRecordsService;//鲜叶批次

    @Resource
    private MachinSetService machinSetService;//加工设置数据

    private static boolean message = false;
    private static Object data = null;
    /**
     * bootstart  date 注解 格式化页面上传过来的 String 日期
     *
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
     * 揉捻
     *
     * @return
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @RequiresPermissions("rolling:view")//权限管理;
    public String getMachinTeaListKillOut(HttpServletRequest request, Model model) {
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        Map map = new HashMap();
        map.put("status", 1);
        List<Dictionary> machinType = dictionaryService.selectDictionaryValueList("0b9ed538-29d6-11e5-965c-000c29d7a3a0");//加工类型
        List<Dictionary> teaArrt = dictionaryService.selectDictionaryValueList("31783870-956f-469f-b43e-9fefd905afca");//茶系
        List<Dictionary> rollType = dictionaryService.selectDictionaryValueList("6d493a67-1545-4022-b7d4-2854c5b70abd");//揉捻
        List<Map> harvestList = harvestRecordsService.selectHarvestRecordsListPickNum(map); //鲜叶批次
        map.put("parentId", "10000000-0000-0000-0000-000000000000");
        List<Map> assemblyList = assemblySetService.selectAssemblySetDataList(map); //生产线
        model.addAttribute("harvestList", harvestList);
        model.addAttribute("rollType", rollType);
        model.addAttribute("machinType", machinType);
        model.addAttribute("assemblyList", assemblyList);
        model.addAttribute("dicMacPro", "43512930-9822-48b4-b577-e900c4a12504");
        model.addAttribute("teaArrt", teaArrt);
        model.addAttribute("menuList", user.getMenuList());
        model.addAttribute("user", user);
        return "system/origin/getRollingList";
    }

    /**
     * Ajax 获取信息列表
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/getMachinTeaDataList", method = RequestMethod.POST)
    @ResponseBody
    public Object getMachinTeaDataList(HttpServletRequest request, String datatable) {
        message = false;
        data = null;
        try {
            Map query = new HashMap();
            query.put("dicMacValue", "rolling");
            if (datatable != null && !datatable.isEmpty()) {
                String jsonStr = StringEscapeUtil.unescapeHtml(datatable);
                Map params = JSON.parseObject(jsonStr, Map.class);
                Map status = JSON.parseObject(params.get("query").toString(), Map.class);
                if (status.size() > 0 && status.get("machinStatus") != "") {
                    query.put("machinStatus", status.get("machinStatus"));
                }
                if (status.size() > 0 && status.get("dicTeaAttr") != "") {
                    query.put("dicTeaAttr", status.get("dicTeaAttr"));
                }
                if (status.size() > 0 && status.get("assemblySetId") != "") {
                    query.put("assemblySetId", status.get("assemblySetId"));
                }
                if (status.size() > 0 && status.get("harvestBatchId") != "") {
                    query.put("harvestBatchId", status.get("harvestBatchId"));
                }
            }
            List<Map> machinTeaList = machinTeaService.selectMachinTeaDataList(query);
            if (machinTeaList.size() > 0) {
                for (Map item : machinTeaList) {
                    String time = DateUtil.calculationSecond(item.get("begin_time").toString(),item.get("end_time").toString());
                    item.put("lostTime",time);
                }
                message = true;
                data = machinTeaList;
            }
        } catch (Exception e) {
            e.printStackTrace();
            data = ResultStateUtil.ERROR_DATABASE_OPERATION;
        }
        return ResultMsgUtil.getResultMsg(message, data);
    }

    /**
     * Ajax 获取当前编辑项的内容
     *
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value = "/editRollingItem", method = RequestMethod.GET)
    @ResponseBody
    public Object editRollingItem(HttpServletRequest request, String id) {
        message = false;
        data = null;
        if (!id.isEmpty()) {
            try {
                Map machinTea = machinTeaService.selectMachinTeaDataByOne(id);
                if (machinTea != null) {
                    Map query = new HashMap();
                    query.put("id", machinTea.get("machin_set_id"));
                    List<Map> machinList = machinSetService.selectMachinSetDataList(query);
                    if (machinList != null && machinList.size() > 0) {
                        machinTea.put("teaAttrNameS", machinList.get(0).get("teaAttrName"));
                        machinTea.put("macProNameS", machinList.get(0).get("macProName"));
                    }
                    message = true;
                    data = machinTea;
                } else {
                    data = ResultStateUtil.ERROR_QUERY;
                }
            } catch (Exception e) {
                e.printStackTrace();
                data = ResultStateUtil.ERROR_DATABASE_OPERATION;
            }
        }
        return ResultMsgUtil.getResultMsg(message, data);
    }

    /**
     * 编辑 杀青数据--杀青数据不可新增 Spring boot 存储过程
     * 注意新增时 数据库使用了联合唯一索引,防止重复添加操作工序
     * alter ignore table e_machin_tea add unique index(process_batch_id, dic_mac_type, dic_mac_pro)
     *
     * @param request
     * @param machinTea
     * @param save
     * @return
     */
    @RequestMapping(value = "/saveOrUpdateRolling", method = RequestMethod.POST)
    @ResponseBody
    public Object saveOrUpdateRolling(HttpServletRequest request, MachinTea machinTea, String save) {
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data = null;
        try {
            if (machinTea != null) {
                if (save.equals("edit")) {
                    machinTea.setModifyId(user.getId());
                    machinTea.setModifyTime(new Date());
                    int insert = machinTeaService.saveOrUpdateRolling(machinTea);
                    switch (insert) {
                        case 200:
                            message = true;
                            data = ResultStateUtil.SUCCESS_ABNORMAL;
                            break;
                        case 101:
                            data = ResultStateUtil.FAIL_ADD;
                            break;
                        default:
                            data = ResultStateUtil.FAIL_ADD;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            data = ResultStateUtil.ERROR_DATABASE_OPERATION + "或工序重复.";
        }
        return ResultMsgUtil.getResultMsg(message, data);
    }

    /**
     * 刪除 Spring boot 存储过程
     *
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value = "/delRollingItem", method = RequestMethod.GET)
    @ResponseBody
    public Object delRollingItem(HttpServletRequest request, String id) {
        message = false;
        data = null;
        try {
            if (!id.isEmpty()) {
                int result = machinTeaService.delWitherItem(id, "rolling");
                switch (result) {
                    case 200:
                        message = true;
                        data = ResultStateUtil.SUCCESS_ABNORMAL;
                        break;
                    case 101:
                        data = ResultStateUtil.FAIL_DELETE;
                        break;
                    default:
                        data = ResultStateUtil.IO_EXCEPTION;
                }
            } else {
                data = ResultStateUtil.ERROR_PARAMETER_IS_EMPTY;
            }
        } catch (Exception e) {
            e.printStackTrace();
            data = ResultStateUtil.ERROR_DATABASE_OPERATION;
        }
        return ResultMsgUtil.getResultMsg(message, data);
    }
}
