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
 *
 * @AUTH: Alan
 * Date: 2017/11/28
 * Time: 22:28
 */
@Controller
@RequestMapping("/system/wither")
public class WitherController {

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
     * 萎凋
     *
     * @return
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @RequiresPermissions("wither:view")//权限管理;
    public String getMachinTeaListWither(HttpServletRequest request, Model model) {
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        Map map = new HashMap();
        List<Dictionary> machinType = dictionaryService.selectDictionaryValueList("0b9ed538-29d6-11e5-965c-000c29d7a3a0");//加工类型
        List<Dictionary> teaArrt = dictionaryService.selectDictionaryValueList("31783870-956f-469f-b43e-9fefd905afca");//茶系
        List<Map> harvestQuery = harvestRecordsService.selectHarvestRecordsListPickNum(map); //鲜叶批次查询时
        map.put("status", 2);
        List<Map> harvestList = harvestRecordsService.selectHarvestRecordsListPickNum(map); //鲜叶批次新增时
        map.put("status", 1);
        map.put("parentId", "10000000-0000-0000-0000-000000000000");
        List<Map> assemblyList = assemblySetService.selectAssemblySetDataList(map); //生产线
        model.addAttribute("harvestList", harvestList);
        model.addAttribute("harvestQuery", harvestQuery);
        model.addAttribute("machinType", machinType);
        model.addAttribute("assemblyList", assemblyList);
        model.addAttribute("dicMacPro", "16595d6b-b5f0-4b49-970d-2c26c691e66a");
        model.addAttribute("teaArrt", teaArrt);
        model.addAttribute("menuList", user.getMenuList());
        model.addAttribute("user", user);
        return "system/origin/getWitherList";
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
            query.put("dicMacValue", "wither");
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
     * 根据茶系获取不同的加工步骤
     *
     * @param request
     * @param dicTeaAttr
     * @return
     */
    @RequestMapping(value = "/getMachinSetDataList", method = RequestMethod.GET)
    @ResponseBody
    public Object getMachinSetDataList(HttpServletRequest request, String dicTeaAttr, String dicMacPro, String dicMacType) {
        message = false;
        data = null;
        try {
            if (!dicTeaAttr.isEmpty()) {
                Map query = new HashMap();
                query.put("dicTeaAttr", dicTeaAttr);
                query.put("dicMacPro", dicMacPro);
                query.put("dicMacType", dicMacType);
                List<Map> machinList = machinSetService.selectMachinSetDataList(query);
                if (machinList != null && machinList.size() > 0) {
                    message = true;
                    data = machinList;
                } else {
                    data = ResultStateUtil.NO_MORE_DATA;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            data = ResultStateUtil.ERROR_QUERY + ", 未设置的组合";
        }
        return ResultMsgUtil.getResultMsg(message, data);
    }

    /**
     * 获取鲜叶的品种信息
     *
     * @param request
     * @param harvestBatchId
     * @return
     */
    @RequestMapping(value = "/getHarvestDataInfo", method = RequestMethod.GET)
    @ResponseBody
    public Object getHarvestDataInfo(HttpServletRequest request, String harvestBatchId) {
        message = false;
        data = null;
        try {
            if (!harvestBatchId.isEmpty()) {
                Map harvest = harvestRecordsService.selectHarvestCultivarName(harvestBatchId);
                if (harvest != null && harvest.size() > 0) {
                    message = true;
                    data = harvest;
                }
            } else {
                data = ResultStateUtil.ERROR_PARAMETER_IS_EMPTY;
            }
        } catch (Exception e) {
            e.printStackTrace();
            data = ResultStateUtil.ERROR_QUERY;
        }
        return ResultMsgUtil.getResultMsg(message, data);
    }

    /**
     * 获取加工步骤对应的设置项
     *
     * @param request
     * @param machinSetId
     * @return
     */
    @RequestMapping(value = "/getMachinSetDataInfo", method = RequestMethod.GET)
    @ResponseBody
    public Object getMachinSetDataInfo(HttpServletRequest request, String machinSetId) {
        message = false;
        data = null;
        try {
            if (!machinSetId.isEmpty()) {
                Map machin = sumMachinSetTime(machinSetId);
                if (machin.size() > 0) {
                    message = true;
                    data = machin;
                } else {
                    data = "未找到设置数据";
                }
            } else {
                data = ResultStateUtil.ERROR_PARAMETER_IS_EMPTY;
            }
        } catch (Exception e) {
            e.printStackTrace();
            data = ResultStateUtil.ERROR_QUERY + ", 未设置的组合";
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
    @RequestMapping(value = "/editWitherItem", method = RequestMethod.GET)
    @ResponseBody
    public Object editWitherItem(HttpServletRequest request, String id) {
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
     * 保存和编辑加工设置数据
     * 注意新增时 数据库使用了联合唯一索引,防止重复添加操作工序
     * alter ignore table e_machin_tea add unique index(process_batch_id, dic_mac_type, dic_mac_pro)
     *
     * @param request
     * @param machinTea
     * @param save
     * @return
     */
    @RequestMapping(value = "/saveOrUpdateWither", method = RequestMethod.POST)
    @ResponseBody
    public Object saveOrUpdateWither(HttpServletRequest request, MachinTea machinTea, String save) {
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data = null;
        try {
            if (machinTea != null) {
                if (save.equals("add")) {
                    machinTea.setCreateId(user.getId());
                    machinTea.setCreateTime(new Date());
                } else {
                    machinTea.setModifyId(user.getId());
                    machinTea.setModifyTime(new Date());
                }
                int insert = machinTeaService.saveOrUpdateWither(machinTea);
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
        } catch (Exception e) {
            e.printStackTrace();
            data = ResultStateUtil.ERROR_DATABASE_OPERATION + "或工序重复.";
        }
        return ResultMsgUtil.getResultMsg(message, data);
    }

    /**
     * 刪除
     *
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value = "/delWitherItem", method = RequestMethod.GET)
    @ResponseBody
    public Object delWitherItem(HttpServletRequest request, String id) {
        message = false;
        data = null;
        try {
            if (!id.isEmpty()) {
                int result = machinTeaService.delWitherItem(id, "wither");
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

    /**
     * 计算加工设置的时间差
     * @param machinSetId
     * @return
     */
    public Map sumMachinSetTime(String machinSetId) {
        Map machinSet = null;
        try {
            machinSet = machinSetService.selectMachinSetDataByOne(machinSetId);
            if (machinSet != null && machinSet.size() > 0) {
                //1分，2时，3天
                int durationType = machinSet.get("duration_type") == null ? 0 : (Integer) machinSet.get("duration_type");
                int begin_time = machinSet.get("begin_duration") == null ? 0 : (Integer) machinSet.get("begin_duration");
                int end_time = machinSet.get("end_duration") == null ? 0 : (Integer) machinSet.get("end_duration");
                if (end_time > begin_time && begin_time == 0) {
                    machinSet.put("endTime", DateUtil.nowTimeAddMinuteOrHourOrDay(new Date(), durationType, end_time));
                    machinSet.put("beginTime", DateUtil.nowTimeAddMinuteOrHourOrDay(new Date(), durationType, begin_time));
                } else if (end_time > begin_time && begin_time >= 1) {
                    machinSet.put("beginTime", DateUtil.nowTimeAddMinuteOrHourOrDay(new Date(), durationType, 1));
                    machinSet.put("endTime", DateUtil.nowTimeAddMinuteOrHourOrDay(new Date(), durationType, end_time));
                } else {
                    machinSet.put("endTime", DateUtil.nowTimeAddMinuteOrHourOrDay(new Date(), durationType, begin_time));
                    machinSet.put("beginTime", DateUtil.nowTimeAddMinuteOrHourOrDay(new Date(), durationType, end_time));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return machinSet;
    }
}
