package com.panda.service.system;

import com.panda.util.abs.AbstractService;
import com.panda.model.system.Dictionary;

import java.util.List;
import java.util.Map;

/**
 * Created with IDEA.
 * @AUTH: Alan
 * Date: 2017/10/21
 * Time: 18:23
 */
public interface DictionaryService extends AbstractService<Dictionary>{

    /**
     * 获取当前字典的属性
     * @return
     */
    List<Dictionary> selectDictionaryValueList(String parentId);

    /**
     * 查询字典信息列表
     * @param map
     * @return
     */
    List<Map<String ,Object>> selectDictionaryListMap(Map<String,Object> map);

    /**
     * Group Count 字典的值
     * @param parentId
     * @return
     */
    String selectDictionaryGroupCountValueByParent(String parentId);

    /**
     * Ajax 删除字典信息 包含子级时，将全部删除
     * @param id
     * @return
     */
    Integer delDictionaryParentAndChild(String id);
}
