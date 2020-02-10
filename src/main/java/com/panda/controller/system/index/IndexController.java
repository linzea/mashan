package com.panda.controller.system.index;

import com.panda.model.system.Users;
import com.panda.service.commodity.FinishedOutService;
import com.panda.service.origin.HarvestRecordsService;
import com.panda.service.origin.MachinSetService;
import com.panda.service.system.MenuService;
import com.panda.util.ResultMsgUtil;
import com.panda.util.ResultStateUtil;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.ui.Model;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
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
 * Date: 2017/10/31
 * Time: 15:25
 */
@Controller
@RequestMapping(value = "/system/index")
public class IndexController {

    private static final Logger logger = LoggerFactory.getLogger(IndexController.class);

    @Resource
    private MachinSetService machinSetService;
    @Resource
    private FinishedOutService finishedOutService;

    @Resource
    private HarvestRecordsService harvestRecordsService;

    @Resource
    private MenuService menuService;
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
        DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
        CustomDateEditor dateEditor = new CustomDateEditor(fmt, true);
        binder.registerCustomEditor(Date.class, dateEditor);
    }

    /**
     * 初始化管理员菜单，存入 Redis
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String main(Model model) {
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        model.addAttribute("date", new Date());
        model.addAttribute("menuList", user.getMenuList());
        model.addAttribute("user", user);
        return "system/index/main";
    }


    /**
     * 统计成品出库
     * @param request
     * @param beginTime
     * @param endTime
     * @return
     */
    @RequestMapping(value = "/getFinishedOut", method = RequestMethod.POST)
    @ResponseBody
    public Object getFinishedOut(HttpServletRequest request, String beginTime, String endTime) {
        message = false;
        data = null;
        Map query = new HashMap();
        try {
            if (beginTime != null && !beginTime.isEmpty() && endTime != null && !endTime.isEmpty()) {
                query.put("beginTime", beginTime);
                query.put("endTime", endTime);
                List<Map<String, Object>> finiList = finishedOutService.getFinishedOutGroupByStore(query);
                if (finiList != null) {
                    query.clear();
                    List<Map<String, String>> baseList = new ArrayList<Map<String, String>>();
                    List<Map<String, String>> resultList = new ArrayList<Map<String, String>>();
                    String[] storeNameArr = null;
                    String[] storeIdArr = null;
                    String[] uOutForDayArr = null;
                    String[] accountArr = null;
                    Integer storeNum = 0;

                    for (Map item : finiList) {
                        if (item != null && item.size() > 1) {
                            if (Integer.valueOf(item.get("storeNum").toString()) > storeNum) {
                                storeNum = Integer.valueOf(item.get("storeNum").toString());
                                storeIdArr = item.get("storeId").toString().split(",");
                                accountArr = item.get("Account").toString().split(",");
                                storeNameArr = item.get("storeName").toString().split(",");
                                uOutForDayArr = item.get("uOutForDay").toString().split(",");
                                for (int i = 0; i < storeNum; i++) {
                                    Map newMap = new HashMap();
                                    query.clear();
                                    newMap.put("account", accountArr[i]);
                                    newMap.put("dateTime", item.get("dateTime"));
                                    newMap.put("name", storeNameArr[i]);
                                    newMap.put("userOutForDay", uOutForDayArr[i]);
                                    newMap.put("storeId", storeIdArr[i]);
                                    query.put("outUser", storeIdArr[i]);
                                    query.put("dateTime", item.get("dateTime"));
                                    String outTea = finishedOutService.selectStoreFinishedOutTeaType(query);
                                    if (outTea != null && !outTea.isEmpty()){
                                        newMap.put("outTea",outTea);
                                    }
                                    baseList.add(newMap);
                                }
                            }
                        }
                    }
                    for (Map item : finiList) {
                        if (item != null && item.size() > 1 && item.get("storeId") != null) {
                            storeIdArr = item.get("storeId").toString().split(",");
                            uOutForDayArr = item.get("uOutForDay").toString().split(",");
                            if (storeIdArr.length == uOutForDayArr.length && storeIdArr.length != 0) {
                                String queryArr = "";
                                List<String> storeIdListA = Arrays.asList(storeIdArr);
                                List<String> storeIdListB = new ArrayList<String>(storeIdListA);
                                List<String> uOutForDayListA = Arrays.asList(uOutForDayArr);
                                List<String> uOutForDayListB = new ArrayList<String>(uOutForDayListA);
                                int difference = storeNum - storeIdArr.length;
                                for (int j = 0; j < difference; j++) {
                                    storeIdListB.add("0");
                                    uOutForDayListB.add("0");
                                }
                                for (int u = 0; u < storeNum; u++) {
                                    for (Map base : baseList) {
                                        String[] queryArrCheck = queryArr.split(",");
                                        if (queryArr != "" && (queryArrCheck.length == storeNum)){
                                            continue;
                                        }
                                        if (base.get("storeId").equals(storeIdListB.get(u))) {
                                            Map newMap = new HashMap();
                                            query.clear();
                                            newMap.put("account", base.get("account"));
                                            newMap.put("dateTime", item.get("dateTime"));
                                            newMap.put("name", base.get("name"));
                                            newMap.put("userOutForDay", uOutForDayListB.get(u));
                                            newMap.put("storeId", base.get("storeId"));
                                            query.put("outUser", base.get("storeId"));
                                            query.put("dateTime", item.get("dateTime"));
                                            String outTea = finishedOutService.selectStoreFinishedOutTeaType(query);
                                            if (outTea != null && !outTea.isEmpty()){
                                                newMap.put("outTea",outTea);
                                            }
                                            resultList.add(newMap);
                                            queryArr +=base.get("storeId")+",";
                                        }else if (storeIdListB.get(u).equals("0") && queryArr.indexOf(base.get("storeId").toString())==-1){
                                            Map newMap = new HashMap();
                                            query.clear();
                                            newMap.put("account",base.get("account"));
                                            newMap.put("dateTime",item.get("dateTime"));
                                            newMap.put("name",base.get("name"));
                                            newMap.put("userOutForDay",uOutForDayListB.get(u));
                                            newMap.put("storeId",base.get("storeId"));
                                            query.put("outUser", base.get("storeId"));
                                            query.put("dateTime", item.get("dateTime"));
                                            String outTea = finishedOutService.selectStoreFinishedOutTeaType(query);
                                            if (outTea != null && !outTea.isEmpty()){
                                                newMap.put("outTea",outTea);
                                            }
                                            resultList.add(newMap);
                                            queryArr +=base.get("storeId")+",";
                                        }
                                    }
                                }
                            }
                        }else{
                            for (Map base : baseList) {
                                Map newMap = new HashMap();
                                newMap.put("account",base.get("account"));
                                newMap.put("dateTime",item.get("dateTime"));
                                newMap.put("name",base.get("name"));
                                newMap.put("userOutForDay",0);
                                newMap.put("storeId",base.get("storeId"));
                                resultList.add(newMap);
                            }
                        }
                    }
                    Collections.sort(resultList, new Comparator<Map<String, String>>() {
                        public int compare(Map<String, String> o1, Map<String, String> o2) {
                            return o1.get("dateTime").compareTo(o2.get("dateTime"));
                        }
                    });

                    System.out.println("排序后" + resultList);
                    message = true;
                    data = resultList;
                } else {
                    data = ResultStateUtil.ERROR_QUERY;
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
     * 统计鲜叶采摘数量
     * @param request
     * @param beginTime
     * @param endTime
     * @return
     */
    @RequestMapping(value = "/getHarvestQuality", method = RequestMethod.POST)
    @ResponseBody
    public Object getHarvestQuality(HttpServletRequest request, String beginTime, String endTime) {
        message = false;
        data = null;
        Map query = new HashMap();
        try {
            if (beginTime != null && !beginTime.isEmpty() && endTime != null && !endTime.isEmpty()) {
                query.put("beginTime", beginTime);
                query.put("endTime", endTime);
                List<Map> harvestList = harvestRecordsService.getHarvestQuality(query);
                if (harvestList != null) {
                    query.clear();
                    List<Map<String, String>> baseList = new ArrayList<Map<String, String>>();
                    List<Map<String, String>> resultList = new ArrayList<Map<String, String>>();
                    String[] nameAreaArr = null;
                    String[] areaCodeArr = null;
                    String[] recQuantityArr = null;
                    Integer areaCodeNum = 0;

                    for (Map item : harvestList) {
                        if (item != null && item.size() > 1) {
                            if (Integer.valueOf(item.get("areaCodeNum").toString()) > areaCodeNum) {
                                areaCodeNum = Integer.valueOf(item.get("areaCodeNum").toString());
                                areaCodeArr = item.get("areaCodeArr").toString().split(",");
                                nameAreaArr = item.get("nameAreaArr").toString().split(",");
                                recQuantityArr = item.get("recQuantityArr").toString().split(",");
                                for (int i = 0; i < areaCodeNum; i++) {
                                    Map newMap = new HashMap();
                                    newMap.put("dateTime", item.get("dateTime"));
                                    newMap.put("nameArea", nameAreaArr[i]);
                                    newMap.put("recQuantity", recQuantityArr[i]);
                                    newMap.put("areaCode", areaCodeArr[i]);
                                    baseList.add(newMap);
                                }
                            }
                        }
                    }
                    for (Map item : harvestList) {
                        if (item != null && item.size() > 2) {
                            areaCodeArr = item.get("areaCodeArr").toString().split(",");
                            recQuantityArr = item.get("recQuantityArr").toString().split(",");
                            if (areaCodeArr.length == recQuantityArr.length && areaCodeArr.length != 0) {
                                String queryArr = "";
                                List<String> areaCodeListA = Arrays.asList(areaCodeArr);
                                List<String> areaCodeListB = new ArrayList<String>(areaCodeListA);
                                List<String> recQuantityListA = Arrays.asList(recQuantityArr);
                                List<String> recQuantityListB = new ArrayList<String>(recQuantityListA);
                                int difference = areaCodeNum - areaCodeArr.length;
                                for (int j = 0; j < difference; j++) {
                                    areaCodeListB.add("0");
                                    recQuantityListB.add("0");
                                }
                                for (int u = 0; u < areaCodeNum; u++) {
                                    for (Map base : baseList) {
                                        String[] queryArrCheck = queryArr.split(",");
                                        if (queryArr != "" && (queryArrCheck.length == areaCodeNum)){
                                            continue;
                                        }
                                        if (base.get("areaCode").equals(areaCodeListB.get(u))) {
                                            Map newMap = new HashMap();
                                            newMap.put("dateTime", item.get("dateTime"));
                                            newMap.put("name", base.get("nameArea"));
                                            newMap.put("userOutForDay", recQuantityListB.get(u));
                                            newMap.put("account", base.get("areaCode"));
                                            resultList.add(newMap);
                                            queryArr +=base.get("areaCode")+",";
                                        }else if (areaCodeListB.get(u).equals("0") && queryArr.indexOf(base.get("areaCode").toString())==-1){
                                            Map newMap = new HashMap();
                                            newMap.put("name",base.get("nameArea"));
                                            newMap.put("userOutForDay",recQuantityListB.get(u));
                                            newMap.put("dateTime",item.get("dateTime"));
                                            newMap.put("account",base.get("areaCode"));
                                            resultList.add(newMap);
                                            queryArr +=base.get("areaCode")+",";
                                        }
                                    }
                                }
                            }
                        }else{
                            for (Map base : baseList) {
                                Map newMap = new HashMap();
                                newMap.put("name",base.get("nameArea"));
                                newMap.put("userOutForDay",0);
                                newMap.put("dateTime",item.get("dateTime"));
                                newMap.put("account",base.get("areaCode"));
                                resultList.add(newMap);
                            }
                        }
                    }

                    Collections.sort(resultList, new Comparator<Map<String, String>>() {
                        public int compare(Map<String, String> o1, Map<String, String> o2) {
                            return o1.get("dateTime").compareTo(o2.get("dateTime"));
                        }
                    });

                    System.out.println("排序后" + resultList);
                    message = true;
                    data = resultList;
                } else {
                    data = ResultStateUtil.ERROR_QUERY;
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
     * 统计茶叶加工进度比
     * @param request
     * @param beginTime
     * @param endTime
     * @return
     */
    @RequestMapping(value = "/getHarvestMachin", method = RequestMethod.POST)
    @ResponseBody
    public Object getHarvestMachin(HttpServletRequest request, String beginTime, String endTime){
        message = false;
        data = null;
        Map query = new HashMap();
        try {
            if (beginTime != null && !beginTime.isEmpty() && endTime != null && !endTime.isEmpty()) {
                query.put("beginTime", beginTime+" 00:00:00");
                query.put("endTime", endTime+" 23:59:59");
                List<Map> hareList = harvestRecordsService.getHarvestMachin(query);
                if (hareList != null && hareList.size() > 0){
                    for (Map item : hareList){
                        if (Integer.valueOf(item.get("machinNum").toString()) > 0){
                            int s = machinSetService.countMachinSetDicTeaAttrNum(item.get("dic_tea_attr").toString());
                            item.put("baseNum",s);
                        }else{
                            item.put("baseNum",13);
                            item.put("machinNum",0);
                        }
                    }
                }
                message = true;
                data = hareList;
            }
        } catch (Exception e) {
            e.printStackTrace();
            data = ResultStateUtil.ERROR_DATABASE_OPERATION;
        }
        return ResultMsgUtil.getResultMsg(message, data);
    }
}
