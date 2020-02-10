package com.panda.service.commodity;

import com.panda.model.commodity.Products;
import com.panda.util.abs.AbstractService;

import java.util.List;
import java.util.Map;

public interface ProductsService extends AbstractService<Products>{

    /**
     * 查询商品信息
     * @param map
     * @return
     */
    List<Map> selectProductsList(Map map);

    /**
     * 查询产品单条信息
     * @param id
     * @return
     */
    Map selectProductItem(String id);

    /**
     * 获取当前批次加工完成的产品信息，并且未绑定溯源批次
     * @param harvestBatchId
     * @return
     */
    List<Map> selectMachinOverProductNotBindOrigin(String harvestBatchId);
}