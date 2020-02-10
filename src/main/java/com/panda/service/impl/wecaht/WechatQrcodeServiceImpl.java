package com.panda.service.impl.wecaht;

import com.panda.mapper.wechat.WechatQrcodeMapper;
import com.panda.model.wechat.WechatQrcode;
import com.panda.service.wechat.WechatQrcodeService;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/11/1
 * Time: 9:51
 */
@Service
public class WechatQrcodeServiceImpl extends AbstractServiceImpl<WechatQrcode> implements WechatQrcodeService {

    @Resource
    private WechatQrcodeMapper wechatQrcodeMapper;


    @Override
    protected AbstractMapper<WechatQrcode> getAbstractMapper() {
        return wechatQrcodeMapper;
    }
}
