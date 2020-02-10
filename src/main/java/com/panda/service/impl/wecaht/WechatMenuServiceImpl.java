package com.panda.service.impl.wecaht;

import com.panda.mapper.wechat.WechatMenuMapper;
import com.panda.model.wechat.WechatMenu;
import com.panda.service.wechat.WechatMenuService;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/11/1
 * Time: 9:50
 */
@Service
public class WechatMenuServiceImpl extends AbstractServiceImpl<WechatMenu> implements WechatMenuService {

    @Resource
    private WechatMenuMapper wechatMenuMapper;

    @Override
    protected AbstractMapper<WechatMenu> getAbstractMapper() {
        return wechatMenuMapper;
    }
}
