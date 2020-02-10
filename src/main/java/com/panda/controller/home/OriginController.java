package com.panda.controller.home;

import com.panda.model.origin.AssemblySet;
import com.panda.model.origin.Equipment;
import com.panda.model.system.Menu;
import com.panda.service.origin.AssemblySetService;
import com.panda.service.origin.EquipmentService;
import com.panda.service.origin.MachinTeaService;
import com.panda.service.origin.OriginCodeService;
import com.panda.service.system.MenuService;
import com.panda.util.DateUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/10/31
 * Time: 15:25
 */
@Controller
@RequestMapping(value = "/index/origin")
public class OriginController {
    @Resource
    private EquipmentService equipmentService;

    @Resource
    private AssemblySetService assemblySetService;

    @Resource
    private MachinTeaService machinTeaService;

    @Resource
    private MenuService menuService;
    @Resource
    private OriginCodeService originCodeService;
    private Logger logger = LoggerFactory.getLogger(HomeController.class);
    /**
     * 查看生产线上的产品
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "viewAction", method = RequestMethod.GET)
    public String viewAction(HttpServletRequest request, Model model){
        String assemblId = request.getParameter("assemblId");
        String dicTeaAttr = request.getParameter("dicTeaAttr");
        String machinSetId = request.getParameter("machinSetId");
        String machineId = request.getParameter("machineId");
        List<Menu> menuList = null;
        try {
            menuList = menuService.selectHomeMenuList("c716be42-78c2-4c80-8c88-25814b2e683b");
            model.addAttribute("menuList",menuList);
            if (assemblId != null && dicTeaAttr != null && machineId != null && machinSetId != null){
                Map query = new HashMap(4);
                AssemblySet assemblySet = assemblySetService.selectByPrimaryKey(assemblId);
                if (assemblySet != null){
                    query.put("parentId",assemblId);
                    query.put("dicTeaAttr",dicTeaAttr);
                    query.put("machineId",machineId);
                    Map equipment = equipmentService.selectOriginEquipmentItemData(query);
                    if (equipment != null){
                        query.clear();
                        query.put("machinSetId",machinSetId);
                        query.put("assemblySetId",assemblId);
                        query.put("dicTeaAttr",dicTeaAttr);
                        query.put("machinStatus",1);
                        List<Map> mapList = machinTeaService.selectMachinTeaDataList(query);
                        if (mapList.size() > 0) {
                            for (Map item : mapList) {
                                String time = DateUtil.calculationSecond(item.get("begin_time").toString(), item.get("end_time").toString());
                                item.put("lostTime", time);
                            }
                            model.addAttribute("equipment", equipment);
                            model.addAttribute("mapList", mapList.get(0));
                        }
                    }else{
                        return "/404";
                    }
                }else{
                    return "/404";
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return "home/origin/viewAction";
    }
}
