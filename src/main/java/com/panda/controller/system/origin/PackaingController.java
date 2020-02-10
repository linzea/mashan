package com.panda.controller.system.origin;

import com.alibaba.citrus.util.StringEscapeUtil;
import com.alibaba.fastjson.JSON;
import com.panda.model.origin.MachinTea;
import com.panda.model.system.Dictionary;
import com.panda.model.system.Users;
import com.panda.service.commodity.ProductsService;
import com.panda.service.commodity.TagsService;
import com.panda.service.origin.AssemblySetService;
import com.panda.service.origin.HarvestRecordsService;
import com.panda.service.origin.MachinSetService;
import com.panda.service.origin.MachinTeaService;
import com.panda.service.system.DictionaryService;
import com.panda.util.DateUtil;
import com.panda.util.ResultMsgUtil;
import com.panda.util.ResultStateUtil;
import com.qiniu.util.StringUtils;
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
import java.util.*;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/12/26
 * Time: 10:53
 */
@Controller
@RequestMapping(value = "/system/packaing")
public class PackaingController {

    @Resource
    private TagsService tagsService;

    @Resource
    private DictionaryService dictionaryService;

    @Resource
    private AssemblySetService assemblySetService;

    @Resource
    private MachinTeaService machinTeaService;

    @Resource
    private ProductsService productsService;

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
     * 筛选
     *
     * @return
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @RequiresPermissions("packaing:view")//权限管理;
    public String getMachinTeaListPackaing(HttpServletRequest request, Model model) {
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        Map map = new HashMap();
        map.put("status", 1);
        List<Dictionary> machinType = dictionaryService.selectDictionaryValueList("0b9ed538-29d6-11e5-965c-000c29d7a3a0");//加工类型
        List<Dictionary> teaArrt = dictionaryService.selectDictionaryValueList("31783870-956f-469f-b43e-9fefd905afca");//茶系
        List<Dictionary> rollType = dictionaryService.selectDictionaryValueList("6d493a67-1545-4022-b7d4-2854c5b70abd");//揉捻
        List<Map> harvestList = harvestRecordsService.selectHarvestRecordsListPickNum(map); //鲜叶批次
        List<Map> productsList = productsService.selectProductsList(map); //产品
        map.put("parentId", "10000000-0000-0000-0000-000000000000");
        List<Map> assemblyList = assemblySetService.selectAssemblySetDataList(map); //生产线
        model.addAttribute("harvestList", harvestList);
        model.addAttribute("productsList",productsList);
        model.addAttribute("rollType", rollType);
        model.addAttribute("machinType", machinType);
        model.addAttribute("assemblyList", assemblyList);
        model.addAttribute("dicMacPro", "43512930-9822-48b4-b577-e900c4a12504");
        model.addAttribute("teaArrt", teaArrt);
        model.addAttribute("menuList", user.getMenuList());
        model.addAttribute("user", user);
        return "system/origin/getPackaingList";
    }

    /**
     * Ajax 获取信息列表
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/getPackaingDataList", method = RequestMethod.POST)
    @ResponseBody
    public Object getPackaingDataList(HttpServletRequest request, String datatable) {
        message = false;
        data = null;
        try {
            Map query = new HashMap();
            query.put("dicMacValue", "packaing");
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
    @RequestMapping(value = "/editPackaingItem", method = RequestMethod.POST)
    @ResponseBody
    public Object editPackaingItem(HttpServletRequest request, String id) {
        message = false;
        data = null;
        if (!id.isEmpty()) {
            try {
                Map machinTea = machinTeaService.selectMachinTeaDataByOne(id);//dicTeaType- dicTeaAttr
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
    @RequestMapping(value = "/saveOrUpdatePackaing", method = RequestMethod.POST)
    @ResponseBody
    public Object saveOrUpdatePackaing(HttpServletRequest request, MachinTea machinTea, String save) {
        String priductIdOne = request.getParameter("priductIdOne");
        String finishedQuantityOne = request.getParameter("finishedQuantityOne");
        String lastQuantityOne = request.getParameter("lastQuantityOne");
        String[] tagIdOne = request.getParameterValues("tagIdOne");
        String priductIdTwo = request.getParameter("priductIdTwo");
        String finishedQuantityTwo = request.getParameter("finishedQuantityTwo");
        String lastQuantityTwo = request.getParameter("lastQuantityTwo");
        String[] tagIdTwo = request.getParameterValues("tagIdTwo");
        String priductIdThree = request.getParameter("priductIdThree");
        String finishedQuantityThree = request.getParameter("finishedQuantityThree");
        String lastQuantityThree = request.getParameter("lastQuantityThree");
        String[] tagIdThree = request.getParameterValues("tagIdThree");
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data = null;
        try {
            if (machinTea != null) {
                if (save.equals("edit")) {
                    List<Map<String,String>> createFinished = new ArrayList<>();
                    if (priductIdOne != null && !priductIdOne.isEmpty()){
                        Map<String,String> proOne = new HashMap(4);
                        proOne.put("priductIdOne",priductIdOne);
                        proOne.put("finishedQuantityOne",finishedQuantityOne);
                        proOne.put("lastQuantityOne",lastQuantityOne);
                        proOne.put("tagIdOne",StringUtils.join(tagIdOne,","));
                        createFinished.add(proOne);
                    }
                    if (priductIdTwo != null && !priductIdTwo.isEmpty()){
                        Map<String,String> proTwo = new HashMap(4);
                        proTwo.put("priductIdTwo",priductIdTwo);
                        proTwo.put("finishedQuantityTwo",finishedQuantityTwo);
                        proTwo.put("lastQuantityTwo",lastQuantityTwo);
                        proTwo.put("tagIdTwo",StringUtils.join(tagIdTwo,","));
                        createFinished.add(proTwo);
                    }
                    if (priductIdThree != null && !priductIdThree.isEmpty()){
                        Map<String,String> proThree = new HashMap(4);
                        proThree.put("priductIdThree",priductIdThree);
                        proThree.put("finishedQuantityThree",finishedQuantityThree);
                        proThree.put("lastQuantityThree",lastQuantityThree);
                        proThree.put("tagIdThree", StringUtils.join(tagIdThree,","));
                        createFinished.add(proThree);
                    }
                    machinTea.setModifyId(user.getId());
                    machinTea.setModifyTime(new Date());
                    int insert = machinTeaService.saveOrUpdatePackageing(machinTea,createFinished);
                    switch (insert) {
                        case 403:
                            data = ResultStateUtil.CLICK_OUT_OVER;
                            break;
                        case 200:
                            message = true;
                            data = ResultStateUtil.SUCCESS_ABNORMAL;
                            break;
                        case 110:
                            data = ResultStateUtil.FAIL_TAG_INVEN;
                            break;
                        case 111:
                            data = ResultStateUtil.FAIL_PAC_INVEN;
                            break;
                        case 101:
                            data = ResultStateUtil.FAIL_ADD;
                            break;
                        default:
                            data = ResultStateUtil.FAIL_ADD;
                            break;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            data = ResultStateUtil.ERROR_DATABASE_OPERATION;
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
    @RequestMapping(value = "/delPackaingItem", method = RequestMethod.POST)
    @ResponseBody
    public Object delPackaingItem(HttpServletRequest request, String id) {
        message = false;
        data = null;
        try {
            if (!id.isEmpty()) {
                int result = machinTeaService.delWitherItem(id, "Package");
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
                        break;
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
     * 查询当前加工茶系对应的产品和标签
     * @param request
     * @param dicTeaType
     * @param dicTeaAttr
     * @return
     */
    @RequestMapping(value = "/selectProductSetOrTagsList", method = RequestMethod.POST)
    @ResponseBody
    public Object selectProductSetOrTagsList(HttpServletRequest request, String dicTeaType,String dicTeaAttr,String type) {
        message = false;
        data = null;
        try {
            if (!dicTeaAttr.isEmpty() && !dicTeaType.isEmpty()) {
                Map query = new HashMap(2);
                query.put("dicTeaType", dicTeaType);
                query.put("dicTeaAttr", dicTeaAttr);
                List<Map> list = null;
                if (type.equals("product")){
                    list = productsService.selectProductsList(query);
                }else if (type.equals("tag")) {
                    list = tagsService.selectTagsList(query);
                }else if (type.equals("all")){
                    List<Map> proList = productsService.selectProductsList(query);
                    List<Map> tagList = tagsService.selectTagsList(query);
                    if (proList != null && proList.size() > 0 && tagList != null && tagList.size() > 0 ){
                        list = proList;
                        list.addAll(tagList);
                    }
                }
                if (list != null && list.size() > 0){
                    message = true;
                    data = list;
                }else{
                    data = ResultStateUtil.NO_MORE_DATA;
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
