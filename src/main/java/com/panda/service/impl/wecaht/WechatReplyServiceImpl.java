package com.panda.service.impl.wecaht;

import com.panda.mapper.wechat.WechatReplyMapper;
import com.panda.model.wechat.WechatReply;
import com.panda.service.wechat.WechatReplyService;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/11/1
 * Time: 9:53
 */
@Service
public class WechatReplyServiceImpl extends AbstractServiceImpl<WechatReply> implements WechatReplyService {

    @Resource
    private WechatReplyMapper wechatReplyMapper;

    @Override
    protected AbstractMapper<WechatReply> getAbstractMapper() {
        return wechatReplyMapper;
    }
}
