package com.panda.service.impl.commodity;

import com.panda.mapper.commodity.ProductsMapper;
import com.panda.model.commodity.Products;
import com.panda.service.commodity.ProductsService;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class ProductsServiceImpl extends AbstractServiceImpl<Products> implements ProductsService{

    @Resource
    private ProductsMapper productsMapper;

    @Override
    protected AbstractMapper<Products> getAbstractMapper() {
        return productsMapper;
    }

    /**
     * 查询商品信息
     * @param map
     * @return
     */
    @Override
    public List<Map> selectProductsList(Map map){
        return productsMapper.selectProductsList(map);
    }

    /**
     * 查询产品单条信息
     * @param id
     * @return
     */
    @Override
    public Map selectProductItem(String id){
        return productsMapper.selectProductItem(id);
    }

    /**
     * 获取当前批次加工完成的产品信息，并且未绑定溯源批次
     * @param harvestBatchId
     * @return
     */
    @Override
    public List<Map> selectMachinOverProductNotBindOrigin(String harvestBatchId){
        return productsMapper.selectMachinOverProductNotBindOrigin(harvestBatchId);
    }
}