package com.panda.service.impl.system;

import com.panda.model.system.Users;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import com.panda.mapper.system.PageRoleMapper;
import com.panda.model.system.PageRole;
import com.panda.service.system.PageRoleService;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * Created with IDEA.
 *
 * @AUTH: Alan
 * Date: 2017/10/21
 * Time: 18:29
 */
@Service
public class PageRoleServiceImpl extends AbstractServiceImpl<PageRole> implements PageRoleService {

    private static final Logger logger = LoggerFactory.getLogger(PageRoleServiceImpl.class);

    @Resource
    private PageRoleMapper pageRoleMapper;

    @Override
    protected AbstractMapper<PageRole> getAbstractMapper() {
        return pageRoleMapper;
    }

    /**
     * 获取角色对应的菜单 操作权限
     * @param map
     * @return
     */
    @Override
    public Map<String,Object> selectPageRoleListByDictionary(Map<String,Object> map){
        return pageRoleMapper.selectPageRoleListByDictionary(map);
    }

    /**
     * 新增和编辑角色权限设置
     * @param pageRole
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer saveOrUpdatePageRole(PageRole pageRole){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        Integer resultStatus = 0;
        try {
            if (pageRole != null && !pageRole.getId().equals("0") && pageRole.getStatus() != 3){
                pageRole.setStatus(pageRole.getStatus() == 2 ? pageRole.getStatus() - 1 : pageRole.getStatus() + 1);
                int i = pageRoleMapper.updateByPrimaryKeySelective(pageRole);
                if (i > 0) {
                    resultStatus = 200;
                }else{
                    resultStatus = 100;
                }
            }else if (pageRole.getRoleId() != null && pageRole.getMenuId() != null && pageRole.getStatus() == 3){
                pageRole.setId(UUID.randomUUID().toString());
                pageRole.setStatus(1);
                pageRole.setCreateId(user.getId());
                pageRole.setModifyId(user.getId());
                pageRole.setCreateTime(new Date());
                pageRole.setModifyTime(new Date());
                int i = pageRoleMapper.insertSelective(pageRole);
                if (i > 0) {
                    resultStatus = 203;
                }else{
                    resultStatus = 105;
                }
            }
        }catch (Exception e){
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            e.printStackTrace();
            logger.info("PageRoleServiceImpl------>saveOrUpdatePageRole----->" + e.getMessage());
            resultStatus = 101;
        }
        return resultStatus;
    }

    /**
     * 获取用户菜单对应的操作权限
     * @param map
     * @return
     */
    @Override
    public List<Map> selectUserMenuRolePermission(Map map){
        return pageRoleMapper.selectUserMenuRolePermission(map);
    }
}
