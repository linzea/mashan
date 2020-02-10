package com.panda.controller.system.commodity;

import com.alibaba.citrus.util.StringEscapeUtil;
import com.alibaba.fastjson.JSON;
import com.panda.controller.system.index.IndexController;
import com.panda.model.commodity.Products;
import com.panda.model.system.Dictionary;
import com.panda.model.system.Users;
import com.panda.service.commodity.PackageService;
import com.panda.service.commodity.ProductsService;
import com.panda.service.system.DictionaryService;
import com.panda.service.system.MenuService;
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
@RequestMapping(value = "/system/productSet")
public class ProductsSetController {

    @Resource
    private ProductsService productsService;

    @Resource
    private DictionaryService dictionaryService;

    @Resource
    private PackageService packageService;

    private static boolean message = false;
    private static Object  data    = null;

    /**
     * 获取产品
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/list")
    @RequiresPermissions("productSet:view")
    public String getProductSetList(HttpServletRequest request, Model model){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        Map query = new HashMap();
        List<Dictionary> teaArrt = dictionaryService.selectDictionaryValueList("31783870-956f-469f-b43e-9fefd905afca");//茶系
        List<Dictionary> treeType = dictionaryService.selectDictionaryValueList("be0ba01c-23ad-11e5-965c-000c29d7a3a0");//树种
        List<Dictionary> teaGrade= dictionaryService.selectDictionaryValueList("f63fe4f8-27ab-11e5-965c-000c29d7a3a0");//等级
        List<Dictionary> productType= dictionaryService.selectDictionaryValueList("deb3affb-5a50-428d-ade8-3abf4ef967c2");//产品类型
        query.put("status",1);
        List<Map> packList = packageService.selectPackageList(query);
        model.addAttribute("treeType",treeType);
        model.addAttribute("packList",packList);
        model.addAttribute("productType",productType);
        model.addAttribute("teaArrt",teaArrt);
        model.addAttribute("teaGrade",teaGrade);
        model.addAttribute("menuList",user.getMenuList());
        model.addAttribute("user",user);
        return "system/commodity/getProductSetList";
    }

    /**
     * 获取产品数据
     * @param request
     * @return
     */
    @RequestMapping(value = "/getProductSetDataList")
    @ResponseBody
    public Object getProductSetDataList(HttpServletRequest request, String datatable){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data    = null;
        try {
            Map map = new HashMap();
            if (datatable != null && !datatable.isEmpty()){
                String jsonStr = StringEscapeUtil.unescapeHtml(datatable);
                Map params = JSON.parseObject(jsonStr,Map.class);
                Map query = JSON.parseObject(params.get("query").toString(),Map.class);

                if (query.size() > 0 && query.get("dicTeaAttr") != ""){
                    map.put("dicTeaAttr",query.get("dicTeaAttr"));
                }
                if (query.size() > 0 && query.get("dicTeaType") != ""){
                    map.put("dicTeaType",query.get("dicTeaType"));
                }
            }
            List<Map> ProductsList = productsService.selectProductsList(map);
            if(ProductsList.size() > 0){
                message = true;
                data = ProductsList;
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
    @RequestMapping(value = "/getProductSetItem", method = RequestMethod.POST)
    @ResponseBody
    public Object getProductSetItem(HttpServletRequest request,String id){
        message = false;
        data    = null;
        try {
            if (!id.isEmpty()){
                Map products = productsService.selectProductItem(id);
                if(products != null){
                    message = true;
                    data = products;
                }else{
                    data = ResultStateUtil.ERROR_QUERY;
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            data    = ResultStateUtil.ERROR_DATABASE_OPERATION;
        }

        return ResultMsgUtil.getResultMsg(message,data);
    }

    /**
     * 保存和编辑加工设置数据
     * @param request
     * @param products
     * @param save
     * @return
     */
    @RequestMapping(value = "/saveOrUpdateProductSet",method = RequestMethod.POST)
    @ResponseBody
    public Object saveOrUpdateProductSet(HttpServletRequest request, Products products , String save){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data    = null;
        try{
            if(!products.getId().isEmpty() && save != null && save.equals("edit")){
                int i = productsService.updateByPrimaryKeySelective(products);
                if(i > 0){
                    message = true;
                    data    = ResultStateUtil.SUCCESS_UPDATE;
                }else{
                    data    = ResultStateUtil.FAIL_UPDATE;
                }
            }else if(save.equals("add")) {
                products.setId(UUID.randomUUID().toString());
                products.setCreateId(user.getId());
                products.setCreateTime(new Date());
                products.setModifyId(user.getId());
                products.setModifyTime(new Date());
                int insert = productsService.insertSelective(products);
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
    @RequestMapping(value="/delProductSetItem",method = RequestMethod.POST)
    @ResponseBody
    public Object delProductSetItem(HttpServletRequest request ,String id){
        message = false;
        data    = null;
        try{
            if (!id.isEmpty()){
                int i = productsService.deleteByPrimaryKey(id);
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
