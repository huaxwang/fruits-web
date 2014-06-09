package com.king.fruits.core.common.base.service;

import java.io.Serializable;

import com.king.fruits.core.common.base.service.api.ParentService;
import com.king.fruits.core.db.DBInterface;

/**
 * 版权：融贯资讯 <br/>
 * 作者：yong.li@rogrand.com <br/>
 * 生成日期：2013-11-19 <br/>
 * 描述：父接口,仅提供增删改查基本方法 
 */
public abstract class ParentServiceImpl<T extends Serializable> implements
		ParentService<T> {

	/**
	 * 获取数据操作实例,不能为空,子类必须实现该方法 
	 */
	protected abstract DBInterface<T> getDao();

	/**
	 * 根据主键删除记录
	 * 
	 * @param tid 主键id
	 * 
	 * @return 删除记录数 
	 */
	public int deleteByPrimaryKey(Integer tid) {
		return getDao().deleteByPrimaryKey(tid);
	}

    /**
     * 插入记录对象所有属性
     * 
     * @param t 记录对象
     * 
     * @return 含主键的记录对象
     */
	public T insert(T t) {
		getDao().insert(t);
		return t;
	}

    /**
     * 插入记录对象不为空的属性
     * 
     * @param t 记录对象
     * 
     * @return 含主键的记录对象
     */
	public T insertSelective(T t) {
		getDao().insertSelective(t);
		return t;
	}

    /**
     * 根据主键id查询记录对象
     * 
     * @param tid 主键id
     * 
     * @return 记录对象
     */
	public T selectByPrimaryKey(Integer id) {
		return getDao().selectByPrimaryKey(id);
	}

    /**
     * 更新记录对象不为空的属性
     * 
     * @param t 记录对象
     * 
     * @return 更新记录数
     */
	public int updateByPrimaryKeySelective(T t) {
		return getDao().updateByPrimaryKeySelective(t);
	}

    /**
     * 更新记录对象所有属性
     * 
     * @param t 记录对象
     * 
     * @return 更新记录数
     */
	public int updateByPrimaryKey(T t) {
		return getDao().updateByPrimaryKeySelective(t);
	}

}
