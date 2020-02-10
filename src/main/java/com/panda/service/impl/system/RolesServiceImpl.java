package com.panda.service.impl.system;

import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import com.panda.mapper.system.RolesMapper;
import com.panda.model.system.Roles;
import com.panda.service.system.RolesService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created with IDEA.
 *
 * @AUTH: Alan
 * Date: 2017/10/21
 * Time: 18:32
 */
@Service
public class RolesServiceImpl extends AbstractServiceImpl<Roles> implements RolesService {

    @Resource
    private RolesMapper rolesMapper;

    @Override
    protected AbstractMapper<Roles> getAbstractMapper() {
        return rolesMapper;
    }


    @Override
    public Set<String> selectUserRoleId(String userId) {
        return null;
    }

    /**
     * 获取用户角色信息
     * @param userId
     * @return
     */
    @Override
    public List<Map> selectUserRoleMap(String userId) {
        return rolesMapper.selectUserRoleMap(userId);
    }

    /**
     * 获取角色列表
     * @param map
     * @return
     */
    @Override
    public List<Roles> selectRoleList(Map map){
        return rolesMapper.selectRoleList(map);
    }
}
