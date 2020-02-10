package com.panda.service.origin;

import com.panda.model.origin.OriginCode;
import com.panda.util.abs.AbstractService;

import java.util.List;
import java.util.Map;

/**
 * Created with IDEA.
 *
 * @AUTH: Alan
 * Date: 2017/12/7
 * Time: 10:53
 */
public interface OriginCodeService extends AbstractService<OriginCode> {

    /**
     * 获取溯源码
     * @param map
     * @return
     */
    List<Map> selectOriginCodeDataList(Map map);

    /**
     * 批量生成溯源码
     * @param prefixVal
     * @param createNum
     * @return
     */
    Integer createOriginCodeList(String originBatchId,String prefixVal,Integer createNum);


    /**
     * 通过溯源码找到对应的批次号
      * @param originCode
     * @return
     */
    List<Map> selectOriginCodeByInfoList(String  originCode);

    /**
     * 查询溯源吗的批次ID
     * @param originCode
     * @return
     */
    String checkOriginCode(String  originCode);
}
