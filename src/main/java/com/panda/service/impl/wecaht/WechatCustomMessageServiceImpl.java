package com.panda.service.impl.wecaht;

import com.panda.mapper.wechat.WechatCustomMessageMapper;
import com.panda.model.wechat.WechatCustomMessage;
import com.panda.service.wechat.WechatCustomMessageService;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/11/1
 * Time: 9:44
 */
@Service
public class WechatCustomMessageServiceImpl extends AbstractServiceImpl<WechatCustomMessage> implements WechatCustomMessageService {
    @Resource
    private WechatCustomMessageMapper wechatCustomMessageMapper;

    @Override
    protected AbstractMapper<WechatCustomMessage> getAbstractMapper() {
        return wechatCustomMessageMapper;
    }
}
