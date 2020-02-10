package com.panda.service.impl.wecaht;

import com.panda.mapper.wechat.WechatMapper;
import com.panda.model.wechat.Wechat;
import com.panda.service.wechat.WechatService;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/11/1
 * Time: 9:56
 */
@Service
public class WechatServiceImpl extends AbstractServiceImpl<Wechat> implements WechatService {

    @Resource
    private WechatMapper wechatMapper;

    @Override
    protected AbstractMapper<Wechat> getAbstractMapper() {
        return wechatMapper;
    }
}
