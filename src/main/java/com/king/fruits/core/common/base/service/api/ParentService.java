package com.king.fruits.core.common.base.service.api;

import java.io.Serializable;


/**
 * 版权：融贯资讯 <br/>
 * 作者：yong.li@rogrand.com <br/>
 * 生成日期：2013-11-19 <br/>
 * 描述：服务父接口,仅提供增删改查基本方法 
 */
public interface ParentService<T extends Serializable> {
	
	/**
	 * 根据主键删除记录
	 * 
	 * @param tid 主键id
	 * 
	 * @return 删除记录数 
	 */
	int deleteByPrimaryKey(Integer tid);

    /**
     * 插入记录对象所有属性
     * 
     * @param t 记录对象
     * 
     * @return 含主键的记录对象
     */
    T insert(T t);

    /**
     * 插入记录对象不为空的属性
     * 
     * @param t 记录对象
     * 
     * @return 含主键的记录对象
     */
    T insertSelective(T t);

    /**
     * 根据主键id查询记录对象
     * 
     * @param tid 主键id
     * 
     * @return 记录对象
     */
    T selectByPrimaryKey(Integer tid);

    /**
     * 更新记录对象不为空的属性
     * 
     * @param t 记录对象
     * 
     * @return 更新记录数
     */
    int updateByPrimaryKeySelective(T t);

    /**
     * 更新记录对象所有属性
     * 
     * @param t 记录对象
     * 
     * @return 更新记录数
     */
    int updateByPrimaryKey(T t);
}
