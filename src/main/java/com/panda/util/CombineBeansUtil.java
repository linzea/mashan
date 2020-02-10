package com.panda.util;

import java.lang.reflect.Field;
import java.util.UUID;
import com.alibaba.fastjson.JSON;
import com.panda.model.system.Users;
public class CombineBeansUtil {
    /**
     *
     * @param sourceBean    被提取的对象bean
     * @param targetBean    用于合并的对象bean
     * @return targetBean,合并后的对象
     * @Title: combineSydwCore
     * @Description: 该方法是用于相同对象不同属性值的合并，如果两个相同对象中同一属性都有值，那么sourceBean中的值会覆盖tagetBean重点的值
     * @author: WangLongFei
     * @date: 2017年12月26日 下午1:53:19
     * @param sourceBean    被提取的对象bean
     * @param targetBean    用于合并的对象bean
     * @return targetBean   合并后的对象
     * @return: Object
     */
    public static Object combineSydwCore(Object sourceBean,Object targetBean){
        Class sourceBeanClass = sourceBean.getClass();
        Class targetBeanClass = targetBean.getClass();

        Field[] sourceFields = sourceBeanClass.getDeclaredFields();
        Field[] targetFields = sourceBeanClass.getDeclaredFields();
        for(int i=0; i<sourceFields.length; i++){
            Field sourceField = sourceFields[i];
            Field targetField = targetFields[i];
            sourceField.setAccessible(true);
            targetField.setAccessible(true);
            try {
                if( !(sourceField.get(sourceBean) == null) &&  !"serialVersionUID".equals(sourceField.getName().toString())){
                    targetField.set(targetBean,sourceField.get(sourceBean));
                }
            } catch (IllegalArgumentException | IllegalAccessException e) {
                e.printStackTrace();
            }
        }
        return targetBean;
    }


    //测试 combineBeans方法
    public static void main(String[] args) {
        Users sourceModel = new Users();    //    第一个对象
        Users targetModel = new Users();    //    第二个model对象

        sourceModel.setId(UUID.randomUUID().toString());
        sourceModel.setPassword("123123123");

        targetModel.setChineseName("操爷");
        targetModel.setPassword("123123123");
        targetModel.setAccount("caoyeTest");
        targetModel.setStatus(1);

        //CombineBeansUtil test = new CombineBeansUtil();
        CombineBeansUtil.combineSydwCore(sourceModel, targetModel);

        System.out.println(JSON.toJSONString(targetModel));
    }
}
