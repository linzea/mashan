package com.panda.service.impl.origin;

import com.panda.mapper.origin.OriginImgMapper;
import com.panda.model.origin.OriginImg;
import com.panda.service.origin.OriginImgService;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/12/4
 * Time: 15:15
 */
@Service
public class OriginImgServiceImpl extends AbstractServiceImpl<OriginImg> implements OriginImgService {

    @Resource
    private OriginImgMapper originImgMapper;

    @Override
    protected AbstractMapper<OriginImg> getAbstractMapper() {
        return originImgMapper;
    }
}
