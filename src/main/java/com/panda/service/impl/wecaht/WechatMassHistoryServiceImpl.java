package com.panda.service.impl.wecaht;

import com.panda.mapper.wechat.WechatMassHistoryMapper;
import com.panda.model.wechat.WechatMassHistory;
import com.panda.service.wechat.WechatMassHistoryService;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/11/1
 * Time: 9:47
 */
@Service
public class WechatMassHistoryServiceImpl extends AbstractServiceImpl<WechatMassHistory> implements WechatMassHistoryService {

    @Resource
    private WechatMassHistoryMapper wechatMassHistoryMapper;

    @Override
    protected AbstractMapper<WechatMassHistory> getAbstractMapper() {
        return wechatMassHistoryMapper;
    }
}
