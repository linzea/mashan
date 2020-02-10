package com.panda.service.impl.system;

import com.panda.service.system.PageRoleService;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import com.panda.mapper.system.MenuMapper;
import com.panda.model.system.Menu;
import com.panda.service.system.MenuService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import redis.clients.jedis.JedisPool;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IDEA.
 *
 * @AUTH: Alan
 * Date: 2017/10/21
 * Time: 18:27
 */
@Service
public class MenuServiceImpl extends AbstractServiceImpl<Menu> implements MenuService {

    private static final Logger logger = LoggerFactory.getLogger(MenuServiceImpl.class);

    @Resource
    private MenuMapper menuMapper;

    @Autowired
    private JedisPool jedisPool;

    @Value("${panda.cache.second}")
    private int second;

    @Resource
    private PageRoleService pageRoleService;

    @Override
    protected AbstractMapper<Menu> getAbstractMapper() {
        return menuMapper;
    }

    /**
     * 获取当前角色授权菜单 一维数组-供下拉列表使用
     * @param map
     * @return
     */
    @Override
    public List<Menu>selectManagerAuthMenu(Map<String,String> map){
        return menuMapper.selectManagerAuthMenu(map);
    }

    /**
     * 获取当前管理员所拥有的菜单列表 嵌套数组 -- 供 left_aside 模板使用
     * @param map
     * @return
     */
    @Override
    public List<Menu> selectManagerRoleMenuList(Map<String,String> map){
       // Jedis jedis = jedisPool.getResource();
        List<Menu> menuList = null;
        Map menuPermission = new HashMap();
        try {
//            String cacheMenuList = "manager_menu_list:"+map.get("userId");
//            byte[] byteMenuList = jedis.get(cacheMenuList.getBytes());
//            if(byteMenuList != null){
                //缓存有效
//                logger.info("------->"+cacheMenuList+" 获取缓存中的 menuList !");
//                menuList = (ArrayList) SerializeUtil.unserialize(byteMenuList);
//            }else{
                //缓存无效
                menuList = menuMapper.selectManagerRoleMenuList(map);
                if(menuList != null && menuList.size() > 0){
                    for (Menu menu: menuList) {
                        map.put("parentId",menu.getId());
                        List<Menu> childList = menuMapper.selectManagerRoleMenuList(map);
                        if(childList != null && childList.size() > 0){
                            for(Menu child: childList){
                                map.put("parentId",child.getId());
                                List<Menu> lastChild = menuMapper.selectManagerRoleMenuList(map);
                                if(lastChild != null && lastChild.size() > 0){
                                    for (Menu item : lastChild){
                                        userMenuRolePermission(menuPermission,item,map);
                                    }
                                    child.setChildMenuList(lastChild);
                                }else{
                                    userMenuRolePermission(menuPermission,child,map);
                                }
                            }
                            menu.setChildMenuList(childList);
                        }else{
                            userMenuRolePermission(menuPermission,menu,map);
                        }
                    }
                   // logger.info("------->"+cacheMenuList+" 创建 menuList 缓存数据 !");
                   // jedis.setex(cacheMenuList.getBytes(), second ,SerializeUtil.serialize(menuList));
                }
           // }
        }catch (Exception e){
            e.printStackTrace();
            logger.info("------->selectManagerRoleMenuList"+e.getMessage());
        }
        return menuList;
    }


    /**
     * 根据菜单 ID 获取 当前菜单和子菜单 shiro config init
     * @param menuId
     * @return
     */
    @Override
    public List<Menu> selectMenuAndChildMenu(String menuId){
        return menuMapper.selectMenuAndChildMenu(menuId);
    }

    /**
     * 获取当前管理员所拥有的菜单列表 嵌套数组 -- 供 left_aside 模板使用
     * @param roleId
     * @return
     */
    @Override
    public List<Menu> selectHomeMenuList(String roleId){
        Map<String, String> map = new HashMap<String, String>(3);
        map.put("roleId", roleId);
        map.put("status", "1");
        map.put("parentId", "10000000-0000-0000-0000-200000000000");
        //Jedis jedis = jedisPool.getResource();
        List<Menu> menuList = null;
        Map menuPermission = new HashMap();
        try {
//            String cacheMenuList = "home_menu_list";
//            byte[] byteMenuList = jedis.get(cacheMenuList.getBytes());
//            if(byteMenuList != null){
//            //缓存有效
//                logger.info("------->"+cacheMenuList+" 获取缓存中的 menuList !");
//                menuList = (ArrayList) SerializeUtil.unserialize(byteMenuList);
//            }else{
//                //缓存无效
                menuList = menuMapper.selectManagerRoleMenuList(map);
                if(menuList != null && menuList.size() > 0){
                    for (Menu menu: menuList) {
                        map.put("parentId",menu.getId());
                        List<Menu> childList = menuMapper.selectManagerRoleMenuList(map);
                        if(childList != null && childList.size() > 0){
                            for(Menu child: childList){
                                map.put("parentId",child.getId());
                                List<Menu> lastChild = menuMapper.selectManagerRoleMenuList(map);
                                if(lastChild != null && lastChild.size() > 0){
                                    for (Menu item : lastChild){
                                        userMenuRolePermission(menuPermission,item,map);
                                    }
                                    child.setChildMenuList(lastChild);
                                }else{
                                    userMenuRolePermission(menuPermission,child,map);
                                }
                            }
                            menu.setChildMenuList(childList);
                        }else{
                            userMenuRolePermission(menuPermission,menu,map);
                        }
                    }
//                     logger.info("------->"+cacheMenuList+" 创建 menuList 缓存数据 !");
//                     jedis.setex(cacheMenuList.getBytes(), second ,SerializeUtil.serialize(menuList));
//                }
            }
        }catch (Exception e){
            e.printStackTrace();
            logger.info("------->selectManagerRoleMenuList"+e.getMessage());
        }
        return menuList;
    }

    /**
     * 追加 菜单权限 菜单URL 为空或者菜单有子级菜单时，不处理
     * @param menu
     * @param map
     * @return
     */
    private void userMenuRolePermission(Map menuPermission, Menu menu, Map map){
        if (menu.getChildMenuList() == null && menu.getUrl() != null){
            map.put("menuId",menu.getId());
            String[] urlArr = menu.getUrl().split("/");
            if (!menuPermission.containsKey(urlArr[2])){
                List<Map> permList = pageRoleService.selectUserMenuRolePermission(map);
                if (permList != null && permList.size() > 0){
                    ArrayList per = new ArrayList();
                    for (Map item : permList){
                        per.add(urlArr[2]+":"+item.get("value"));
                        menuPermission.put(urlArr[2],menu.getId());
                    }
                    menu.setPermissionList(per);
                }
            }
        }
    }

    /**
     * Ajax 删除菜单信息 包含子级时，将权限等全部删除
     * @param id
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer delMenuParentAndChild(String id){
        Integer resultStatus = 0;
        try {
            if (!id.isEmpty()) {
                int i = menuMapper.delMenuParentAndChildRole(id);
                if (i > 0){
                    resultStatus = 200;
                } else if (i == 0) {
                    int d = menuMapper.delMenuParentAndChild(id);
                    if (d > 0){
                        resultStatus = 200;
                    }
                }
            }
        } catch (Exception e) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            e.printStackTrace();
            resultStatus = 101;
        }
        return resultStatus;
    }

    /**
     * Ajax 删除菜单信息 包含子级时，将权限等全部删除
     * @param id
     * @return
     */
    @Override
    public Integer delMenuParentAndChildRole(String id){
        Integer resultStatus = 0;
        try {
            if (!id.isEmpty()) {
                int i = menuMapper.delMenuParentAndChildRole(id);
                if (i > 0){
                    resultStatus = 200;
                }
            }
        } catch (Exception e) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            e.printStackTrace();
            resultStatus = 101;
        }
        return resultStatus;
    }
}
