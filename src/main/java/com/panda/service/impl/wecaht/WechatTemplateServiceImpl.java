package com.panda.service.impl.wecaht;

import com.panda.mapper.wechat.WechatTemplateMapper;
import com.panda.model.wechat.WechatTemplate;
import com.panda.service.wechat.WechatTemplateService;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/11/1
 * Time: 9:57
 */
@Service
public class WechatTemplateServiceImpl extends AbstractServiceImpl<WechatTemplate> implements WechatTemplateService {

    @Resource
    private WechatTemplateMapper wechatTemplateMapper;

    @Override
    protected AbstractMapper<WechatTemplate> getAbstractMapper() {
        return wechatTemplateMapper;
    }
}
