package com.panda.controller.home;

import com.panda.model.commodity.Finished;
import com.panda.model.commodity.Products;
import com.panda.model.origin.MachinSet;
import com.panda.model.origin.OriginBatch;
import com.panda.model.origin.OriginCode;
import com.panda.model.system.Menu;
import com.panda.service.commodity.FinishedService;
import com.panda.service.commodity.ProductsService;
import com.panda.service.origin.OriginBatchService;
import com.panda.service.origin.OriginCodeService;
import com.panda.service.origin.QualityService;
import com.panda.service.origin.TeaGardenService;
import com.panda.service.system.MenuService;
import com.panda.util.ResultMsgUtil;
import com.panda.util.ResultStateUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLDecoder;
import java.net.URLEncoder;
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
@RequestMapping(value = "/index/traceQuery")
public class ProTraceController {

    @Resource
    private MenuService menuService;
    @Resource
    private OriginCodeService originCodeService;
    @Resource
    private ProductsService productsService;
    @Resource
    private TeaGardenService teaGardenService;
    @Resource
    private QualityService qualityService;
    @Resource
    private FinishedService finishedService;
    @Resource
    private OriginBatchService originBatchService;
    private Logger logger = LoggerFactory.getLogger(HomeController.class);

    /**
     * 溯源查询
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String proTrace(HttpServletRequest request, Model model){
        List<Menu> menuList = null;
        String  messave = request.getParameter("m");
        try {
            menuList = menuService.selectHomeMenuList("c716be42-78c2-4c80-8c88-25814b2e683b");
            model.addAttribute("menuList",menuList);
            model.addAttribute("messave",messave);
        }catch (Exception e){
            e.printStackTrace();
            logger.error("------->selectManagerRoleMenuList"+e.getMessage());
        }
        return "home/index/traceQuery";
    }

    /**
     * 溯源详情
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/proTrace",method = RequestMethod.POST)
    public String proTrace(HttpServletRequest request, HttpServletResponse response, Model model, String originCode){
        List<Menu> menuList = null;
            try {
                menuList = menuService.selectHomeMenuList("c716be42-78c2-4c80-8c88-25814b2e683b");
                if (!originCode.isEmpty()){
                    String item = originCodeService.checkOriginCode(originCode);
                    if(item != null && !item.isEmpty()){
                        OriginBatch originBatch = originBatchService.selectByPrimaryKey(item);
                        if(originBatch != null){
                            Map products =productsService.selectProductItem(originBatch.getProductId());
                            if (products != null && products.size() > 0){
                                Map query = new HashMap();
                                query.put("harvestBatchId",originBatch.getHarvestBatchId());
                                query.put("priductId",originBatch.getProductId());
                                Map finished = finishedService.selectFinishedList(query).get(0);
                                if (finished != null && finished.size() > 0){
                                    model.addAttribute("finished",finished);
                                    model.addAttribute("products",products);
                                    query.clear();
                                    query.put("id",originBatch.getTeaGardenId());
                                    Map teaGarden = teaGardenService.selectTeaGardenList(query).get(0);
                                    if (teaGarden != null && teaGarden.size() > 0){
                                        model.addAttribute("teaGarden",teaGarden);
                                    }
                                    Map quality = qualityService.selectQualityDataMap(originBatch.getQualityId());
                                    if (quality != null && quality.size() > 0){
                                        model.addAttribute("quality",quality);
                                    }
                                }
                            }
                        }
                        List<Map> InfoList = originCodeService.selectOriginCodeByInfoList(originCode);
                        if (InfoList != null && InfoList.size() > 0){
                            model.addAttribute("InfoList",InfoList);
                        }
                    }else{
                        response.sendRedirect("/index/traceQuery");
                    }
                }else{
                    response.sendRedirect("/index/traceQuery");
                }
                model.addAttribute("menuList",menuList);
            }catch (Exception e){
                e.printStackTrace();
                logger.error("------->selectManagerRoleMenuList"+e.getMessage());
            }
        return "home/index/proTrace";
    }

    /**
     * 溯源详情
     * @param request
     * @return
     */
    @RequestMapping(value = "/proTraceAjax",method = RequestMethod.POST)
    @ResponseBody
    public Object proTraceAjax(HttpServletRequest request,  String originCode){
        boolean message = false;
        Object data    = null;
        if (!originCode.isEmpty()){
            try {
                List<Map> InfoList = originCodeService.selectOriginCodeByInfoList(originCode);
                if( !InfoList.isEmpty() && InfoList.size() > 0 ){
                    message = true;
                    data = "";
                }else{
                    data = "无效的溯源档案编号";
                }
            }catch (Exception e){
                e.printStackTrace();
                data    = ResultStateUtil.ERROR_DATABASE_OPERATION;
            }
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }

    /**
     * 溯源详情
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/qrOrigin",method = RequestMethod.GET)
    public String qrOrigin(HttpServletRequest request, HttpServletResponse response, Model model, String item){
        List<Menu> menuList = null;
        try {
            menuList = menuService.selectHomeMenuList("c716be42-78c2-4c80-8c88-25814b2e683b");
            if (!item.isEmpty()){
                OriginBatch originBatch = originBatchService.selectByPrimaryKey(item);
                if(originBatch != null){
                    Map products =productsService.selectProductItem(originBatch.getProductId());
                    if (products != null && products.size() > 0){
                        Map query = new HashMap();
                        query.put("harvestBatchId",originBatch.getHarvestBatchId());
                        query.put("priductId",originBatch.getProductId());
                        Map finished = finishedService.selectFinishedList(query).get(0);
                        if (finished != null && finished.size() > 0){
                            model.addAttribute("finished",finished);
                            model.addAttribute("products",products);
                            query.clear();
                            query.put("id",originBatch.getTeaGardenId());
                            Map teaGarden = teaGardenService.selectTeaGardenList(query).get(0);
                            if (teaGarden != null && teaGarden.size() > 0){
                                model.addAttribute("teaGarden",teaGarden);
                            }
                            Map quality = qualityService.selectQualityDataMap(originBatch.getQualityId());
                            if (quality != null && quality.size() > 0){
                                model.addAttribute("quality",quality);
                            }
                        }
                    }
                }
            }
            model.addAttribute("menuList",menuList);
        }catch (Exception e){
            e.printStackTrace();
        }
        return "home/index/qrOrigin";
    }
}
