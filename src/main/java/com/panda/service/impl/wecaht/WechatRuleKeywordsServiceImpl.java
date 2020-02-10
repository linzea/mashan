package com.panda.service.impl.wecaht;

import com.panda.mapper.wechat.WechatRuleKeywordsMapper;
import com.panda.model.wechat.WechatRuleKeywords;
import com.panda.service.wechat.WechatRuleKeywordsService;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/11/1
 * Time: 9:54
 */
@Service
public class WechatRuleKeywordsServiceImpl extends AbstractServiceImpl<WechatRuleKeywords> implements WechatRuleKeywordsService{

    @Resource
    private WechatRuleKeywordsMapper wechatRuleKeywordsMapper;

    @Override
    protected AbstractMapper<WechatRuleKeywords> getAbstractMapper() {
        return wechatRuleKeywordsMapper;
    }
}
