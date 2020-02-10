package com.panda.service.impl.origin;

import com.panda.mapper.origin.QualityInfoMapper;
import com.panda.model.origin.QualityInfo;
import com.panda.service.origin.QualityInfoService;
import com.panda.service.origin.QualitySetService;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/12/28
 * Time: 10:22
 */
@Service
public class QualityInfoServiceImpl extends AbstractServiceImpl <QualityInfo> implements QualityInfoService{

    @Resource
    private QualityInfoMapper qualityInfoMapper;

    @Override
    protected AbstractMapper<QualityInfo> getAbstractMapper() {
        return qualityInfoMapper;
    }
}
