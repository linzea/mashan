package com.panda.service.impl.wecaht;

import com.panda.mapper.wechat.WechatMediaMapper;
import com.panda.model.wechat.WechatMedia;
import com.panda.service.wechat.WechatMediaService;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/11/1
 * Time: 9:49
 */
@Service
public class WechatMediaServiceImpl extends AbstractServiceImpl<WechatMedia> implements WechatMediaService {

    @Resource
    private WechatMediaMapper wechatMediaMapper;

    @Override
    protected AbstractMapper<WechatMedia> getAbstractMapper() {
        return wechatMediaMapper;
    }
}
