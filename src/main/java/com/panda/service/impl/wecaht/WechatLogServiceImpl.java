package com.panda.service.impl.wecaht;

import com.panda.mapper.wechat.WechatLogMapper;
import com.panda.model.wechat.WechatLog;
import com.panda.service.wechat.WechatLogService;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/11/1
 * Time: 9:46
 */
@Service
public class WechatLogServiceImpl extends AbstractServiceImpl<WechatLog> implements WechatLogService {
    @Resource
    private WechatLogMapper wechatLogMapper;

    @Override
    protected AbstractMapper<WechatLog> getAbstractMapper() {
        return wechatLogMapper;
    }
}
