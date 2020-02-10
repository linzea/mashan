package com.panda.util.abs;

import java.util.List;

/**
 * 抽象公共service实现
 * Created with IDEA.
 * User: Alan
 * Date: 2017/10/18
 * Time: 17:13
 */
public abstract class AbstractServiceImpl<T> implements AbstractService<T> {

    protected abstract AbstractMapper<T> getAbstractMapper();

    @Override
    public int deleteByPrimaryKey(String id){
        return getAbstractMapper().deleteByPrimaryKey(id);
    }


    @Override
    public int insert(T entity) {
        return getAbstractMapper().insert(entity);
    }

    @Override
    public int insertSelective(T entity){
        return getAbstractMapper().insertSelective(entity);
    }

    @Override
    public T selectByPrimaryKey(String id){
        return getAbstractMapper().selectByPrimaryKey(id);
    }

    @Override
    public List<T> selectAll(){
        return getAbstractMapper().selectAll();
    }

    @Override
    public int updateByPrimaryKey(T entity){
        return getAbstractMapper().updateByPrimaryKey(entity);
    }

    @Override
    public int updateByPrimaryKeySelective(T entity){
        return getAbstractMapper().updateByPrimaryKeySelective(entity);
    }
}
